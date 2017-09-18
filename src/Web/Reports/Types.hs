{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TemplateHaskell #-}
module Web.Reports.Types(
    WorkItemName
  , WorkItemTag
  , WorkItemTicket
  , WorkItem(..)
  , workItemName
  , workItemTag
  , workItemTicket
  , workItemValue
  , workItemDay
  ) where

import Data.Text
import Data.Time
import GHC.Generics
import Web.Reports.Aeson

-- | Descriptive work item name
type WorkItemName = Text

-- | Short tag name of work item
type WorkItemTag = Text

-- | VCS ticket for work item
type WorkItemTicket = Text

-- | Holds info about single continuous work interval
data WorkItem =
  -- | Simple tracking
    WorkAmount {
      workAmountName   :: WorkItemName -- ^ Descriptive name
    , workAmountTag    :: WorkItemTag -- ^ Short tag for easy tracking
    , workAmountTicket :: Maybe WorkItemTicket -- ^ VCS ticket tag
    , workAmountValue  :: NominalDiffTime -- ^ Amount of time spent
    , workAmountDay    :: Maybe Day -- ^ Binding to date
    }
  -- |
  | WorkInterval {
      workIntervalName    :: WorkItemName -- ^ Descriptive name
    , workIntervalTag     :: WorkItemTag -- ^ Short tag for easy tracking
    , workIntervalTicket  :: Maybe WorkItemTicket -- ^ VCS ticket tag
    , workIntervalStart   :: UTCTime -- ^ Start of work
    , workIntervalEnd     :: UTCTime -- ^ End of work
    , workIntervalPenalty :: NominalDiffTime -- ^ Amount of spoiled time subtracted from interval
    }
    deriving (Eq, Ord, Show, Generic)

deriveJSON defaultOptions ''WorkItem

-- | Get descriptive item name
workItemName :: WorkItem -> WorkItemName
workItemName WorkAmount{..} = workAmountName
workItemName WorkInterval{..} = workIntervalName

-- | Get item short tag
workItemTag :: WorkItem -> WorkItemTag
workItemTag WorkAmount{..} = workAmountTag
workItemTag WorkInterval{..} = workIntervalTag

-- | Get VCS ticket for work item
workItemTicket :: WorkItem -> Maybe WorkItemTicket
workItemTicket WorkAmount{..} = workAmountTicket
workItemTicket WorkInterval{..} = workIntervalTicket

-- | Get total work time for item
workItemValue :: WorkItem -> NominalDiffTime
workItemValue WorkAmount{..} = workAmountValue
workItemValue WorkInterval{..} = diffUTCTime workIntervalEnd workIntervalStart - workIntervalPenalty

-- | Get work item date
workItemDay :: WorkItem -> Maybe Day
workItemDay WorkAmount{..} = workAmountDay
workItemDay WorkInterval{..} = Just $ utctDay workIntervalStart

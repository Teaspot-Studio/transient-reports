module Web.Reports(
    app
  ) where

import Reflex.Dom
import Web.Reports.API

app :: IO ()
app = mainWidget $ pure ()

-- | Widget that allows to add new work items. Fires event with new work item,
-- when user is done with filling needed values.
workItemCreator :: MonadWidget t m => m (Event t WorkItem)
workItemCreator = pure never

Flows are classified between ligthning flows and process builders for clarification. Besides, we can optionally use the `LF_` and `PB_` prefixes respectively, but it is discouraged since normally we will never create new Process Builders. Optionally, they can be classified in subfolder based on their type (platform-event-triggered, record-triggered, screen, scheduled).


Custom Metadata records are classified in subfolders, where each record is placed into the folder corresponding to its Custom Metadata Type. In the case for example of Trigger_Action, we should also use an additional level of subfolders to group the different Trigger_Actions Custom Metadata Records by its Object Type, for example, Account, Contanct:

core/<br/>
|- main/<br/>
|--- default/<br/>
|----- customMetadata/<br/>
|------- Trigger_Action/<br/>
|--------- Account/<br/>
|----------- Trigger_Action.MyTriggerAction1.md-meta<br/>
|--------- Contact/<br/>
|----------- Trigger_Action.MyTriggerAction2.md-meta<br/>
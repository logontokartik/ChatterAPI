public with sharing class ChatterController {
	
	public String collaborationGroupId {get;set;}
	
	// Get the existing groups and if none found, create one
	public ChatterController() {
		
		try {
			CollaborationGroup cg = [Select Id from CollaborationGroup LIMIT 1];
			collaborationGroupId = cg.Id;	
		} catch (Exception e) {
			CollaborationGroup gr = new CollaborationGroup();
        	gr.Name = 'Chatter Sample Group';
        	gr.Description = 'Sample Group Created via Chatter Page';
        	gr.OwnerId = UserInfo.getUserId();
        	gr.CollaborationType = 'public';
        	insert gr;
        	collaborationGroupId = gr.Id;
		}
	}
}	
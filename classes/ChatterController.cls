public with sharing class ChatterController {
	
	public String collaborationGroupId {get;set;}
	public ChatterController() {

		CollaborationGroup cg = [Select Id from CollaborationGroup LIMIT 1];
		collaborationGroupId = cg.Id;	
	}
}
/**
 * -----------------------------------------------------------------------------
 * Controller class for chatter_feed Visualforce Component
 * @author Kartik Viswanadha
 * Demo to MJ
 * -----------------------------------------------------------------------------
 **/
global with sharing class ChatterFeedController {
	
	
	public Id   m_subjectid                 {get;set;}
	public Id   m_communityid  				{get;set;}

	public ChatterFeedController() {
		
	}

	public ConnectApi.FeedElementPage getFeedElementPage() {
        
        if (String.isBlank(m_subjectid)) {
            m_subjectid = 'me';
        }

        ConnectApi.FeedElementPage fElement =  ConnectApi.ChatterFeeds.getFeedElementsFromFeed(m_communityid,ConnectApi.FeedType.Record,m_subjectid); 
        System.debug(JSON.serializePretty(fElement));
        return fElement;
    }

    public static final String communityId = Network.getNetworkId(); 

    @RemoteAction
    global static List<User> getUsers(String searchString) {
    	// Adding a where clause for SearchString TODO
    	List<User> users = [Select Id, Name, Email, FirstName, LastName, Username, Phone, SmallPhotoUrl from User];
    	return users;
    }

    @RemoteAction
    global static ConnectApi.FeedElementPage getFeedData(String groupId) {
    	//TODO check to see if FeedElementPage has limits
        ConnectApi.FeedElementPage feedElementPage =  ConnectApi.ChatterFeeds.getFeedElementsFromFeed(communityId,ConnectApi.FeedType.Record,groupid); 
        System.debug(JSON.serializePretty(feedElementPage));
    	return feedElementPage;
    }

    @RemoteAction
    global static ConnectApi.FeedElementPage postFeedData(String groupId, String textInput) {
    	ConnectApi.ChatterFeeds.postFeedElement(communityId, groupId, ConnectApi.FeedElementType.FeedItem,textInput); 
    	return getFeedData(groupId);
    }

    @RemoteAction
    global static ConnectApi.FeedElementPage postCommentData(String groupId, String feedElementId, String textInput) {
    	ConnectApi.ChatterFeeds.postCommentToFeedElement(communityId, feedElementId, textInput);
    	return getFeedData(groupId);
    }

    @RemoteAction
    global static ConnectApi.FeedElementPage likeFeedItem(String groupId,String feedElementId) {
    	ConnectApi.ChatterFeeds.likeFeedElement(communityId, feedElementId);
    	return getFeedData(groupId);
    }

    @RemoteAction
    global static ConnectApi.FeedElementPage unlikeFeedItem(String groupId,String likeId) {
    	ConnectApi.ChatterFeeds.deleteLike(communityId, likeId);
    	return getFeedData(groupId);
    }

}
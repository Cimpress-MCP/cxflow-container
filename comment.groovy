String branch = request.getBranch();
String commitHash= request.getHash();
String cxComment = 'Branch: ' + branch + ' - Commit Hash: ' + commitHash ;
return cxComment;

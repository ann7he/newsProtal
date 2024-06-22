
export class News {
  newsID: number
  title: string
  content: string //新闻内容
  publishTime:string
  newsTypeID:number//新闻分类
  views:number
  likes:number
  commentsCount: number //评论数量
  status: number
  imageURL: string

  constructor( newsID: number, title: string, content: string,  publishTime:string, newsTypeID:number, views:number
  ,likes:number,commentsCount: number,status: number,imageURL: string) {
    this.newsID = newsID
    this.title = title
    this.content = content
    this.publishTime = publishTime
    this.newsTypeID = newsTypeID
    this.views = views
    this.likes = likes
    this.commentsCount = commentsCount
    this.status = status
    this.imageURL = imageURL
  }
}


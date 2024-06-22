import { News } from '../model/News';
import http from '@ohos.net.http';

class NewsModel {
  baseURL: string = 'http://localhost:8081';
  page: number = 1;

  getNewsList(): Promise<News[]> {
    return new Promise((resolve, reject) => {
      const httpRequest = http.createHttp();
      const url = `${this.baseURL}/news/all?page=${(this.page)}&size=20`;

      httpRequest.request(url, {
        method: http.RequestMethod.GET,
      })
        .then((resp) => {
          if (resp.responseCode === 200) {
            try {
              const result = JSON.parse(resp.result.toString());
              const newsList = result.records.map((news: News) => {
                console.log('Before:', news.imageURL);
                if (news.imageURL) {
                  news.imageURL = encodeURIComponent(news.imageURL);
                }
                console.log('After:', news.imageURL);
                return news;
              });

              resolve(newsList);
            } catch (parseError) {
              reject('解析响应数据失败');
            }
          } else {
            reject(`请求失败，状态码： ${resp.responseCode}`);
          }
        })
        .catch((error) => {
          reject(`网络请求失败: ${error.message}`);
        })
        .finally(() => {
          // Optional: Release resources or close connection
          httpRequest.destroy();
        });
    });
  }
}

const newsModel = new NewsModel();

export default newsModel;

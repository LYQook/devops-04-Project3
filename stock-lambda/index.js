const axios = require('axios').default

const consumer = async (event) =>{

  for (const record of event.Records) {
    
    console.log(`body로 전달받은 데이터 확인 : ${record.body}`);
    const json = JSON.parse(record.body).MessageAttributes
    
    console.log(`필요 데이터 : ${JSON.stringify(json)}`);
    console.log(`요청자 : ${json.MessageAttributeRequester.Value}`);
    console.log(`물건 아이디 : ${json.MessageAttributeProductId.Value}`);
    console.log(`공장 아이디 : ${json.MessageAttributeFactoryId.Value}`);
    console.log(`수량 : ${json.MessageAttributeProductCnt.Value}`);    
    
    const payload = {
      MessageGroupId: 'stock-arrival-group',
      MessageAttributeProductId: json.MessageAttributeProductId.Value,
      MessageAttributeProductCnt: json.MessageAttributeProductCnt.Value,
      MessageAttributeFactoryId: json.MessageAttributeFactoryId.Value,
      MessageAttributeRequester: json.MessageAttributeRequester.Value,
      CallbackUrl: 'https://hk6rw1m3qg.execute-api.ap-northeast-2.amazonaws.com/product/donut',
    };    

    axios.post('http://project3-factory.coz-devops.click/api/manufactures', payload)
    .then(function (response) {
      console.log(response);
    })
    .catch(function (error) {
      console.log(error);
    });

  }
};

module.exports = {
  consumer,
};

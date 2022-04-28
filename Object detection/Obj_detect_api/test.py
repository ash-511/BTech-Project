try:
  from app import app
  import unittest
except Exception as e:
  print ("Some modules are missing{}".format(e))

class FlaskTest(unittest.TestCase):
  def test_index(self): #checks if request is sent to the api
    tester=app.test_client(self)
    response=tester.get('/upload')
    statuscode=response.status_code
    self.assertEqual(statuscode,200)

  def test_index_application(self): #checks if content returned is application/json 
    tester=app.test_client(self)
    response=tester.get('/upload')
    self.assertEqual(response.content_type,'application/json')

  def test_index_data(self): #checks for data return
    tester=app.test_client(self)
    response=tester.get('/upload')
    self.assertTrue(b'detections' in response.data)

if __name__=='__main__':
  unittest.main()

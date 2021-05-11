using UnityEngine;

public class AppleBox : MonoBehaviour
{
    public int life;
    public Apple apple;
    public GameObject crateBreakSound;

    private void OnCollisionEnter(Collision collision)
    {
        if(collision.gameObject.tag == "Player")
        {
            var ap = Instantiate(apple);
            ap.transform.position = this.transform.position;
            life--;
            if (life <= 0)
            {
                Destroy(this.gameObject);
                Destroy(Instantiate(crateBreakSound), 2f);
            }
        }

    }
}

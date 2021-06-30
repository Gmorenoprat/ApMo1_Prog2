using UnityEngine;
using System.Collections;

public class DamangerCollider : MonoBehaviour
{
    public int damage;
    public float knockback = 20f;
    public bool isLoadCheck = false;

    public void OnCollisionEnter(Collision collision)
    {
        if (collision.gameObject.tag == "Player")
        {
            collision.gameObject.GetComponent<Player>().GetHit(damage);
            Knockback(collision);

            if(isLoadCheck == true)
            {
                collision.gameObject.GetComponent<Player>().LoadCheckPoint();
            }
        }
    }

    public void Knockback(Collision collision)
    {
        Vector3 direction =collision.transform.position - transform.position;
        direction.y = 0.5f;
        collision.gameObject.GetComponent<Rigidbody>().AddForce(direction.normalized * knockback, ForceMode.Impulse);
    }

}

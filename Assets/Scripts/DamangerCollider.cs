using UnityEngine;

public class DamangerCollider : MonoBehaviour
{
    public int damage;
    public float knockback = 20f;
    public void OnCollisionEnter(Collision collision)
    {
        if (collision.gameObject.tag == "Player")
        {
            collision.gameObject.GetComponent<Player>().GetHit(damage);
            Knockback(collision);
        }
    }

    public void Knockback(Collision collision)
    {
        Vector3 direction =collision.transform.position - transform.position;
        direction.y = 0.5f;
        collision.gameObject.GetComponent<Rigidbody>().AddForce(direction.normalized * knockback, ForceMode.Impulse);
    }
}

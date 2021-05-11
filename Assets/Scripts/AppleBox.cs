using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AppleBox : MonoBehaviour
{
    public int life;
    public GameObject apple;
    public Transform spawn;
    public MeshRenderer mesh;

    public void Start()
    {
        mesh = GetComponent<MeshRenderer>();
    }

    private void OnCollisionEnter(Collision collision)
    {
        if(collision.gameObject.tag == "Player")
        {
            life--;
            if (life <= 0)
            {
                DestroyAndReward();
            }
        }
        
    }

    public void DestroyAndReward()
    {
        mesh.enabled = false;
        Instantiate<GameObject>(apple, transform.position, Quaternion.identity);
    }
}

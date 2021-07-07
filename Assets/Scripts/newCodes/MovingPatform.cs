using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MovingPatform : MonoBehaviour
{
    public float speed = 2;
    public Transform pos1, pos2;
    public GameObject player;

    /// <summary>
    /// @Author: Robert Juan Ignacio
    /// </summary>
    void Update()
    {
        Move();
    }

    public void Move()
    {
        transform.position += speed * Time.deltaTime * transform.forward;
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject == pos1.gameObject)
        {
            speed = -2;
        }
        if (other.gameObject == pos2.gameObject)
        {
            speed = 2;
        }
        if(other.gameObject == player)
        {
            player.transform.parent = transform;
        }

    }

    private void OnTriggerExit(Collider other)
    {
        if (other.gameObject == player)
        {
            player.transform.parent = null;
        }
    }
}

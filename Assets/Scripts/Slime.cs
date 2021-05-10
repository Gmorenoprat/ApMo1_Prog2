using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Slime : Enemy
{

    public Transform pos1, pos2;
    Transform target;

    public override void Move()
    {
        if(canMove)
         transform.position = Vector3.Lerp(pos1.position, pos2.position, Mathf.PingPong(Time.time * speed, 1.0f));

    }

    public override void OnTriggerEnter(Collider other)
    {
        base.OnTriggerEnter(other);

        if(other.gameObject == pos1.gameObject)
        {
            Debug.Log("1");
            transform.LookAt(pos2);
        }
        if(other.gameObject == pos2.gameObject)
        {
            Debug.Log("2");
            transform.LookAt(pos1);
        }
    }
    // Update is called once per frame
    void Update()
    {
        Move();
      
    }


    private void OnDrawGizmos()
    {
        Gizmos.DrawLine(pos1.position, pos2.position);
    }

}

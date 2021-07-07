using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FallingPlatform : MonoBehaviour
{
    Vector3 iniPosition;
    public bool isFalling = false;
    public float downSpeed;

    private void Awake()
    {
        iniPosition = this.transform.position;
    }

    void Update()
    {
        Move();
    }

    public void Activate()
    {
        isFalling = true;
    }

    public void Move()
    {
        if (isFalling)
        {
            transform.position += downSpeed * Time.deltaTime * Vector3.down;
        }
    }

    public void Destroy()
    {
        Destroy(this.gameObject);
    }
}

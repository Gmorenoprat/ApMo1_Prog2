using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(DamangerCollider))]
public class Boulder : MonoBehaviour
{

    protected Rigidbody _rb;
    public float speed = 4f;
    public float rotationSpeed = 5f;
    public bool canMove = true;
    public Animator anim;
    AudioSource _movingSound;

    public void Awake()
    {
        _rb = this.GetComponent<Rigidbody>();
        _movingSound = this.GetComponent<AudioSource>();
    }
    void Update()
    {
        Move();
    }
    public void Activate()
    {
        canMove = true;
    }
    public void Move() {
        if (canMove)

            _rb.AddForce(Vector3.forward * speed);
           // transform.position += speed * Time.deltaTime * Vector3.forward;
            transform.Rotate(Vector3.right, rotationSpeed);
    }
    public void Destroy()
    {
        Destroy(this.gameObject);
    }

}

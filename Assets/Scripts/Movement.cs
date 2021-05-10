using UnityEngine;
using System.Collections;

public class Movement
{
    Player _player;
    Rigidbody _rb;
    float _jumpForce = 10f;
    float _speed = 6f;
    public float turnSmoothTime = 0.1f;
    float turnSmoothVelocity;

    public float speedForward = 6f;
    public float speedRight = 6f;
    public float rotSpeed = 6f;


    public Movement(Player p)
    {
        _player = p;
        _rb = _player.GetComponent<Rigidbody>();
    }

    public void Jump()
    {
        if (!_player.IsGrounded) return;
        _player.IsGrounded = false;
        float jumpForce = _jumpForce;
        Vector2 force = new Vector2(0, jumpForce);
        _rb.AddForce(force, ForceMode.Impulse);
    }

    public void Move(float v, float h)
    {
         _rb.velocity = new Vector3(h * _speed, _rb.velocity.y, v * _speed);


        Vector3 direction = new Vector3(h, 0, v).normalized;


        if (direction.magnitude >= 0.1f)
        {
            float targetAngle = Mathf.Atan2(direction.x, direction.z) * Mathf.Rad2Deg;
            float angle = Mathf.SmoothDampAngle(_player.GetComponent<Transform>().eulerAngles.y, targetAngle, ref turnSmoothVelocity, turnSmoothTime);
            _player.GetComponent<Transform>().rotation = Quaternion.Euler(0f, angle, 0f);
        }

    }
}
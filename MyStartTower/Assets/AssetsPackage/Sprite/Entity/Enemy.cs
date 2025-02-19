using UnityEngine;

public class Enemy : MonoBehaviour, IDamageable
{
    public int health = 100;
    public bool isPoisoned = false;
    public float poisonDamagePerSecond = 0f;
    public float poisonTimer = 0f;
    public float slowAmount = 1f; // 1表示没有减速，小于1表示减速
    public float moveSpeed = 5f;

    private void Update()
    {
        // 处理中毒效果
        if (isPoisoned)
        {
            poisonTimer += Time.deltaTime;
            if (poisonTimer >= 1f) // 每秒检查一次
            {
                TakeDamage((int)poisonDamagePerSecond);
                poisonTimer -= 1f;
            }

            // 应用减速效果（这里简化处理为直接修改移动速度）
            if (slowAmount < 1f)
            {
                transform.Translate(Vector3.forward * moveSpeed * slowAmount * Time.deltaTime);
            }
            else
            {
                transform.Translate(Vector3.forward * moveSpeed * Time.deltaTime);
            }
        }
        else
        {
            transform.Translate(Vector3.forward * moveSpeed * Time.deltaTime);
        }

        // 检查是否死亡
        if (health <= 0)
        {
            Die();
        }
    }

    public void TakeDamage(int damage)
    {
        health -= damage;
    }

    public void ApplyPoisonEffect(float damagePerSecond, float duration)
    {
        isPoisoned = true;
        poisonDamagePerSecond = damagePerSecond;
        // 这里可以添加逻辑来设置一个定时器在duration秒后清除中毒效果
        // 或者使用协程来处理
    }

    public void ApplySlowEffect(float slowAmount)
    {
        this.slowAmount = slowAmount;
    }

    private void Die()
    {
        Destroy(gameObject);
    }
}
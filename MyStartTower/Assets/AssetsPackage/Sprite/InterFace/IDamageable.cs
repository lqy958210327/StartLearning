public interface IDamageable
{
    void TakeDamage(int damage);
    void ApplyPoisonEffect(float damagePerSecond, float duration);
    void ApplySlowEffect(float slowAmount);
}
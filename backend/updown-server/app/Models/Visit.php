<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Visit extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     */
    protected $fillable = [
        'user_id',
        'visitor_email',
        'code',
        'expiry_date',
    ];


    /**
     * Get the user that owns the Visit
     */
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }
}

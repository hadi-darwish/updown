<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;


class Travel extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     */
    protected $fillable = [
        'user_id',
        'apartment_id',
        'date',
    ];

    /**
     * The attributes that should be hidden for serialization.
     */
    protected $hidden = [
        'user_id',
        'apartment_id',
    ];

    /**
     * Get the user that owns the Travel
     */

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    /**
     * Get the apartment that owns the Travel
     */

    public function apartment(): BelongsTo
    {
        return $this->belongsTo(Apartment::class);
    }
}

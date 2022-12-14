<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;


class Travel extends Model
{
    use HasFactory;
    protected $table = 'travels';

    /**
     * The attributes that are mass assignable.
     */
    protected $fillable = [
        'user_id',
        'apartment_id',
        'from_floor',
        'to_floor',
    ];

    /**
     * The attributes that should be hidden for serialization.
     */


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

    public function getDate(): string
    {
        return $this->date;
    }
}

<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class ResidesIn extends Model
{

    use HasFactory;
    protected $table = 'resides_in';
    /**
     * The attributes that are mass assignable.
     */

    protected $fillable = [
        'user_id',
        'apartment_id',
    ];

    /**
     * The attributes that should be hidden for serialization.
     */
    protected $hidden = [];

    /**
     * The attributes that should be cast.
     */
    protected $casts = [];

    /**
     * Get the user that owns the ResidesIn
     */
    public function user()
    {
        return $this->belongsTo(User::class);
    }

    /**
     * Get the apartment that owns the ResidesIn
     */
    public function apartment(): BelongsTo
    {
        return $this->belongsTo(Apartment::class);
    }
}

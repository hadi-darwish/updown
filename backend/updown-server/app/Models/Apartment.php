<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\BelongsToManyRelationship;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;


class Apartment extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     */
    protected $fillable = [
        'number',
        'floor',
        'building_id',
        'owner_id',
        'is_paid',
        'is_banned',
    ];

    /**
     * The attributes that should be hidden for serialization.
     */
    protected $hidden = [];


    /**
     * The attributes that should be cast.
     */
    protected $casts = [
        'is_paid' => 'boolean',
        'is_banned' => 'boolean',
    ];

    /**
     * Get the building that has the Apartment
     */
    public function building(): BelongsTo
    {
        return $this->belongsTo(Building::class);
    }

    /**
     * Get the user that owns the Apartment
     */

    public function owner(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }


    public function travels(): HasMany
    {
        return $this->hasMany(Travel::class);
    }
    public function visits(): HasMany
    {
        return $this->hasMany(Visit::class);
    }
}

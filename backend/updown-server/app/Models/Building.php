<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;


class Building extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     */
    protected $fillable = [
        'name',
        'address',
        'number_of_floors',
        'number_of_apartments',
        'is_paid',
        'is_banned',
        'owner_id',
        'is_on',

    ];



    /**
     * The attributes that should be cast.
     */
    protected $casts = [
        'is_paid' => 'boolean',
        'is_banned' => 'boolean',
    ];

    /**
     * Get the user that owns the Building
     */
    public function owner(): BelongsTo

    {
        return $this->belongsTo(User::class);
    }

    /**
     * Get the apartments for the Building
     */
    public function apartments(): HasMany
    {
        return $this->hasMany(Apartment::class);
    }

    /**
     * Get the prices for the Building
     */
    public function prices(): HasMany
    {
        return $this->hasMany(Price::class);
    }
}

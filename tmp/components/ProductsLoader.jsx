'use client'
import { useEffect } from 'react'
import { useDispatch } from 'react-redux'
import { fetchProducts } from '@/lib/features/product/productSlice'

export default function ProductsLoader() {
    const dispatch = useDispatch()

    useEffect(() => {
        // Fetch products từ API khi component mount
        dispatch(fetchProducts())
    }, [dispatch])

    return null // Component này không render gì
}


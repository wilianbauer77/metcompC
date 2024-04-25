program Heatmap
    implicit none
    real, dimension(:,:), allocatable :: f, g
    integer :: L, i, j
    real :: tol, alpha, maxi, T1, T2
    real :: l1, l2
    real :: x
    character(len=100) :: title
    
    L = 100
    allocate(f(L,L))
    allocate(g(L,L))
    tol = 0.000001
    alpha = 0.935
    l1 = 0.1
    l2 = 0.3

    call random_number(f)
    ! do i = 1, L
    !     do j = 1, L
    !         f(i, j) = 1.0*f(i, j)
    !     end do
    ! end do
    !f=1.0
    do i = 1, L
        f(i, 1) = exp(-(l1 * i))
        f(i, L) = exp(-(l2 * i))
    end do

    do i = 1, L
        f(1, i) = 1.0
        f(L, i) = 0.0
    end do
    
    g = f
    call cpu_time(T1)
    call iterate_and_save_heatmap(f, g, alpha, tol)
    call cpu_time(T2)
    print *,T2-T1
    
contains

    subroutine iterate_and_save_heatmap(f, g, alpha, tol)
        real, dimension(:,:) :: f, g
        real :: tol, alpha, maxi
        integer :: L, i, j
        character(len=100) :: title
        integer :: iter
        L = size(f, 1)
        maxi = 1.
        iter=0
        do while (maxi>tol)
           iter = iter+1
            do i = 2, L-1
                do j = 2, L-1
                    g(i, j) = -alpha*f(i,j)+(1+alpha)* (g(i-1, j) + f(i+1, j) + g(i, j-1) + f(i, j+1)) / 4.0
                end do
            end do
            maxi = 0.
            do i = 1, L
                do j = 1, L
                    maxi = max(maxi, abs(f(i, j) - g(i, j)))
                end do
            end do
            
            f = g
            print *,iter,maxi
               
            ! if (maxi <= tol) then
            !     exit
            ! end if
            
           ! write(title, "(A, I3, A, F6.4)") "Iteration ", iter, " (MaxDif: ", maxi, ")"
            ! call display_heatmap(f, title)
        end do
        
        ! Save the last heatmap to a file
        open(unit=10, file='heatmap.txt', status='unknown')
        do i = 1, L
            write(10, '(100F10.4)') (f(i,j), j=1,L)
        end do
        close(10)
    end subroutine iterate_and_save_heatmap

end program Heatmap

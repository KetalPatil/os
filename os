#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
int main()
{

	// make two process which run same
	// program after this instruction
	pid_t p = fork();
	if(p<0){
	perror("fork fail");
	exit(1);
	}
	printf("Hello world!, process_id(pid) = %d \n",getpid());
	return 0;
}


#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
int main()
{
	fork();
	fork();
	fork();
	printf("hello\n");
	return 0;
}


#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
void forkexample()
{
	pid_t p;
	p = fork();
	if(p<0)
	{
	perror("fork fail");
	exit(1);
	}
	// child process because return value zero
	else if ( p == 0)
		printf("Hello from Child!\n");

	// parent process because return value non-zero.
	else
		printf("Hello from Parent!\n");
}
int main()
{
	forkexample();
	return 0;
}


//@@@@@ C program for implementation of FCFS @@@@
// scheduling 
#include<stdio.h> 
// Function to find the waiting time for all 
// processes 
void findWaitingTime(int processes[], int n, 
						int bt[], int wt[]) 
{ 
	// waiting time for first process is 0 
	wt[0] = 0; 

	// calculating waiting time 
	for (int i = 1; i < n ; i++ ) 
		wt[i] = bt[i-1] + wt[i-1] ; 
} 

// Function to calculate turn around time 
void findTurnAroundTime( int processes[], int n, 
				int bt[], int wt[], int tat[]) 
{ 
	// calculating turnaround time by adding 
	// bt[i] + wt[i] 
	for (int i = 0; i < n ; i++) 
		tat[i] = bt[i] + wt[i]; 
} 

//Function to calculate average time 
void findavgTime( int processes[], int n, int bt[]) 
{ 
	int wt[n], tat[n], total_wt = 0, total_tat = 0; 

	//Function to find waiting time of all processes 
	findWaitingTime(processes, n, bt, wt); 

	//Function to find turn around time for all processes 
	findTurnAroundTime(processes, n, bt, wt, tat); 

	//Display processes along with all details 
	printf("Processes Burst time Waiting time Turn around time\n"); 

	// Calculate total waiting time and total turn 
	// around time 
	for (int i=0; i<n; i++) 
	{ 
		total_wt = total_wt + wt[i]; 
		total_tat = total_tat + tat[i]; 
		printf(" %d ",(i+1));
		printf("	 %d ", bt[i] );
		printf("	 %d",wt[i] );
		printf("	 %d\n",tat[i] ); 
	} 
	float s=(float)total_wt / (float)n;
	float t=(float)total_tat / (float)n;
	printf("Average waiting time = %f",s);
	printf("\n");
	printf("Average turn around time = %f ",t); 
} 

// Driver code 
int main() 
{ 
	//process id's 
	int processes[] = { 1, 2, 3}; 
	int n = sizeof processes / sizeof processes[0]; 

	//Burst time of all processes 
	int burst_time[] = {10, 5, 8}; 

	findavgTime(processes, n, burst_time); 
	return 0; 
} 

@@@@@@@sjf@@@@@@@
#include <stdio.h>
int main()
{
	// Matrix for storing Process Id, Burst
	// Time, Average Waiting Time & Average
	// Turn Around Time.
	int A[100][4];
	int i, j, n, total = 0, index, temp;
	float avg_wt, avg_tat;
	printf("Enter number of process: ");
	scanf("%d", &n);
	printf("Enter Burst Time:\n");
	// User Input Burst Time and alloting Process Id.
	for (i = 0; i < n; i++) {
		printf("P%d: ", i + 1);
		scanf("%d", &A[i][1]);
		A[i][0] = i + 1;
	}
	// Sorting process according to their Burst Time.
	for (i = 0; i < n; i++) {
		index = i;
		for (j = i + 1; j < n; j++)
			if (A[j][1] < A[index][1])
				index = j;
		temp = A[i][1];
		A[i][1] = A[index][1];
		A[index][1] = temp;

		temp = A[i][0];
		A[i][0] = A[index][0];
		A[index][0] = temp;
	}
	A[0][2] = 0;
	// Calculation of Waiting Times
	for (i = 1; i < n; i++) {
		A[i][2] = 0;
		for (j = 0; j < i; j++)
			A[i][2] += A[j][1];
		total += A[i][2];
	}
	avg_wt = (float)total / n;
	total = 0;
	printf("P	 BT	 WT	 TAT\n");
	// Calculation of Turn Around Time and printing the
	// data.
	for (i = 0; i < n; i++) {
		A[i][3] = A[i][1] + A[i][2];
		total += A[i][3];
		printf("P%d	 %d	 %d	 %d\n", A[i][0],
			A[i][1], A[i][2], A[i][3]);
	}
	avg_tat = (float)total / n;
	printf("Average Waiting Time= %f", avg_wt);
	printf("\nAverage Turnaround Time= %f", avg_tat);
}

@@@@@@@sjf@@@@@@
#include<stdio.h>
int main()
{
    int bt[20],p[20],wt[20],tat[20],i,j,n,total=0,totalT=0,pos,temp;
    float avg_wt,avg_tat;
    printf("Enter number of process:");
    scanf("%d",&n);
 
    printf("\nEnter Burst Time:\n");
    for(i=0;i<n;i++)
    {
        printf("p%d:",i+1);
        scanf("%d",&bt[i]);
        p[i]=i+1;
    }
 
    //sorting of burst times
    for(i=0;i<n;i++)
    {
        pos=i;
        for(j=i+1;j<n;j++)
        {
            if(bt[j]<bt[pos])
                pos=j;
        }
 
        temp=bt[i];
        bt[i]=bt[pos];
        bt[pos]=temp;
 
        temp=p[i];
        p[i]=p[pos];
        p[pos]=temp;
    }
 
    wt[0]=0;
 
    //finding the waiting time of all the processes
    for(i=1;i<n;i++)
    {
        wt[i]=0;
        for(j=0;j<i;j++)
             //individual WT by adding BT of all previous completed processes
            wt[i]+=bt[j];
 
        //total waiting time
        total+=wt[i];   
    }
 
    //average waiting time
    avg_wt=(float)total/n;  
 
    printf("\nProcess\t Burst Time \tWaiting Time\tTurnaround Time");
    for(i=0;i<n;i++)
    {
        //turnaround time of individual processes
        tat[i]=bt[i]+wt[i]; 
 
        //total turnaround time
        totalT+=tat[i];      
        printf("\np%d\t\t %d\t\t %d\t\t\t%d",p[i],bt[i],wt[i],tat[i]);
    }
 
    //average turnaround time
    avg_tat=(float)totalT/n;     
    printf("\n\nAverage Waiting Time=%f",avg_wt);
    printf("\nAverage Turnaround Time=%f",avg_tat);
}

@@@@@@@sjf preemptive@@@
#include<stdio.h>
struct process
{
    int WT,AT,BT,TAT;
};

struct process a[10];

int main()
{
    int n,temp[10];
    int count=0,t=0,short_P;
    float total_WT=0, total_TAT=0,Avg_WT,Avg_TAT;
    printf("Enter the number of the process\n");
    scanf("%d",&n);
    printf("Enter the arrival time and burst time of the process\n");
    printf("AT WT\n");
    for(int i=0;i<n;i++)
    {
        scanf("%d%d",&a[i].AT,&a[i].BT);
        
        // copying the burst time in
        // a temp array for the further use
        // in calculation of WT
        temp[i]=a[i].BT;
    }
    
    // we initialize the burst time
    // of a process with the maximum
    a[9].BT=10000;
    // loop will be execute until all the process
    // complete so we use count!= number of 
    // the process
    for(t=0;count!=n;t++)
    {
        // for finding min burst
        // it is useful 
        short_P=9;
        for(int i=0;i<n;i++)
        {
            if(a[i].BT<a[short_P].BT && (a[i].AT<=t && a[i].BT>0))
            {
                short_P=i;
            }
            
        }
        
        a[short_P].BT=a[short_P].BT-1;
        
        // if any process is completed
        if(a[short_P].BT==0)
        {
            // one process complete
            count++;
            a[short_P].WT=t+1-a[short_P].AT-temp[short_P];
            a[short_P].TAT=t+1-a[short_P].AT;
            
            // total calculation
            total_WT=total_WT+a[short_P].WT;
            total_TAT=total_TAT+a[short_P].TAT;
        }
        
        
        
    }
    Avg_WT=total_WT/n;
    Avg_TAT=total_TAT/n;
    
    // printing of the answer
    printf("Id WT TAT\n");
    for(int i=0;i<n;i++)
    {
        printf("%d\t%d\t%d\n",i+1,a[i].WT,a[i].TAT);
    }
    printf("Avg waiting time of the process is %f\n",Avg_WT);
    printf("Avg turn around time of the process %f\n",Avg_TAT);
    
}

@@@@@@@@@rr@@@@@@@
#include<stdio.h>
 
int main()
{
    //Input no of processed
    int  n;
    printf("Enter Total Number of Processes:");
    scanf("%d", &n);
    int wait_time = 0, ta_time = 0, arr_time[n], burst_time[n], temp_burst_time[n];
    int x = n;
 
    //Input details of processes
    for(int i = 0; i < n; i++)
    {
        printf("Enter Details of Process %d \n", i + 1);
        printf("Arrival Time:  ");
        scanf("%d", &arr_time[i]);
        printf("Burst Time:   ");
        scanf("%d", &burst_time[i]);
        temp_burst_time[i] = burst_time[i];
    }
 
    //Input time slot
    int time_slot;
    printf("Enter Time Slot:");
    scanf("%d", &time_slot);
 
    //Total indicates total time
    //counter indicates which process is executed
    int total = 0,  counter = 0,i;
    printf("Process ID       Burst Time       Turnaround Time      Waiting Time\n");
    for(total=0, i = 0; x!=0; )  
    {  
        // define the conditions
        if(temp_burst_time[i] <= time_slot && temp_burst_time[i] > 0)    
        {  
            total = total + temp_burst_time[i];  
            temp_burst_time[i] = 0;  
            counter=1;  
        }     
        else if(temp_burst_time[i] > 0)  
        {  
            temp_burst_time[i] = temp_burst_time[i] - time_slot;  
            total  += time_slot;    
        }  
        if(temp_burst_time[i]==0 && counter==1)  
        {  
            x--; //decrement the process no.  
            printf("\nProcess No %d  \t\t %d\t\t\t\t %d\t\t\t %d", i+1, burst_time[i],
                   total-arr_time[i], total-arr_time[i]-burst_time[i]);  
            wait_time = wait_time+total-arr_time[i]-burst_time[i];  
            ta_time += total -arr_time[i];  
            counter =0;     
        }  
        if(i==n-1)  
        {  
            i=0;  
        }  
        else if(arr_time[i+1]<=total)  
        {  
            i++;  
        }  
        else  
        {  
            i=0;  
        }  
    }  
    float average_wait_time = wait_time * 1.0 / n;
    float average_turnaround_time = ta_time * 1.0 / n;
    printf("\nAverage Waiting Time:%f", average_wait_time);
    printf("\nAvg Turnaround Time:%f", average_turnaround_time);
    return 0;
}


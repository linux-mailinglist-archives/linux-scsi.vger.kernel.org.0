Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D49C829C4
	for <lists+linux-scsi@lfdr.de>; Tue,  6 Aug 2019 04:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbfHFCpJ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 5 Aug 2019 22:45:09 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:18867 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728870AbfHFCpJ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 5 Aug 2019 22:45:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565059508; x=1596595508;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c2FZ48MrEXBxINcLxPQ/X8KEZTmcxS35F1nwMuPQ/Pg=;
  b=S63s/ULjGttByCqLXIK2NOs6x6UkVx3YBnLpJ9G0Ld2oBI7q0Y1H0gdJ
   Qj6ZJW94gu6hjCuy4ndkHarV0PN8xbYNgi1YYVPKWzB+fAuYJkZ6b+7Nd
   ocaODbI39stW3T+AK66E7AB7/0RufG+RPMd0l6OY92LyxPt9LxxuHTpX4
   VUTQHuE4lvAaT9wm3ZQkf+sQqUQvt0FP+bUrVRLtrcmdX0OVeXxi9Y+WL
   BytjjKx2VLhPp2QQDbOhXKEHSWfitve8yJAHPCaNebL3Gk8R7Z2H124qy
   xnbL2urrRMtNIZO4HyZBuYtDyw9/P8sqnUP3UI0+Vt9j+8Tv+Im/giagY
   g==;
IronPort-SDR: K/WXcuNFyHwsglWtlM+MZcdpIq/wgPxKI8O4GwztLydlRs77zs6WHQaF5mS5f620CF5hdnjZDx
 I72dw+meup2lQjwP+aVH7u7MkKLqeYEAIGWUCCg4BK4j2cDHiejOfH1DEVeAlV+6Akx3wo3gBn
 FqwyXRt5D3cFUDdV3o3RxzgD6UPI8BZrKZNuSXuHHFNYvziomwxVgEkFBZwE0pKbqc7eZb86gE
 cBWgCDgqwzFEq8Z7Whkg1LoY8QCyXOyH8JB40KznpF/+KsNaRd2enuiuVizIMWKLTlpLcyIbsN
 hFg=
X-IronPort-AV: E=Sophos;i="5.64,352,1559491200"; 
   d="scan'208";a="115080745"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Aug 2019 10:45:08 +0800
IronPort-SDR: KVRwWXA76MBnHnPXD2nXS+NVBeIBT49Pwfo25FokVcXujqo2fDNYdB4ZnqiTuIlXav9ckg3OJb
 zMOt2TY4PXGrvs42VV1OWQ0vP+HJdSjhgA8ifH88px72RH6s6/Mex03AlGfBTLtktWL65sqdLR
 qWptvGOtphF2bBzvK5TaslLqL0GWbdYww77cWhz1eCvhBe0hWJNp7t2DVQeTkEWX1KW+1XnaKx
 BS1hxpUuPaofrhsAgFpiki1aXdeIpkEmV1tA2HyGYc/km1JQxHrk/0pLvWVBsMhO/V+eXTUwPV
 afoEYLxgTTlXC2DHK2yZz81H
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 19:42:59 -0700
IronPort-SDR: GYKv29tAwS+pBASh8xyc3Zfaxs5ioe1NhNGS/f9Lyogdjh8gOWpGkpSduYuQlQBykeAdw4360o
 XvMyLRsPme8zR+Vs5HURsV63WYXIrE9dmYSuvhF11XZo+v3vhRDpTYzeCD62ODvT8sm8bZBm4V
 YC6vDgon/rgzTWLTobbOoVyaQueYWEWonvqGVCb9bMuazzwrUdm97jlhFb5Bvntkr5Zwg7K+W8
 xyDq09KrWRxLZhNzEUvnTQQYKU9R81bmie4dnrEUtLy+jzaXK2C7sDCviYHQva5sqy6VxjKpft
 IZE=
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.53.115])
  by uls-op-cesaip01.wdc.com with SMTP; 05 Aug 2019 19:45:08 -0700
Received: (nullmailer pid 1333208 invoked by uid 1000);
        Tue, 06 Aug 2019 02:45:05 -0000
Date:   Tue, 6 Aug 2019 11:45:05 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Mike Christie <mchristi@redhat.com>
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        Nicholas Bellinger <nab@linux-iscsi.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi: target/tcm_loop: update upper limit of LUN
Message-ID: <20190806024505.gpabcyu57vhvnrto@naota.dhcp.fujisawa.hgst.com>
References: <20190805062313.343221-1-naohiro.aota@wdc.com>
 <5D485A56.9070208@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5D485A56.9070208@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Aug 05, 2019 at 11:33:26AM -0500, Mike Christie wrote:
>On 08/05/2019 01:23 AM, Naohiro Aota wrote:
>> targetcli-fb (or its library: rtslib-fb) allows us to create LUN up to
>> 65535. On the other hand, the kernel driver is limiting max_lun to 0.
>>
>> This limitation causes an actual problem when you delete a loopback device
>> (using /sys/class/scsi_device/${lun}/device/delete) and rescan it (using
>> /sys/class/scsi_host/host${h}/scan). You can delete the device, but cannot
>> rescan it because its LUN is larger than the max_lun and so the scan
>> request results in -EINVAL error in scsi_scan_host_selected().
>
>How are you kicking off this rescan?
>
>Just to make sure I understood you, does the initial LU have LUN 0, you
>delete that, then are you creating another LU with a LUN value that is
>not 0?

Not exactly. I'm working on a case multiple device is added at once to
one loopback scsi host. You can create two or more device using
"targetcli" command and they may have their LUN larger than 0. For
example,

$ sudo targetcli
/backstores/fileio> cd /loopback
/loopback> create
Created target naa.5001405218077d66.
/loopback> exit
$ sudo truncate -s 1048576 /mnt/nvme/foo{1,2,3}
$ sudo targetcli /backstores/fileio create name=foo1 file_or_dev=/mnt/nvme/foo1
Created fileio foo1 with size 1048576
$ sudo targetcli /loopback/naa.5001405218077d66/luns create /backstores/fileio/foo1
Created LUN 0.
(Do the same above for foo2 and foo3)

Then, you'll see each of them has LUN 0, 1, 2 assigned: (rtslib scans used LUN and assign free one)

$ lsscsi
...
[7:0:1:0]    disk    LIO-ORG  foo1             4.0   /dev/sdd
[7:0:1:1]    disk    LIO-ORG  foo2             4.0   /dev/sde
[7:0:1:2]    disk    LIO-ORG  foo3             4.0   /dev/sdf

Now, you can delete one of these device:

$ echo 1 > /sys/class/scsi_device/7\:0\:1\:2/device/delete
$ lsscsi
...
[7:0:1:0]    disk    LIO-ORG  foo1             4.0   /dev/sdd
[7:0:1:1]    disk    LIO-ORG  foo2             4.0   /dev/sde

But, you cannot recover it by the scanning:

$ echo "0 1 2" > /sys/class/scsi_host/host7/scan 
-bash: echo: write error: Invalid argument

This command is failing with -EINVAL because "LUN (= 2) >= max_lun (= 0)".

and, even WILDCARD scan cannot recover it.

$ echo "0 1 -" > /sys/class/scsi_host/host7/scan
$ lsscsi
...
[7:0:1:0]    disk    LIO-ORG  foo1             4.0   /dev/sdd 
[7:0:1:1]    disk    LIO-ORG  foo2             4.0   /dev/sde 

Actually, you cannot even rescan LUN 0, at least with a specific scan:

$ echo 1 > /sys/class/scsi_device/7\:0\:1\:0/device/delete 
$ echo "0 1 0" > /sys/class/scsi_host/host7/scan 
-bash: echo: write error: Invalid argument
$ lsscsi 
...
[7:0:1:1]    disk    LIO-ORG  foo2             4.0   /dev/sde 

Though, it can be revived using wildcard scan:

$ echo "0 1 -" > /sys/class/scsi_host/host7/scan
$ lsscsi
...
[7:0:1:0]    disk    LIO-ORG  foo1             4.0   /dev/sdd 
[7:0:1:1]    disk    LIO-ORG  foo2             4.0   /dev/sde 

>Is it rtslib that is giving the new LU a LUN that is not 0?

Yes. As I said above, it use the first free one.

>>
>> This commit fix the upper limit to be as same as rtslib-fb allows.
>>
>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>> ---
>>  drivers/target/loopback/tcm_loop.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/target/loopback/tcm_loop.c b/drivers/target/loopback/tcm_loop.c
>> index 3305b47fdf53..3db541ad727d 100644
>> --- a/drivers/target/loopback/tcm_loop.c
>> +++ b/drivers/target/loopback/tcm_loop.c
>> @@ -336,10 +336,10 @@ static int tcm_loop_driver_probe(struct device *dev)
>>  	 */
>>  	*((struct tcm_loop_hba **)sh->hostdata) = tl_hba;
>>  	/*
>> -	 * Setup single ID, Channel and LUN for now..
>> +	 * Setup single ID, and Channel for now..
>>  	 */
>>  	sh->max_id = 2;
>> -	sh->max_lun = 0;
>> +	sh->max_lun = 65536;
>>  	sh->max_channel = 0;
>>  	sh->max_cmd_len = SCSI_MAX_VARLEN_CDB_SIZE;
>>
>>
>

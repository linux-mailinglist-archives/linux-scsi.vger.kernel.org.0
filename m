Return-Path: <linux-scsi+bounces-11935-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E28C6A255A5
	for <lists+linux-scsi@lfdr.de>; Mon,  3 Feb 2025 10:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 787393A15C0
	for <lists+linux-scsi@lfdr.de>; Mon,  3 Feb 2025 09:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0361FCF44;
	Mon,  3 Feb 2025 09:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i/SCqBY1"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392E91FF1D1;
	Mon,  3 Feb 2025 09:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738574320; cv=none; b=DHvoR8ujZCgHs5TIO4NNd06/w9PCwnxBNshHiMbvzRIpw+KojeYGoj6+ISXuEvEzd4/YnUhKu6Tix8bndWdKdCbm7oS1zzs+bVd4Db4e0CLGpsvGmFwnatAUYKEdXUsnRrlAl9OoddHhtO1zjpYquc+3M/9D7jOXgILcc7/Kqq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738574320; c=relaxed/simple;
	bh=e5KbtvvWEq+3bBEpq8yy66b6UJnWclAy1771nipKtZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T28KcamMbMUCvORUc+CxEf2kn21F0tMIeGgmciDnAhJNFSrRQl+knjNaB7kmWTz9VPjDe2+iKMJvSZZhvXpmgWSq7oZfBJh9AL00UhfN7SVWSPNw8WWkSwzpgT1b3A5mN831qNd4N5f3c8VT9k16TlQiIIhrABY2Ghp/D4hcnws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i/SCqBY1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5137X0Rg014617;
	Mon, 3 Feb 2025 09:18:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=w2LFRu
	VtayskBLxzCZMuFze2hho/WtHaCmGggX234fY=; b=i/SCqBY1x8p+Ads/wgE2YU
	njgEwbqmNCEQCrBZhsuX0Z/49IpQH/lAJxjDoPeMU5CIAigQ4SQktBleFMRxlvNo
	VpjjA1tuudimEC/IR5rD9MKbtmvSwbzNq49gtnhL9tdkVin+0JuRjJu0UqnUvuvC
	nAqBVK07crGL0RkklIDbmTslh64UIZGtZqOP/u5t6TMcXoC2UH0CWcO0YCCmFCx1
	XQltuy0MpKE3OEvGX+ZLb31fh4n5nhZb65oWGP8cji+DCbMpvVqZYCTO2VrEqqH3
	SrJ9+8R6VxIG81qOZ8HZUs/LnJh7Y7GW1ZTt619nJgOvz4Aft9Pwpo+1zEPNIxkw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44jsgngerc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 09:18:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5135IYKm021474;
	Mon, 3 Feb 2025 09:18:15 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44j0n158ce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 09:18:14 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5139I9oD45613558
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Feb 2025 09:18:09 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FEFC20114;
	Mon,  3 Feb 2025 09:18:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF0BF20110;
	Mon,  3 Feb 2025 09:18:01 +0000 (GMT)
Received: from [9.179.15.153] (unknown [9.179.15.153])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Feb 2025 09:18:01 +0000 (GMT)
Message-ID: <4f91f8f6-3ce9-4c57-921b-b7e61c8e2f10@linux.ibm.com>
Date: Mon, 3 Feb 2025 10:18:01 +0100
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cxl: Remove driver
To: Andrew Donnellan <ajd@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, ukrishn@linux.ibm.com,
        clombard@linux.ibm.com, vaibhav@linux.ibm.com
References: <20250203072801.365551-1-ajd@linux.ibm.com>
 <20250203072801.365551-3-ajd@linux.ibm.com>
Content-Language: en-US
From: Frederic Barrat <fbarrat@linux.ibm.com>
In-Reply-To: <20250203072801.365551-3-ajd@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 27VZJS3vPIJgc-0rvDg-uclG6tPyNud5
X-Proofpoint-ORIG-GUID: 27VZJS3vPIJgc-0rvDg-uclG6tPyNud5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_03,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 mlxscore=0 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502030071



On 03/02/2025 08:28, Andrew Donnellan wrote:
> Remove the cxl driver that provides support for the IBM Coherent
> Accelerator Processor Interface. Revert or clean up associated code in
> arch/powerpc that is no longer necessary.
> 
> cxl has received minimal maintenance for several years, and is not
> supported on the Power10 processor. We aren't aware of any users who are
> likely to be using recent kernels.
> 
> Thanks to Mikey Neuling, Ian Munsie, Daniel Axtens, Frederic Barrat,
> Christophe Lombard, Philippe Bergheaud, Vaibhav Jain and Alastair
> D'Silva for their work on this driver over the years.
> 
> Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>

Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>

Thanks!

   Fred


> ---
> v2: rebase, update docs
> ---
>   .../ABI/{obsolete => removed}/sysfs-class-cxl |   55 +-
>   Documentation/arch/powerpc/cxl.rst            |  469 ----
>   Documentation/arch/powerpc/index.rst          |    1 -
>   .../userspace-api/ioctl/ioctl-number.rst      |    2 +-
>   MAINTAINERS                                   |   12 -
>   arch/powerpc/configs/skiroot_defconfig        |    1 -
>   arch/powerpc/include/asm/copro.h              |    6 -
>   arch/powerpc/include/asm/device.h             |    3 -
>   arch/powerpc/include/asm/pnv-pci.h            |   17 -
>   arch/powerpc/mm/book3s64/hash_native.c        |   13 +-
>   arch/powerpc/mm/book3s64/hash_utils.c         |   10 +-
>   arch/powerpc/mm/book3s64/pgtable.c            |    1 -
>   arch/powerpc/mm/book3s64/slice.c              |    6 +-
>   arch/powerpc/mm/copro_fault.c                 |   12 -
>   arch/powerpc/platforms/powernv/Makefile       |    1 -
>   arch/powerpc/platforms/powernv/pci-cxl.c      |  153 --
>   arch/powerpc/platforms/powernv/pci-ioda.c     |   43 -
>   arch/powerpc/platforms/powernv/pci.c          |   61 -
>   arch/powerpc/platforms/powernv/pci.h          |    2 -
>   drivers/misc/Kconfig                          |    1 -
>   drivers/misc/Makefile                         |    1 -
>   drivers/misc/cxl/Kconfig                      |   28 -
>   drivers/misc/cxl/Makefile                     |   14 -
>   drivers/misc/cxl/api.c                        |  532 -----
>   drivers/misc/cxl/base.c                       |  126 -
>   drivers/misc/cxl/context.c                    |  362 ---
>   drivers/misc/cxl/cxl.h                        | 1135 ---------
>   drivers/misc/cxl/cxllib.c                     |  271 ---
>   drivers/misc/cxl/debugfs.c                    |  134 --
>   drivers/misc/cxl/fault.c                      |  341 ---
>   drivers/misc/cxl/file.c                       |  699 ------
>   drivers/misc/cxl/flash.c                      |  538 -----
>   drivers/misc/cxl/guest.c                      | 1208 ----------
>   drivers/misc/cxl/hcalls.c                     |  643 -----
>   drivers/misc/cxl/hcalls.h                     |  200 --
>   drivers/misc/cxl/irq.c                        |  450 ----
>   drivers/misc/cxl/main.c                       |  383 ---
>   drivers/misc/cxl/native.c                     | 1592 -------------
>   drivers/misc/cxl/of.c                         |  346 ---
>   drivers/misc/cxl/pci.c                        | 2103 -----------------
>   drivers/misc/cxl/sysfs.c                      |  771 ------
>   drivers/misc/cxl/trace.c                      |    9 -
>   drivers/misc/cxl/trace.h                      |  691 ------
>   drivers/misc/cxl/vphb.c                       |  309 ---
>   include/misc/cxl-base.h                       |   48 -
>   include/misc/cxl.h                            |  265 ---
>   include/misc/cxllib.h                         |  129 -
>   include/uapi/misc/cxl.h                       |  156 --
>   48 files changed, 42 insertions(+), 14311 deletions(-)
>   rename Documentation/ABI/{obsolete => removed}/sysfs-class-cxl (87%)
>   delete mode 100644 Documentation/arch/powerpc/cxl.rst
>   delete mode 100644 arch/powerpc/platforms/powernv/pci-cxl.c
>   delete mode 100644 drivers/misc/cxl/Kconfig
>   delete mode 100644 drivers/misc/cxl/Makefile
>   delete mode 100644 drivers/misc/cxl/api.c
>   delete mode 100644 drivers/misc/cxl/base.c
>   delete mode 100644 drivers/misc/cxl/context.c
>   delete mode 100644 drivers/misc/cxl/cxl.h
>   delete mode 100644 drivers/misc/cxl/cxllib.c
>   delete mode 100644 drivers/misc/cxl/debugfs.c
>   delete mode 100644 drivers/misc/cxl/fault.c
>   delete mode 100644 drivers/misc/cxl/file.c
>   delete mode 100644 drivers/misc/cxl/flash.c
>   delete mode 100644 drivers/misc/cxl/guest.c
>   delete mode 100644 drivers/misc/cxl/hcalls.c
>   delete mode 100644 drivers/misc/cxl/hcalls.h
>   delete mode 100644 drivers/misc/cxl/irq.c
>   delete mode 100644 drivers/misc/cxl/main.c
>   delete mode 100644 drivers/misc/cxl/native.c
>   delete mode 100644 drivers/misc/cxl/of.c
>   delete mode 100644 drivers/misc/cxl/pci.c
>   delete mode 100644 drivers/misc/cxl/sysfs.c
>   delete mode 100644 drivers/misc/cxl/trace.c
>   delete mode 100644 drivers/misc/cxl/trace.h
>   delete mode 100644 drivers/misc/cxl/vphb.c
>   delete mode 100644 include/misc/cxl-base.h
>   delete mode 100644 include/misc/cxl.h
>   delete mode 100644 include/misc/cxllib.h
>   delete mode 100644 include/uapi/misc/cxl.h
> 
> diff --git a/Documentation/ABI/obsolete/sysfs-class-cxl b/Documentation/ABI/removed/sysfs-class-cxl
> similarity index 87%
> rename from Documentation/ABI/obsolete/sysfs-class-cxl
> rename to Documentation/ABI/removed/sysfs-class-cxl
> index 8cba1b626985..15756a49eba2 100644
> --- a/Documentation/ABI/obsolete/sysfs-class-cxl
> +++ b/Documentation/ABI/removed/sysfs-class-cxl
> @@ -1,5 +1,4 @@
> -The cxl driver is no longer maintained, and will be removed from the kernel in
> -the near future.
> +The cxl driver was removed in 6.14.
>   
>   Please note that attributes that are shared between devices are stored in
>   the directory pointed to by the symlink device/.
> @@ -10,7 +9,7 @@ For example, the real path of the attribute /sys/class/cxl/afu0.0s/irqs_max is
>   Slave contexts (eg. /sys/class/cxl/afu0.0s):
>   
>   What:           /sys/class/cxl/<afu>/afu_err_buf
> -Date:           September 2014
> +Date:           September 2014, removed February 2025
>   Contact:        linuxppc-dev@lists.ozlabs.org
>   Description:    read only
>                   AFU Error Buffer contents. The contents of this file are
> @@ -21,7 +20,7 @@ Description:    read only
>   
>   
>   What:           /sys/class/cxl/<afu>/irqs_max
> -Date:           September 2014
> +Date:           September 2014, removed February 2025
>   Contact:        linuxppc-dev@lists.ozlabs.org
>   Description:    read/write
>                   Decimal value of maximum number of interrupts that can be
> @@ -32,7 +31,7 @@ Description:    read/write
>   Users:		https://github.com/ibm-capi/libcxl
>   
>   What:           /sys/class/cxl/<afu>/irqs_min
> -Date:           September 2014
> +Date:           September 2014, removed February 2025
>   Contact:        linuxppc-dev@lists.ozlabs.org
>   Description:    read only
>                   Decimal value of the minimum number of interrupts that
> @@ -42,7 +41,7 @@ Description:    read only
>   Users:		https://github.com/ibm-capi/libcxl
>   
>   What:           /sys/class/cxl/<afu>/mmio_size
> -Date:           September 2014
> +Date:           September 2014, removed February 2025
>   Contact:        linuxppc-dev@lists.ozlabs.org
>   Description:    read only
>                   Decimal value of the size of the MMIO space that may be mmapped
> @@ -50,7 +49,7 @@ Description:    read only
>   Users:		https://github.com/ibm-capi/libcxl
>   
>   What:           /sys/class/cxl/<afu>/modes_supported
> -Date:           September 2014
> +Date:           September 2014, removed February 2025
>   Contact:        linuxppc-dev@lists.ozlabs.org
>   Description:    read only
>                   List of the modes this AFU supports. One per line.
> @@ -58,7 +57,7 @@ Description:    read only
>   Users:		https://github.com/ibm-capi/libcxl
>   
>   What:           /sys/class/cxl/<afu>/mode
> -Date:           September 2014
> +Date:           September 2014, removed February 2025
>   Contact:        linuxppc-dev@lists.ozlabs.org
>   Description:    read/write
>                   The current mode the AFU is using. Will be one of the modes
> @@ -68,7 +67,7 @@ Users:		https://github.com/ibm-capi/libcxl
>   
>   
>   What:           /sys/class/cxl/<afu>/prefault_mode
> -Date:           September 2014
> +Date:           September 2014, removed February 2025
>   Contact:        linuxppc-dev@lists.ozlabs.org
>   Description:    read/write
>                   Set the mode for prefaulting in segments into the segment table
> @@ -88,7 +87,7 @@ Description:    read/write
>   Users:		https://github.com/ibm-capi/libcxl
>   
>   What:           /sys/class/cxl/<afu>/reset
> -Date:           September 2014
> +Date:           September 2014, removed February 2025
>   Contact:        linuxppc-dev@lists.ozlabs.org
>   Description:    write only
>                   Writing 1 here will reset the AFU provided there are not
> @@ -96,14 +95,14 @@ Description:    write only
>   Users:		https://github.com/ibm-capi/libcxl
>   
>   What:           /sys/class/cxl/<afu>/api_version
> -Date:           September 2014
> +Date:           September 2014, removed February 2025
>   Contact:        linuxppc-dev@lists.ozlabs.org
>   Description:    read only
>                   Decimal value of the current version of the kernel/user API.
>   Users:		https://github.com/ibm-capi/libcxl
>   
>   What:           /sys/class/cxl/<afu>/api_version_compatible
> -Date:           September 2014
> +Date:           September 2014, removed February 2025
>   Contact:        linuxppc-dev@lists.ozlabs.org
>   Description:    read only
>                   Decimal value of the lowest version of the userspace API
> @@ -117,7 +116,7 @@ An AFU may optionally export one or more PCIe like configuration records, known
>   as AFU configuration records, which will show up here (if present).
>   
>   What:           /sys/class/cxl/<afu>/cr<config num>/vendor
> -Date:           February 2015
> +Date:           February 2015, removed February 2025
>   Contact:        linuxppc-dev@lists.ozlabs.org
>   Description:    read only
>   		Hexadecimal value of the vendor ID found in this AFU
> @@ -125,7 +124,7 @@ Description:    read only
>   Users:		https://github.com/ibm-capi/libcxl
>   
>   What:           /sys/class/cxl/<afu>/cr<config num>/device
> -Date:           February 2015
> +Date:           February 2015, removed February 2025
>   Contact:        linuxppc-dev@lists.ozlabs.org
>   Description:    read only
>   		Hexadecimal value of the device ID found in this AFU
> @@ -133,7 +132,7 @@ Description:    read only
>   Users:		https://github.com/ibm-capi/libcxl
>   
>   What:           /sys/class/cxl/<afu>/cr<config num>/class
> -Date:           February 2015
> +Date:           February 2015, removed February 2025
>   Contact:        linuxppc-dev@lists.ozlabs.org
>   Description:    read only
>   		Hexadecimal value of the class code found in this AFU
> @@ -141,7 +140,7 @@ Description:    read only
>   Users:		https://github.com/ibm-capi/libcxl
>   
>   What:           /sys/class/cxl/<afu>/cr<config num>/config
> -Date:           February 2015
> +Date:           February 2015, removed February 2025
>   Contact:        linuxppc-dev@lists.ozlabs.org
>   Description:    read only
>   		This binary file provides raw access to the AFU configuration
> @@ -155,7 +154,7 @@ Users:		https://github.com/ibm-capi/libcxl
>   Master contexts (eg. /sys/class/cxl/afu0.0m)
>   
>   What:           /sys/class/cxl/<afu>m/mmio_size
> -Date:           September 2014
> +Date:           September 2014, removed February 2025
>   Contact:        linuxppc-dev@lists.ozlabs.org
>   Description:    read only
>                   Decimal value of the size of the MMIO space that may be mmapped
> @@ -163,14 +162,14 @@ Description:    read only
>   Users:		https://github.com/ibm-capi/libcxl
>   
>   What:           /sys/class/cxl/<afu>m/pp_mmio_len
> -Date:           September 2014
> +Date:           September 2014, removed February 2025
>   Contact:        linuxppc-dev@lists.ozlabs.org
>   Description:    read only
>                   Decimal value of the Per Process MMIO space length.
>   Users:		https://github.com/ibm-capi/libcxl
>   
>   What:           /sys/class/cxl/<afu>m/pp_mmio_off
> -Date:           September 2014
> +Date:           September 2014, removed February 2025
>   Contact:        linuxppc-dev@lists.ozlabs.org
>   Description:    read only
>                   (not in a guest)
> @@ -181,21 +180,21 @@ Users:		https://github.com/ibm-capi/libcxl
>   Card info (eg. /sys/class/cxl/card0)
>   
>   What:           /sys/class/cxl/<card>/caia_version
> -Date:           September 2014
> +Date:           September 2014, removed February 2025
>   Contact:        linuxppc-dev@lists.ozlabs.org
>   Description:    read only
>                   Identifies the CAIA Version the card implements.
>   Users:		https://github.com/ibm-capi/libcxl
>   
>   What:           /sys/class/cxl/<card>/psl_revision
> -Date:           September 2014
> +Date:           September 2014, removed February 2025
>   Contact:        linuxppc-dev@lists.ozlabs.org
>   Description:    read only
>                   Identifies the revision level of the PSL.
>   Users:		https://github.com/ibm-capi/libcxl
>   
>   What:           /sys/class/cxl/<card>/base_image
> -Date:           September 2014
> +Date:           September 2014, removed February 2025
>   Contact:        linuxppc-dev@lists.ozlabs.org
>   Description:    read only
>                   (not in a guest)
> @@ -206,7 +205,7 @@ Description:    read only
>   Users:		https://github.com/ibm-capi/libcxl
>   
>   What:           /sys/class/cxl/<card>/image_loaded
> -Date:           September 2014
> +Date:           September 2014, removed February 2025
>   Contact:        linuxppc-dev@lists.ozlabs.org
>   Description:    read only
>                   (not in a guest)
> @@ -215,7 +214,7 @@ Description:    read only
>   Users:		https://github.com/ibm-capi/libcxl
>   
>   What:           /sys/class/cxl/<card>/load_image_on_perst
> -Date:           December 2014
> +Date:           December 2014, removed February 2025
>   Contact:        linuxppc-dev@lists.ozlabs.org
>   Description:    read/write
>                   (not in a guest)
> @@ -232,7 +231,7 @@ Description:    read/write
>   Users:		https://github.com/ibm-capi/libcxl
>   
>   What:           /sys/class/cxl/<card>/reset
> -Date:           October 2014
> +Date:           October 2014, removed February 2025
>   Contact:        linuxppc-dev@lists.ozlabs.org
>   Description:    write only
>                   Writing 1 will issue a PERST to card provided there are no
> @@ -243,7 +242,7 @@ Description:    write only
>   Users:		https://github.com/ibm-capi/libcxl
>   
>   What:		/sys/class/cxl/<card>/perst_reloads_same_image
> -Date:		July 2015
> +Date:		July 2015, removed February 2025
>   Contact:	linuxppc-dev@lists.ozlabs.org
>   Description:	read/write
>                   (not in a guest)
> @@ -257,7 +256,7 @@ Description:	read/write
>   Users:		https://github.com/ibm-capi/libcxl
>   
>   What:           /sys/class/cxl/<card>/psl_timebase_synced
> -Date:           March 2016
> +Date:           March 2016, removed February 2025
>   Contact:        linuxppc-dev@lists.ozlabs.org
>   Description:    read only
>                   Returns 1 if the psl timebase register is synchronized
> @@ -265,7 +264,7 @@ Description:    read only
>   Users:          https://github.com/ibm-capi/libcxl
>   
>   What:           /sys/class/cxl/<card>/tunneled_ops_supported
> -Date:           May 2018
> +Date:           May 2018, removed February 2025
>   Contact:        linuxppc-dev@lists.ozlabs.org
>   Description:    read only
>                   Returns 1 if tunneled operations are supported in capi mode,
> diff --git a/Documentation/arch/powerpc/cxl.rst b/Documentation/arch/powerpc/cxl.rst
> deleted file mode 100644
> index d2d77057610e..000000000000
> --- a/Documentation/arch/powerpc/cxl.rst
> +++ /dev/null
> @@ -1,469 +0,0 @@
> -====================================
> -Coherent Accelerator Interface (CXL)
> -====================================
> -
> -Introduction
> -============
> -
> -    The coherent accelerator interface is designed to allow the
> -    coherent connection of accelerators (FPGAs and other devices) to a
> -    POWER system. These devices need to adhere to the Coherent
> -    Accelerator Interface Architecture (CAIA).
> -
> -    IBM refers to this as the Coherent Accelerator Processor Interface
> -    or CAPI. In the kernel it's referred to by the name CXL to avoid
> -    confusion with the ISDN CAPI subsystem.
> -
> -    Coherent in this context means that the accelerator and CPUs can
> -    both access system memory directly and with the same effective
> -    addresses.
> -
> -
> -Hardware overview
> -=================
> -
> -    ::
> -
> -         POWER8/9             FPGA
> -       +----------+        +---------+
> -       |          |        |         |
> -       |   CPU    |        |   AFU   |
> -       |          |        |         |
> -       |          |        |         |
> -       |          |        |         |
> -       +----------+        +---------+
> -       |   PHB    |        |         |
> -       |   +------+        |   PSL   |
> -       |   | CAPP |<------>|         |
> -       +---+------+  PCIE  +---------+
> -
> -    The POWER8/9 chip has a Coherently Attached Processor Proxy (CAPP)
> -    unit which is part of the PCIe Host Bridge (PHB). This is managed
> -    by Linux by calls into OPAL. Linux doesn't directly program the
> -    CAPP.
> -
> -    The FPGA (or coherently attached device) consists of two parts.
> -    The POWER Service Layer (PSL) and the Accelerator Function Unit
> -    (AFU). The AFU is used to implement specific functionality behind
> -    the PSL. The PSL, among other things, provides memory address
> -    translation services to allow each AFU direct access to userspace
> -    memory.
> -
> -    The AFU is the core part of the accelerator (eg. the compression,
> -    crypto etc function). The kernel has no knowledge of the function
> -    of the AFU. Only userspace interacts directly with the AFU.
> -
> -    The PSL provides the translation and interrupt services that the
> -    AFU needs. This is what the kernel interacts with. For example, if
> -    the AFU needs to read a particular effective address, it sends
> -    that address to the PSL, the PSL then translates it, fetches the
> -    data from memory and returns it to the AFU. If the PSL has a
> -    translation miss, it interrupts the kernel and the kernel services
> -    the fault. The context to which this fault is serviced is based on
> -    who owns that acceleration function.
> -
> -    - POWER8 and PSL Version 8 are compliant to the CAIA Version 1.0.
> -    - POWER9 and PSL Version 9 are compliant to the CAIA Version 2.0.
> -
> -    This PSL Version 9 provides new features such as:
> -
> -    * Interaction with the nest MMU on the P9 chip.
> -    * Native DMA support.
> -    * Supports sending ASB_Notify messages for host thread wakeup.
> -    * Supports Atomic operations.
> -    * etc.
> -
> -    Cards with a PSL9 won't work on a POWER8 system and cards with a
> -    PSL8 won't work on a POWER9 system.
> -
> -AFU Modes
> -=========
> -
> -    There are two programming modes supported by the AFU. Dedicated
> -    and AFU directed. AFU may support one or both modes.
> -
> -    When using dedicated mode only one MMU context is supported. In
> -    this mode, only one userspace process can use the accelerator at
> -    time.
> -
> -    When using AFU directed mode, up to 16K simultaneous contexts can
> -    be supported. This means up to 16K simultaneous userspace
> -    applications may use the accelerator (although specific AFUs may
> -    support fewer). In this mode, the AFU sends a 16 bit context ID
> -    with each of its requests. This tells the PSL which context is
> -    associated with each operation. If the PSL can't translate an
> -    operation, the ID can also be accessed by the kernel so it can
> -    determine the userspace context associated with an operation.
> -
> -
> -MMIO space
> -==========
> -
> -    A portion of the accelerator MMIO space can be directly mapped
> -    from the AFU to userspace. Either the whole space can be mapped or
> -    just a per context portion. The hardware is self describing, hence
> -    the kernel can determine the offset and size of the per context
> -    portion.
> -
> -
> -Interrupts
> -==========
> -
> -    AFUs may generate interrupts that are destined for userspace. These
> -    are received by the kernel as hardware interrupts and passed onto
> -    userspace by a read syscall documented below.
> -
> -    Data storage faults and error interrupts are handled by the kernel
> -    driver.
> -
> -
> -Work Element Descriptor (WED)
> -=============================
> -
> -    The WED is a 64-bit parameter passed to the AFU when a context is
> -    started. Its format is up to the AFU hence the kernel has no
> -    knowledge of what it represents. Typically it will be the
> -    effective address of a work queue or status block where the AFU
> -    and userspace can share control and status information.
> -
> -
> -
> -
> -User API
> -========
> -
> -1. AFU character devices
> -^^^^^^^^^^^^^^^^^^^^^^^^
> -
> -    For AFUs operating in AFU directed mode, two character device
> -    files will be created. /dev/cxl/afu0.0m will correspond to a
> -    master context and /dev/cxl/afu0.0s will correspond to a slave
> -    context. Master contexts have access to the full MMIO space an
> -    AFU provides. Slave contexts have access to only the per process
> -    MMIO space an AFU provides.
> -
> -    For AFUs operating in dedicated process mode, the driver will
> -    only create a single character device per AFU called
> -    /dev/cxl/afu0.0d. This will have access to the entire MMIO space
> -    that the AFU provides (like master contexts in AFU directed).
> -
> -    The types described below are defined in include/uapi/misc/cxl.h
> -
> -    The following file operations are supported on both slave and
> -    master devices.
> -
> -    A userspace library libcxl is available here:
> -
> -	https://github.com/ibm-capi/libcxl
> -
> -    This provides a C interface to this kernel API.
> -
> -open
> -----
> -
> -    Opens the device and allocates a file descriptor to be used with
> -    the rest of the API.
> -
> -    A dedicated mode AFU only has one context and only allows the
> -    device to be opened once.
> -
> -    An AFU directed mode AFU can have many contexts, the device can be
> -    opened once for each context that is available.
> -
> -    When all available contexts are allocated the open call will fail
> -    and return -ENOSPC.
> -
> -    Note:
> -	  IRQs need to be allocated for each context, which may limit
> -          the number of contexts that can be created, and therefore
> -          how many times the device can be opened. The POWER8 CAPP
> -          supports 2040 IRQs and 3 are used by the kernel, so 2037 are
> -          left. If 1 IRQ is needed per context, then only 2037
> -          contexts can be allocated. If 4 IRQs are needed per context,
> -          then only 2037/4 = 509 contexts can be allocated.
> -
> -
> -ioctl
> ------
> -
> -    CXL_IOCTL_START_WORK:
> -        Starts the AFU context and associates it with the current
> -        process. Once this ioctl is successfully executed, all memory
> -        mapped into this process is accessible to this AFU context
> -        using the same effective addresses. No additional calls are
> -        required to map/unmap memory. The AFU memory context will be
> -        updated as userspace allocates and frees memory. This ioctl
> -        returns once the AFU context is started.
> -
> -        Takes a pointer to a struct cxl_ioctl_start_work
> -
> -            ::
> -
> -                struct cxl_ioctl_start_work {
> -                        __u64 flags;
> -                        __u64 work_element_descriptor;
> -                        __u64 amr;
> -                        __s16 num_interrupts;
> -                        __s16 reserved1;
> -                        __s32 reserved2;
> -                        __u64 reserved3;
> -                        __u64 reserved4;
> -                        __u64 reserved5;
> -                        __u64 reserved6;
> -                };
> -
> -            flags:
> -                Indicates which optional fields in the structure are
> -                valid.
> -
> -            work_element_descriptor:
> -                The Work Element Descriptor (WED) is a 64-bit argument
> -                defined by the AFU. Typically this is an effective
> -                address pointing to an AFU specific structure
> -                describing what work to perform.
> -
> -            amr:
> -                Authority Mask Register (AMR), same as the powerpc
> -                AMR. This field is only used by the kernel when the
> -                corresponding CXL_START_WORK_AMR value is specified in
> -                flags. If not specified the kernel will use a default
> -                value of 0.
> -
> -            num_interrupts:
> -                Number of userspace interrupts to request. This field
> -                is only used by the kernel when the corresponding
> -                CXL_START_WORK_NUM_IRQS value is specified in flags.
> -                If not specified the minimum number required by the
> -                AFU will be allocated. The min and max number can be
> -                obtained from sysfs.
> -
> -            reserved fields:
> -                For ABI padding and future extensions
> -
> -    CXL_IOCTL_GET_PROCESS_ELEMENT:
> -        Get the current context id, also known as the process element.
> -        The value is returned from the kernel as a __u32.
> -
> -
> -mmap
> -----
> -
> -    An AFU may have an MMIO space to facilitate communication with the
> -    AFU. If it does, the MMIO space can be accessed via mmap. The size
> -    and contents of this area are specific to the particular AFU. The
> -    size can be discovered via sysfs.
> -
> -    In AFU directed mode, master contexts are allowed to map all of
> -    the MMIO space and slave contexts are allowed to only map the per
> -    process MMIO space associated with the context. In dedicated
> -    process mode the entire MMIO space can always be mapped.
> -
> -    This mmap call must be done after the START_WORK ioctl.
> -
> -    Care should be taken when accessing MMIO space. Only 32 and 64-bit
> -    accesses are supported by POWER8. Also, the AFU will be designed
> -    with a specific endianness, so all MMIO accesses should consider
> -    endianness (recommend endian(3) variants like: le64toh(),
> -    be64toh() etc). These endian issues equally apply to shared memory
> -    queues the WED may describe.
> -
> -
> -read
> -----
> -
> -    Reads events from the AFU. Blocks if no events are pending
> -    (unless O_NONBLOCK is supplied). Returns -EIO in the case of an
> -    unrecoverable error or if the card is removed.
> -
> -    read() will always return an integral number of events.
> -
> -    The buffer passed to read() must be at least 4K bytes.
> -
> -    The result of the read will be a buffer of one or more events,
> -    each event is of type struct cxl_event, of varying size::
> -
> -            struct cxl_event {
> -                    struct cxl_event_header header;
> -                    union {
> -                            struct cxl_event_afu_interrupt irq;
> -                            struct cxl_event_data_storage fault;
> -                            struct cxl_event_afu_error afu_error;
> -                    };
> -            };
> -
> -    The struct cxl_event_header is defined as
> -
> -        ::
> -
> -            struct cxl_event_header {
> -                    __u16 type;
> -                    __u16 size;
> -                    __u16 process_element;
> -                    __u16 reserved1;
> -            };
> -
> -        type:
> -            This defines the type of event. The type determines how
> -            the rest of the event is structured. These types are
> -            described below and defined by enum cxl_event_type.
> -
> -        size:
> -            This is the size of the event in bytes including the
> -            struct cxl_event_header. The start of the next event can
> -            be found at this offset from the start of the current
> -            event.
> -
> -        process_element:
> -            Context ID of the event.
> -
> -        reserved field:
> -            For future extensions and padding.
> -
> -    If the event type is CXL_EVENT_AFU_INTERRUPT then the event
> -    structure is defined as
> -
> -        ::
> -
> -            struct cxl_event_afu_interrupt {
> -                    __u16 flags;
> -                    __u16 irq; /* Raised AFU interrupt number */
> -                    __u32 reserved1;
> -            };
> -
> -        flags:
> -            These flags indicate which optional fields are present
> -            in this struct. Currently all fields are mandatory.
> -
> -        irq:
> -            The IRQ number sent by the AFU.
> -
> -        reserved field:
> -            For future extensions and padding.
> -
> -    If the event type is CXL_EVENT_DATA_STORAGE then the event
> -    structure is defined as
> -
> -        ::
> -
> -            struct cxl_event_data_storage {
> -                    __u16 flags;
> -                    __u16 reserved1;
> -                    __u32 reserved2;
> -                    __u64 addr;
> -                    __u64 dsisr;
> -                    __u64 reserved3;
> -            };
> -
> -        flags:
> -            These flags indicate which optional fields are present in
> -            this struct. Currently all fields are mandatory.
> -
> -        address:
> -            The address that the AFU unsuccessfully attempted to
> -            access. Valid accesses will be handled transparently by the
> -            kernel but invalid accesses will generate this event.
> -
> -        dsisr:
> -            This field gives information on the type of fault. It is a
> -            copy of the DSISR from the PSL hardware when the address
> -            fault occurred. The form of the DSISR is as defined in the
> -            CAIA.
> -
> -        reserved fields:
> -            For future extensions
> -
> -    If the event type is CXL_EVENT_AFU_ERROR then the event structure
> -    is defined as
> -
> -        ::
> -
> -            struct cxl_event_afu_error {
> -                    __u16 flags;
> -                    __u16 reserved1;
> -                    __u32 reserved2;
> -                    __u64 error;
> -            };
> -
> -        flags:
> -            These flags indicate which optional fields are present in
> -            this struct. Currently all fields are Mandatory.
> -
> -        error:
> -            Error status from the AFU. Defined by the AFU.
> -
> -        reserved fields:
> -            For future extensions and padding
> -
> -
> -2. Card character device (powerVM guest only)
> -^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> -
> -    In a powerVM guest, an extra character device is created for the
> -    card. The device is only used to write (flash) a new image on the
> -    FPGA accelerator. Once the image is written and verified, the
> -    device tree is updated and the card is reset to reload the updated
> -    image.
> -
> -open
> -----
> -
> -    Opens the device and allocates a file descriptor to be used with
> -    the rest of the API. The device can only be opened once.
> -
> -ioctl
> ------
> -
> -CXL_IOCTL_DOWNLOAD_IMAGE / CXL_IOCTL_VALIDATE_IMAGE:
> -    Starts and controls flashing a new FPGA image. Partial
> -    reconfiguration is not supported (yet), so the image must contain
> -    a copy of the PSL and AFU(s). Since an image can be quite large,
> -    the caller may have to iterate, splitting the image in smaller
> -    chunks.
> -
> -    Takes a pointer to a struct cxl_adapter_image::
> -
> -        struct cxl_adapter_image {
> -            __u64 flags;
> -            __u64 data;
> -            __u64 len_data;
> -            __u64 len_image;
> -            __u64 reserved1;
> -            __u64 reserved2;
> -            __u64 reserved3;
> -            __u64 reserved4;
> -        };
> -
> -    flags:
> -        These flags indicate which optional fields are present in
> -        this struct. Currently all fields are mandatory.
> -
> -    data:
> -        Pointer to a buffer with part of the image to write to the
> -        card.
> -
> -    len_data:
> -        Size of the buffer pointed to by data.
> -
> -    len_image:
> -        Full size of the image.
> -
> -
> -Sysfs Class
> -===========
> -
> -    A cxl sysfs class is added under /sys/class/cxl to facilitate
> -    enumeration and tuning of the accelerators. Its layout is
> -    described in Documentation/ABI/testing/sysfs-class-cxl
> -
> -
> -Udev rules
> -==========
> -
> -    The following udev rules could be used to create a symlink to the
> -    most logical chardev to use in any programming mode (afuX.Yd for
> -    dedicated, afuX.Ys for afu directed), since the API is virtually
> -    identical for each::
> -
> -	SUBSYSTEM=="cxl", ATTRS{mode}=="dedicated_process", SYMLINK="cxl/%b"
> -	SUBSYSTEM=="cxl", ATTRS{mode}=="afu_directed", \
> -	                  KERNEL=="afu[0-9]*.[0-9]*s", SYMLINK="cxl/%b"
> diff --git a/Documentation/arch/powerpc/index.rst b/Documentation/arch/powerpc/index.rst
> index 995268530f21..0560cbae5fa1 100644
> --- a/Documentation/arch/powerpc/index.rst
> +++ b/Documentation/arch/powerpc/index.rst
> @@ -12,7 +12,6 @@ powerpc
>       bootwrapper
>       cpu_families
>       cpu_features
> -    cxl
>       dawr-power9
>       dexcr
>       dscr
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index efe133c50615..0b46257904d6 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -371,7 +371,7 @@ Code  Seq#    Include File                                           Comments
>   0xB7  all    uapi/linux/nsfs.h                                       <mailto:Andrei Vagin <avagin@openvz.org>>
>   0xB8  01-02  uapi/misc/mrvl_cn10k_dpi.h                              Marvell CN10K DPI driver
>   0xC0  00-0F  linux/usb/iowarrior.h
> -0xCA  00-0F  uapi/misc/cxl.h
> +0xCA  00-0F  uapi/misc/cxl.h                                         Dead since 6.14
>   0xCA  10-2F  uapi/misc/ocxl.h
>   0xCA  80-BF  uapi/scsi/cxlflash_ioctl.h                              Dead since 6.14
>   0xCB  00-1F                                                          CBM serial IEC bus in development:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f1171fe71e4e..8e35645b30e1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6306,18 +6306,6 @@ S:	Maintained
>   W:	http://www.chelsio.com
>   F:	drivers/net/ethernet/chelsio/cxgb4vf/
>   
> -CXL (IBM Coherent Accelerator Processor Interface CAPI) DRIVER
> -M:	Frederic Barrat <fbarrat@linux.ibm.com>
> -M:	Andrew Donnellan <ajd@linux.ibm.com>
> -L:	linuxppc-dev@lists.ozlabs.org
> -S:	Obsolete
> -F:	Documentation/ABI/obsolete/sysfs-class-cxl
> -F:	Documentation/arch/powerpc/cxl.rst
> -F:	arch/powerpc/platforms/powernv/pci-cxl.c
> -F:	drivers/misc/cxl/
> -F:	include/misc/cxl*
> -F:	include/uapi/misc/cxl.h
> -
>   CYBERPRO FB DRIVER
>   M:	Russell King <linux@armlinux.org.uk>
>   L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> diff --git a/arch/powerpc/configs/skiroot_defconfig b/arch/powerpc/configs/skiroot_defconfig
> index 9d44e6630908..d70df2c3e393 100644
> --- a/arch/powerpc/configs/skiroot_defconfig
> +++ b/arch/powerpc/configs/skiroot_defconfig
> @@ -78,7 +78,6 @@ CONFIG_VIRTIO_BLK=m
>   CONFIG_BLK_DEV_NVME=m
>   CONFIG_NVME_MULTIPATH=y
>   CONFIG_EEPROM_AT24=m
> -# CONFIG_CXL is not set
>   # CONFIG_OCXL is not set
>   CONFIG_BLK_DEV_SD=m
>   CONFIG_BLK_DEV_SR=m
> diff --git a/arch/powerpc/include/asm/copro.h b/arch/powerpc/include/asm/copro.h
> index fd2e166ea02a..81bd176203ab 100644
> --- a/arch/powerpc/include/asm/copro.h
> +++ b/arch/powerpc/include/asm/copro.h
> @@ -18,10 +18,4 @@ int copro_handle_mm_fault(struct mm_struct *mm, unsigned long ea,
>   
>   int copro_calculate_slb(struct mm_struct *mm, u64 ea, struct copro_slb *slb);
>   
> -
> -#ifdef CONFIG_PPC_COPRO_BASE
> -void copro_flush_all_slbs(struct mm_struct *mm);
> -#else
> -static inline void copro_flush_all_slbs(struct mm_struct *mm) {}
> -#endif
>   #endif /* _ASM_POWERPC_COPRO_H */
> diff --git a/arch/powerpc/include/asm/device.h b/arch/powerpc/include/asm/device.h
> index 47ed639f3b8f..a4dc27655b3e 100644
> --- a/arch/powerpc/include/asm/device.h
> +++ b/arch/powerpc/include/asm/device.h
> @@ -38,9 +38,6 @@ struct dev_archdata {
>   #ifdef CONFIG_FAIL_IOMMU
>   	int fail_iommu;
>   #endif
> -#ifdef CONFIG_CXL_BASE
> -	struct cxl_context	*cxl_ctx;
> -#endif
>   #ifdef CONFIG_PCI_IOV
>   	void *iov_data;
>   #endif
> diff --git a/arch/powerpc/include/asm/pnv-pci.h b/arch/powerpc/include/asm/pnv-pci.h
> index 8afc92860dbb..7e9a479951a3 100644
> --- a/arch/powerpc/include/asm/pnv-pci.h
> +++ b/arch/powerpc/include/asm/pnv-pci.h
> @@ -10,7 +10,6 @@
>   #include <linux/pci_hotplug.h>
>   #include <linux/irq.h>
>   #include <linux/of.h>
> -#include <misc/cxl-base.h>
>   #include <asm/opal-api.h>
>   
>   #define PCI_SLOT_ID_PREFIX	(1UL << 63)
> @@ -25,25 +24,9 @@ extern int pnv_pci_get_power_state(uint64_t id, uint8_t *state);
>   extern int pnv_pci_set_power_state(uint64_t id, uint8_t state,
>   				   struct opal_msg *msg);
>   
> -extern int pnv_pci_set_tunnel_bar(struct pci_dev *dev, uint64_t addr,
> -				  int enable);
> -int pnv_phb_to_cxl_mode(struct pci_dev *dev, uint64_t mode);
> -int pnv_cxl_ioda_msi_setup(struct pci_dev *dev, unsigned int hwirq,
> -			   unsigned int virq);
> -int pnv_cxl_alloc_hwirqs(struct pci_dev *dev, int num);
> -void pnv_cxl_release_hwirqs(struct pci_dev *dev, int hwirq, int num);
> -int pnv_cxl_get_irq_count(struct pci_dev *dev);
> -struct device_node *pnv_pci_get_phb_node(struct pci_dev *dev);
>   int64_t pnv_opal_pci_msi_eoi(struct irq_data *d);
>   bool is_pnv_opal_msi(struct irq_chip *chip);
>   
> -#ifdef CONFIG_CXL_BASE
> -int pnv_cxl_alloc_hwirq_ranges(struct cxl_irq_ranges *irqs,
> -			       struct pci_dev *dev, int num);
> -void pnv_cxl_release_hwirq_ranges(struct cxl_irq_ranges *irqs,
> -				  struct pci_dev *dev);
> -#endif
> -
>   struct pnv_php_slot {
>   	struct hotplug_slot		slot;
>   	uint64_t			id;
> diff --git a/arch/powerpc/mm/book3s64/hash_native.c b/arch/powerpc/mm/book3s64/hash_native.c
> index 430d1d935a7c..e9e2dd70c060 100644
> --- a/arch/powerpc/mm/book3s64/hash_native.c
> +++ b/arch/powerpc/mm/book3s64/hash_native.c
> @@ -27,8 +27,6 @@
>   #include <asm/ppc-opcode.h>
>   #include <asm/feature-fixups.h>
>   
> -#include <misc/cxl-base.h>
> -
>   #ifdef DEBUG_LOW
>   #define DBG_LOW(fmt...) udbg_printf(fmt)
>   #else
> @@ -217,11 +215,9 @@ static inline void __tlbiel(unsigned long vpn, int psize, int apsize, int ssize)
>   static inline void tlbie(unsigned long vpn, int psize, int apsize,
>   			 int ssize, int local)
>   {
> -	unsigned int use_local;
> +	unsigned int use_local = local && mmu_has_feature(MMU_FTR_TLBIEL);
>   	int lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
>   
> -	use_local = local && mmu_has_feature(MMU_FTR_TLBIEL) && !cxl_ctx_in_use();
> -
>   	if (use_local)
>   		use_local = mmu_psize_defs[psize].tlbiel;
>   	if (lock_tlbie && !use_local)
> @@ -789,10 +785,6 @@ static void native_flush_hash_range(unsigned long number, int local)
>   	unsigned long psize = batch->psize;
>   	int ssize = batch->ssize;
>   	int i;
> -	unsigned int use_local;
> -
> -	use_local = local && mmu_has_feature(MMU_FTR_TLBIEL) &&
> -		mmu_psize_defs[psize].tlbiel && !cxl_ctx_in_use();
>   
>   	local_irq_save(flags);
>   
> @@ -827,7 +819,8 @@ static void native_flush_hash_range(unsigned long number, int local)
>   		} pte_iterate_hashed_end();
>   	}
>   
> -	if (use_local) {
> +	if (mmu_has_feature(MMU_FTR_TLBIEL) &&
> +	    mmu_psize_defs[psize].tlbiel && local) {
>   		asm volatile("ptesync":::"memory");
>   		for (i = 0; i < number; i++) {
>   			vpn = batch->vpn[i];
> diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
> index c8b4fa71d4a7..790f94dbdaad 100644
> --- a/arch/powerpc/mm/book3s64/hash_utils.c
> +++ b/arch/powerpc/mm/book3s64/hash_utils.c
> @@ -56,7 +56,7 @@
>   #include <asm/cacheflush.h>
>   #include <asm/cputable.h>
>   #include <asm/sections.h>
> -#include <asm/copro.h>
> +#include <asm/spu.h>
>   #include <asm/udbg.h>
>   #include <asm/text-patching.h>
>   #include <asm/fadump.h>
> @@ -1612,7 +1612,9 @@ void demote_segment_4k(struct mm_struct *mm, unsigned long addr)
>   	if (get_slice_psize(mm, addr) == MMU_PAGE_4K)
>   		return;
>   	slice_set_range_psize(mm, addr, 1, MMU_PAGE_4K);
> -	copro_flush_all_slbs(mm);
> +#ifdef CONFIG_SPU_BASE
> +	spu_flush_all_slbs(mm);
> +#endif
>   	if ((get_paca_psize(addr) != MMU_PAGE_4K) && (current->mm == mm)) {
>   
>   		copy_mm_to_paca(mm);
> @@ -1881,7 +1883,9 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
>   			       "to 4kB pages because of "
>   			       "non-cacheable mapping\n");
>   			psize = mmu_vmalloc_psize = MMU_PAGE_4K;
> -			copro_flush_all_slbs(mm);
> +#ifdef CONFIG_SPU_BASE
> +			spu_flush_all_slbs(mm);
> +#endif
>   		}
>   	}
>   
> diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
> index ce64abea9e3e..45b763b30708 100644
> --- a/arch/powerpc/mm/book3s64/pgtable.c
> +++ b/arch/powerpc/mm/book3s64/pgtable.c
> @@ -10,7 +10,6 @@
>   #include <linux/pkeys.h>
>   #include <linux/debugfs.h>
>   #include <linux/proc_fs.h>
> -#include <misc/cxl-base.h>
>   
>   #include <asm/pgalloc.h>
>   #include <asm/tlb.h>
> diff --git a/arch/powerpc/mm/book3s64/slice.c b/arch/powerpc/mm/book3s64/slice.c
> index bc9a39821d1c..28bec5bc7879 100644
> --- a/arch/powerpc/mm/book3s64/slice.c
> +++ b/arch/powerpc/mm/book3s64/slice.c
> @@ -22,7 +22,7 @@
>   #include <linux/security.h>
>   #include <asm/mman.h>
>   #include <asm/mmu.h>
> -#include <asm/copro.h>
> +#include <asm/spu.h>
>   #include <asm/hugetlb.h>
>   #include <asm/mmu_context.h>
>   
> @@ -248,7 +248,9 @@ static void slice_convert(struct mm_struct *mm,
>   
>   	spin_unlock_irqrestore(&slice_convert_lock, flags);
>   
> -	copro_flush_all_slbs(mm);
> +#ifdef CONFIG_SPU_BASE
> +	spu_flush_all_slbs(mm);
> +#endif
>   }
>   
>   /*
> diff --git a/arch/powerpc/mm/copro_fault.c b/arch/powerpc/mm/copro_fault.c
> index f49fd873df8d..f6aeb03d69c2 100644
> --- a/arch/powerpc/mm/copro_fault.c
> +++ b/arch/powerpc/mm/copro_fault.c
> @@ -12,8 +12,6 @@
>   #include <linux/export.h>
>   #include <asm/reg.h>
>   #include <asm/copro.h>
> -#include <asm/spu.h>
> -#include <misc/cxl-base.h>
>   
>   /*
>    * This ought to be kept in sync with the powerpc specific do_page_fault
> @@ -135,13 +133,3 @@ int copro_calculate_slb(struct mm_struct *mm, u64 ea, struct copro_slb *slb)
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(copro_calculate_slb);
> -
> -void copro_flush_all_slbs(struct mm_struct *mm)
> -{
> -#ifdef CONFIG_SPU_BASE
> -	spu_flush_all_slbs(mm);
> -#endif
> -	cxl_slbia(mm);
> -}
> -EXPORT_SYMBOL_GPL(copro_flush_all_slbs);
> -#endif
> diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
> index 19f0fc5c6f1b..9e5d0c847ee2 100644
> --- a/arch/powerpc/platforms/powernv/Makefile
> +++ b/arch/powerpc/platforms/powernv/Makefile
> @@ -21,7 +21,6 @@ obj-$(CONFIG_PRESERVE_FA_DUMP)	+= opal-fadump.o
>   obj-$(CONFIG_OPAL_CORE)	+= opal-core.o
>   obj-$(CONFIG_PCI)	+= pci.o pci-ioda.o pci-ioda-tce.o
>   obj-$(CONFIG_PCI_IOV)   += pci-sriov.o
> -obj-$(CONFIG_CXL_BASE)	+= pci-cxl.o
>   obj-$(CONFIG_EEH)	+= eeh-powernv.o
>   obj-$(CONFIG_MEMORY_FAILURE)	+= opal-memory-errors.o
>   obj-$(CONFIG_OPAL_PRD)	+= opal-prd.o
> diff --git a/arch/powerpc/platforms/powernv/pci-cxl.c b/arch/powerpc/platforms/powernv/pci-cxl.c
> deleted file mode 100644
> index 7e419de71db8..000000000000
> --- a/arch/powerpc/platforms/powernv/pci-cxl.c
> +++ /dev/null
> @@ -1,153 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * Copyright 2014-2016 IBM Corp.
> - */
> -
> -#include <linux/module.h>
> -#include <misc/cxl-base.h>
> -#include <asm/pnv-pci.h>
> -#include <asm/opal.h>
> -
> -#include "pci.h"
> -
> -int pnv_phb_to_cxl_mode(struct pci_dev *dev, uint64_t mode)
> -{
> -	struct pci_controller *hose = pci_bus_to_host(dev->bus);
> -	struct pnv_phb *phb = hose->private_data;
> -	struct pnv_ioda_pe *pe;
> -	int rc;
> -
> -	pe = pnv_ioda_get_pe(dev);
> -	if (!pe)
> -		return -ENODEV;
> -
> -	pe_info(pe, "Switching PHB to CXL\n");
> -
> -	rc = opal_pci_set_phb_cxl_mode(phb->opal_id, mode, pe->pe_number);
> -	if (rc == OPAL_UNSUPPORTED)
> -		dev_err(&dev->dev, "Required cxl mode not supported by firmware - update skiboot\n");
> -	else if (rc)
> -		dev_err(&dev->dev, "opal_pci_set_phb_cxl_mode failed: %i\n", rc);
> -
> -	return rc;
> -}
> -EXPORT_SYMBOL(pnv_phb_to_cxl_mode);
> -
> -/* Find PHB for cxl dev and allocate MSI hwirqs?
> - * Returns the absolute hardware IRQ number
> - */
> -int pnv_cxl_alloc_hwirqs(struct pci_dev *dev, int num)
> -{
> -	struct pci_controller *hose = pci_bus_to_host(dev->bus);
> -	struct pnv_phb *phb = hose->private_data;
> -	int hwirq = msi_bitmap_alloc_hwirqs(&phb->msi_bmp, num);
> -
> -	if (hwirq < 0) {
> -		dev_warn(&dev->dev, "Failed to find a free MSI\n");
> -		return -ENOSPC;
> -	}
> -
> -	return phb->msi_base + hwirq;
> -}
> -EXPORT_SYMBOL(pnv_cxl_alloc_hwirqs);
> -
> -void pnv_cxl_release_hwirqs(struct pci_dev *dev, int hwirq, int num)
> -{
> -	struct pci_controller *hose = pci_bus_to_host(dev->bus);
> -	struct pnv_phb *phb = hose->private_data;
> -
> -	msi_bitmap_free_hwirqs(&phb->msi_bmp, hwirq - phb->msi_base, num);
> -}
> -EXPORT_SYMBOL(pnv_cxl_release_hwirqs);
> -
> -void pnv_cxl_release_hwirq_ranges(struct cxl_irq_ranges *irqs,
> -				  struct pci_dev *dev)
> -{
> -	struct pci_controller *hose = pci_bus_to_host(dev->bus);
> -	struct pnv_phb *phb = hose->private_data;
> -	int i, hwirq;
> -
> -	for (i = 1; i < CXL_IRQ_RANGES; i++) {
> -		if (!irqs->range[i])
> -			continue;
> -		pr_devel("cxl release irq range 0x%x: offset: 0x%lx  limit: %ld\n",
> -			 i, irqs->offset[i],
> -			 irqs->range[i]);
> -		hwirq = irqs->offset[i] - phb->msi_base;
> -		msi_bitmap_free_hwirqs(&phb->msi_bmp, hwirq,
> -				       irqs->range[i]);
> -	}
> -}
> -EXPORT_SYMBOL(pnv_cxl_release_hwirq_ranges);
> -
> -int pnv_cxl_alloc_hwirq_ranges(struct cxl_irq_ranges *irqs,
> -			       struct pci_dev *dev, int num)
> -{
> -	struct pci_controller *hose = pci_bus_to_host(dev->bus);
> -	struct pnv_phb *phb = hose->private_data;
> -	int i, hwirq, try;
> -
> -	memset(irqs, 0, sizeof(struct cxl_irq_ranges));
> -
> -	/* 0 is reserved for the multiplexed PSL DSI interrupt */
> -	for (i = 1; i < CXL_IRQ_RANGES && num; i++) {
> -		try = num;
> -		while (try) {
> -			hwirq = msi_bitmap_alloc_hwirqs(&phb->msi_bmp, try);
> -			if (hwirq >= 0)
> -				break;
> -			try /= 2;
> -		}
> -		if (!try)
> -			goto fail;
> -
> -		irqs->offset[i] = phb->msi_base + hwirq;
> -		irqs->range[i] = try;
> -		pr_devel("cxl alloc irq range 0x%x: offset: 0x%lx  limit: %li\n",
> -			 i, irqs->offset[i], irqs->range[i]);
> -		num -= try;
> -	}
> -	if (num)
> -		goto fail;
> -
> -	return 0;
> -fail:
> -	pnv_cxl_release_hwirq_ranges(irqs, dev);
> -	return -ENOSPC;
> -}
> -EXPORT_SYMBOL(pnv_cxl_alloc_hwirq_ranges);
> -
> -int pnv_cxl_get_irq_count(struct pci_dev *dev)
> -{
> -	struct pci_controller *hose = pci_bus_to_host(dev->bus);
> -	struct pnv_phb *phb = hose->private_data;
> -
> -	return phb->msi_bmp.irq_count;
> -}
> -EXPORT_SYMBOL(pnv_cxl_get_irq_count);
> -
> -int pnv_cxl_ioda_msi_setup(struct pci_dev *dev, unsigned int hwirq,
> -			   unsigned int virq)
> -{
> -	struct pci_controller *hose = pci_bus_to_host(dev->bus);
> -	struct pnv_phb *phb = hose->private_data;
> -	unsigned int xive_num = hwirq - phb->msi_base;
> -	struct pnv_ioda_pe *pe;
> -	int rc;
> -
> -	if (!(pe = pnv_ioda_get_pe(dev)))
> -		return -ENODEV;
> -
> -	/* Assign XIVE to PE */
> -	rc = opal_pci_set_xive_pe(phb->opal_id, pe->pe_number, xive_num);
> -	if (rc) {
> -		pe_warn(pe, "%s: OPAL error %d setting msi_base 0x%x "
> -			"hwirq 0x%x XIVE 0x%x PE\n",
> -			pci_name(dev), rc, phb->msi_base, hwirq, xive_num);
> -		return -EIO;
> -	}
> -	pnv_set_msi_irq_chip(phb, virq);
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL(pnv_cxl_ioda_msi_setup);
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index b0a14e48175c..d2a8e0287811 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -39,8 +39,6 @@
>   #include <asm/mmzone.h>
>   #include <asm/xive.h>
>   
> -#include <misc/cxl-base.h>
> -
>   #include "powernv.h"
>   #include "pci.h"
>   #include "../../../../drivers/pci/pci.h"
> @@ -1636,47 +1634,6 @@ int64_t pnv_opal_pci_msi_eoi(struct irq_data *d)
>   	return opal_pci_msi_eoi(phb->opal_id, d->parent_data->hwirq);
>   }
>   
> -/*
> - * The IRQ data is mapped in the XICS domain, with OPAL HW IRQ numbers
> - */
> -static void pnv_ioda2_msi_eoi(struct irq_data *d)
> -{
> -	int64_t rc;
> -	unsigned int hw_irq = (unsigned int)irqd_to_hwirq(d);
> -	struct pci_controller *hose = irq_data_get_irq_chip_data(d);
> -	struct pnv_phb *phb = hose->private_data;
> -
> -	rc = opal_pci_msi_eoi(phb->opal_id, hw_irq);
> -	WARN_ON_ONCE(rc);
> -
> -	icp_native_eoi(d);
> -}
> -
> -/* P8/CXL only */
> -void pnv_set_msi_irq_chip(struct pnv_phb *phb, unsigned int virq)
> -{
> -	struct irq_data *idata;
> -	struct irq_chip *ichip;
> -
> -	/* The MSI EOI OPAL call is only needed on PHB3 */
> -	if (phb->model != PNV_PHB_MODEL_PHB3)
> -		return;
> -
> -	if (!phb->ioda.irq_chip_init) {
> -		/*
> -		 * First time we setup an MSI IRQ, we need to setup the
> -		 * corresponding IRQ chip to route correctly.
> -		 */
> -		idata = irq_get_irq_data(virq);
> -		ichip = irq_data_get_irq_chip(idata);
> -		phb->ioda.irq_chip_init = 1;
> -		phb->ioda.irq_chip = *ichip;
> -		phb->ioda.irq_chip.irq_eoi = pnv_ioda2_msi_eoi;
> -	}
> -	irq_set_chip(virq, &phb->ioda.irq_chip);
> -	irq_set_chip_data(virq, phb->hose);
> -}
> -
>   static struct irq_chip pnv_pci_msi_irq_chip;
>   
>   /*
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
> index 35f566aa0424..b2c1da025410 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -14,7 +14,6 @@
>   #include <linux/io.h>
>   #include <linux/msi.h>
>   #include <linux/iommu.h>
> -#include <linux/sched/mm.h>
>   
>   #include <asm/sections.h>
>   #include <asm/io.h>
> @@ -33,8 +32,6 @@
>   #include "powernv.h"
>   #include "pci.h"
>   
> -static DEFINE_MUTEX(tunnel_mutex);
> -
>   int pnv_pci_get_slot_id(struct device_node *np, uint64_t *id)
>   {
>   	struct device_node *node = np;
> @@ -744,64 +741,6 @@ struct iommu_table *pnv_pci_table_alloc(int nid)
>   	return tbl;
>   }
>   
> -struct device_node *pnv_pci_get_phb_node(struct pci_dev *dev)
> -{
> -	struct pci_controller *hose = pci_bus_to_host(dev->bus);
> -
> -	return of_node_get(hose->dn);
> -}
> -EXPORT_SYMBOL(pnv_pci_get_phb_node);
> -
> -int pnv_pci_set_tunnel_bar(struct pci_dev *dev, u64 addr, int enable)
> -{
> -	struct pnv_phb *phb = pci_bus_to_pnvhb(dev->bus);
> -	u64 tunnel_bar;
> -	__be64 val;
> -	int rc;
> -
> -	if (!opal_check_token(OPAL_PCI_GET_PBCQ_TUNNEL_BAR))
> -		return -ENXIO;
> -	if (!opal_check_token(OPAL_PCI_SET_PBCQ_TUNNEL_BAR))
> -		return -ENXIO;
> -
> -	mutex_lock(&tunnel_mutex);
> -	rc = opal_pci_get_pbcq_tunnel_bar(phb->opal_id, &val);
> -	if (rc != OPAL_SUCCESS) {
> -		rc = -EIO;
> -		goto out;
> -	}
> -	tunnel_bar = be64_to_cpu(val);
> -	if (enable) {
> -		/*
> -		* Only one device per PHB can use atomics.
> -		* Our policy is first-come, first-served.
> -		*/
> -		if (tunnel_bar) {
> -			if (tunnel_bar != addr)
> -				rc = -EBUSY;
> -			else
> -				rc = 0;	/* Setting same address twice is ok */
> -			goto out;
> -		}
> -	} else {
> -		/*
> -		* The device that owns atomics and wants to release
> -		* them must pass the same address with enable == 0.
> -		*/
> -		if (tunnel_bar != addr) {
> -			rc = -EPERM;
> -			goto out;
> -		}
> -		addr = 0x0ULL;
> -	}
> -	rc = opal_pci_set_pbcq_tunnel_bar(phb->opal_id, addr);
> -	rc = opal_error_code(rc);
> -out:
> -	mutex_unlock(&tunnel_mutex);
> -	return rc;
> -}
> -EXPORT_SYMBOL_GPL(pnv_pci_set_tunnel_bar);
> -
>   void pnv_pci_shutdown(void)
>   {
>   	struct pci_controller *hose;
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
> index 93fba1f8661f..42075501663b 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -163,7 +163,6 @@ struct pnv_phb {
>   		unsigned int		*io_segmap;
>   
>   		/* IRQ chip */
> -		int			irq_chip_init;
>   		struct irq_chip		irq_chip;
>   
>   		/* Sorted list of used PE's based
> @@ -281,7 +280,6 @@ extern int pnv_eeh_phb_reset(struct pci_controller *hose, int option);
>   
>   extern struct pnv_ioda_pe *pnv_pci_bdfn_to_pe(struct pnv_phb *phb, u16 bdfn);
>   extern struct pnv_ioda_pe *pnv_ioda_get_pe(struct pci_dev *dev);
> -extern void pnv_set_msi_irq_chip(struct pnv_phb *phb, unsigned int virq);
>   extern unsigned long pnv_pci_ioda2_get_table_size(__u32 page_shift,
>   		__u64 window_size, __u32 levels);
>   extern int pnv_eeh_post_init(void);
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 56bc72c7ce4a..6b37d61150ee 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -641,7 +641,6 @@ source "drivers/misc/mei/Kconfig"
>   source "drivers/misc/vmw_vmci/Kconfig"
>   source "drivers/misc/genwqe/Kconfig"
>   source "drivers/misc/echo/Kconfig"
> -source "drivers/misc/cxl/Kconfig"
>   source "drivers/misc/ocxl/Kconfig"
>   source "drivers/misc/bcm-vk/Kconfig"
>   source "drivers/misc/cardreader/Kconfig"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index 545aad06d088..d6c917229c45 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -50,7 +50,6 @@ obj-$(CONFIG_SRAM)		+= sram.o
>   obj-$(CONFIG_SRAM_EXEC)		+= sram-exec.o
>   obj-$(CONFIG_GENWQE)		+= genwqe/
>   obj-$(CONFIG_ECHO)		+= echo/
> -obj-$(CONFIG_CXL_BASE)		+= cxl/
>   obj-$(CONFIG_DW_XDATA_PCIE)	+= dw-xdata-pcie.o
>   obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
>   obj-$(CONFIG_OCXL)		+= ocxl/
> diff --git a/drivers/misc/cxl/Kconfig b/drivers/misc/cxl/Kconfig
> deleted file mode 100644
> index 15307f5e4307..000000000000
> --- a/drivers/misc/cxl/Kconfig
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0-only
> -#
> -# IBM Coherent Accelerator (CXL) compatible devices
> -#
> -
> -config CXL_BASE
> -	bool
> -	select PPC_COPRO_BASE
> -	select PPC_64S_HASH_MMU
> -
> -config CXL
> -	tristate "Support for IBM Coherent Accelerators (CXL) (DEPRECATED)"
> -	depends on PPC_POWERNV && PCI_MSI && EEH
> -	select CXL_BASE
> -	help
> -	  The cxl driver is deprecated and will be removed in a future
> -	  kernel release.
> -
> -	  Select this option to enable driver support for IBM Coherent
> -	  Accelerators (CXL).  CXL is otherwise known as Coherent Accelerator
> -	  Processor Interface (CAPI).  CAPI allows accelerators in FPGAs to be
> -	  coherently attached to a CPU via an MMU.  This driver enables
> -	  userspace programs to access these accelerators via /dev/cxl/afuM.N
> -	  devices.
> -
> -	  CAPI adapters are found in POWER8 based systems.
> -
> -	  If unsure, say N.
> diff --git a/drivers/misc/cxl/Makefile b/drivers/misc/cxl/Makefile
> deleted file mode 100644
> index 5eea61b9584f..000000000000
> --- a/drivers/misc/cxl/Makefile
> +++ /dev/null
> @@ -1,14 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0
> -ccflags-y			:= $(call cc-disable-warning, unused-const-variable)
> -ccflags-$(CONFIG_PPC_WERROR)	+= -Werror
> -
> -cxl-y				+= main.o file.o irq.o fault.o native.o
> -cxl-y				+= context.o sysfs.o pci.o trace.o
> -cxl-y				+= vphb.o api.o cxllib.o
> -cxl-$(CONFIG_PPC_PSERIES)	+= flash.o guest.o of.o hcalls.o
> -cxl-$(CONFIG_DEBUG_FS)		+= debugfs.o
> -obj-$(CONFIG_CXL)		+= cxl.o
> -obj-$(CONFIG_CXL_BASE)		+= base.o
> -
> -# For tracepoints to include our trace.h from tracepoint infrastructure:
> -CFLAGS_trace.o := -I$(src)
> diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
> deleted file mode 100644
> index d85c56530863..000000000000
> --- a/drivers/misc/cxl/api.c
> +++ /dev/null
> @@ -1,532 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * Copyright 2014 IBM Corp.
> - */
> -
> -#include <linux/pci.h>
> -#include <linux/slab.h>
> -#include <linux/file.h>
> -#include <misc/cxl.h>
> -#include <linux/module.h>
> -#include <linux/mount.h>
> -#include <linux/pseudo_fs.h>
> -#include <linux/sched/mm.h>
> -#include <linux/mmu_context.h>
> -#include <linux/irqdomain.h>
> -
> -#include "cxl.h"
> -
> -/*
> - * Since we want to track memory mappings to be able to force-unmap
> - * when the AFU is no longer reachable, we need an inode. For devices
> - * opened through the cxl user API, this is not a problem, but a
> - * userland process can also get a cxl fd through the cxl_get_fd()
> - * API, which is used by the cxlflash driver.
> - *
> - * Therefore we implement our own simple pseudo-filesystem and inode
> - * allocator. We don't use the anonymous inode, as we need the
> - * meta-data associated with it (address_space) and it is shared by
> - * other drivers/processes, so it could lead to cxl unmapping VMAs
> - * from random processes.
> - */
> -
> -#define CXL_PSEUDO_FS_MAGIC	0x1697697f
> -
> -static int cxl_fs_cnt;
> -static struct vfsmount *cxl_vfs_mount;
> -
> -static int cxl_fs_init_fs_context(struct fs_context *fc)
> -{
> -	return init_pseudo(fc, CXL_PSEUDO_FS_MAGIC) ? 0 : -ENOMEM;
> -}
> -
> -static struct file_system_type cxl_fs_type = {
> -	.name		= "cxl",
> -	.owner		= THIS_MODULE,
> -	.init_fs_context = cxl_fs_init_fs_context,
> -	.kill_sb	= kill_anon_super,
> -};
> -
> -
> -void cxl_release_mapping(struct cxl_context *ctx)
> -{
> -	if (ctx->kernelapi && ctx->mapping)
> -		simple_release_fs(&cxl_vfs_mount, &cxl_fs_cnt);
> -}
> -
> -static struct file *cxl_getfile(const char *name,
> -				const struct file_operations *fops,
> -				void *priv, int flags)
> -{
> -	struct file *file;
> -	struct inode *inode;
> -	int rc;
> -
> -	/* strongly inspired by anon_inode_getfile() */
> -
> -	if (fops->owner && !try_module_get(fops->owner))
> -		return ERR_PTR(-ENOENT);
> -
> -	rc = simple_pin_fs(&cxl_fs_type, &cxl_vfs_mount, &cxl_fs_cnt);
> -	if (rc < 0) {
> -		pr_err("Cannot mount cxl pseudo filesystem: %d\n", rc);
> -		file = ERR_PTR(rc);
> -		goto err_module;
> -	}
> -
> -	inode = alloc_anon_inode(cxl_vfs_mount->mnt_sb);
> -	if (IS_ERR(inode)) {
> -		file = ERR_CAST(inode);
> -		goto err_fs;
> -	}
> -
> -	file = alloc_file_pseudo(inode, cxl_vfs_mount, name,
> -				 flags & (O_ACCMODE | O_NONBLOCK), fops);
> -	if (IS_ERR(file))
> -		goto err_inode;
> -
> -	file->private_data = priv;
> -
> -	return file;
> -
> -err_inode:
> -	iput(inode);
> -err_fs:
> -	simple_release_fs(&cxl_vfs_mount, &cxl_fs_cnt);
> -err_module:
> -	module_put(fops->owner);
> -	return file;
> -}
> -
> -struct cxl_context *cxl_dev_context_init(struct pci_dev *dev)
> -{
> -	struct cxl_afu *afu;
> -	struct cxl_context  *ctx;
> -	int rc;
> -
> -	afu = cxl_pci_to_afu(dev);
> -	if (IS_ERR(afu))
> -		return ERR_CAST(afu);
> -
> -	ctx = cxl_context_alloc();
> -	if (!ctx)
> -		return ERR_PTR(-ENOMEM);
> -
> -	ctx->kernelapi = true;
> -
> -	/* Make it a slave context.  We can promote it later? */
> -	rc = cxl_context_init(ctx, afu, false);
> -	if (rc)
> -		goto err_ctx;
> -
> -	return ctx;
> -
> -err_ctx:
> -	kfree(ctx);
> -	return ERR_PTR(rc);
> -}
> -EXPORT_SYMBOL_GPL(cxl_dev_context_init);
> -
> -struct cxl_context *cxl_get_context(struct pci_dev *dev)
> -{
> -	return dev->dev.archdata.cxl_ctx;
> -}
> -EXPORT_SYMBOL_GPL(cxl_get_context);
> -
> -int cxl_release_context(struct cxl_context *ctx)
> -{
> -	if (ctx->status >= STARTED)
> -		return -EBUSY;
> -
> -	cxl_context_free(ctx);
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL_GPL(cxl_release_context);
> -
> -static irq_hw_number_t cxl_find_afu_irq(struct cxl_context *ctx, int num)
> -{
> -	__u16 range;
> -	int r;
> -
> -	for (r = 0; r < CXL_IRQ_RANGES; r++) {
> -		range = ctx->irqs.range[r];
> -		if (num < range) {
> -			return ctx->irqs.offset[r] + num;
> -		}
> -		num -= range;
> -	}
> -	return 0;
> -}
> -
> -
> -int cxl_set_priv(struct cxl_context *ctx, void *priv)
> -{
> -	if (!ctx)
> -		return -EINVAL;
> -
> -	ctx->priv = priv;
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL_GPL(cxl_set_priv);
> -
> -void *cxl_get_priv(struct cxl_context *ctx)
> -{
> -	if (!ctx)
> -		return ERR_PTR(-EINVAL);
> -
> -	return ctx->priv;
> -}
> -EXPORT_SYMBOL_GPL(cxl_get_priv);
> -
> -int cxl_allocate_afu_irqs(struct cxl_context *ctx, int num)
> -{
> -	int res;
> -	irq_hw_number_t hwirq;
> -
> -	if (num == 0)
> -		num = ctx->afu->pp_irqs;
> -	res = afu_allocate_irqs(ctx, num);
> -	if (res)
> -		return res;
> -
> -	if (!cpu_has_feature(CPU_FTR_HVMODE)) {
> -		/* In a guest, the PSL interrupt is not multiplexed. It was
> -		 * allocated above, and we need to set its handler
> -		 */
> -		hwirq = cxl_find_afu_irq(ctx, 0);
> -		if (hwirq)
> -			cxl_map_irq(ctx->afu->adapter, hwirq, cxl_ops->psl_interrupt, ctx, "psl");
> -	}
> -
> -	if (ctx->status == STARTED) {
> -		if (cxl_ops->update_ivtes)
> -			cxl_ops->update_ivtes(ctx);
> -		else WARN(1, "BUG: cxl_allocate_afu_irqs must be called prior to starting the context on this platform\n");
> -	}
> -
> -	return res;
> -}
> -EXPORT_SYMBOL_GPL(cxl_allocate_afu_irqs);
> -
> -void cxl_free_afu_irqs(struct cxl_context *ctx)
> -{
> -	irq_hw_number_t hwirq;
> -	unsigned int virq;
> -
> -	if (!cpu_has_feature(CPU_FTR_HVMODE)) {
> -		hwirq = cxl_find_afu_irq(ctx, 0);
> -		if (hwirq) {
> -			virq = irq_find_mapping(NULL, hwirq);
> -			if (virq)
> -				cxl_unmap_irq(virq, ctx);
> -		}
> -	}
> -	afu_irq_name_free(ctx);
> -	cxl_ops->release_irq_ranges(&ctx->irqs, ctx->afu->adapter);
> -}
> -EXPORT_SYMBOL_GPL(cxl_free_afu_irqs);
> -
> -int cxl_map_afu_irq(struct cxl_context *ctx, int num,
> -		    irq_handler_t handler, void *cookie, char *name)
> -{
> -	irq_hw_number_t hwirq;
> -
> -	/*
> -	 * Find interrupt we are to register.
> -	 */
> -	hwirq = cxl_find_afu_irq(ctx, num);
> -	if (!hwirq)
> -		return -ENOENT;
> -
> -	return cxl_map_irq(ctx->afu->adapter, hwirq, handler, cookie, name);
> -}
> -EXPORT_SYMBOL_GPL(cxl_map_afu_irq);
> -
> -void cxl_unmap_afu_irq(struct cxl_context *ctx, int num, void *cookie)
> -{
> -	irq_hw_number_t hwirq;
> -	unsigned int virq;
> -
> -	hwirq = cxl_find_afu_irq(ctx, num);
> -	if (!hwirq)
> -		return;
> -
> -	virq = irq_find_mapping(NULL, hwirq);
> -	if (virq)
> -		cxl_unmap_irq(virq, cookie);
> -}
> -EXPORT_SYMBOL_GPL(cxl_unmap_afu_irq);
> -
> -/*
> - * Start a context
> - * Code here similar to afu_ioctl_start_work().
> - */
> -int cxl_start_context(struct cxl_context *ctx, u64 wed,
> -		      struct task_struct *task)
> -{
> -	int rc = 0;
> -	bool kernel = true;
> -
> -	pr_devel("%s: pe: %i\n", __func__, ctx->pe);
> -
> -	mutex_lock(&ctx->status_mutex);
> -	if (ctx->status == STARTED)
> -		goto out; /* already started */
> -
> -	/*
> -	 * Increment the mapped context count for adapter. This also checks
> -	 * if adapter_context_lock is taken.
> -	 */
> -	rc = cxl_adapter_context_get(ctx->afu->adapter);
> -	if (rc)
> -		goto out;
> -
> -	if (task) {
> -		ctx->pid = get_task_pid(task, PIDTYPE_PID);
> -		kernel = false;
> -
> -		/* acquire a reference to the task's mm */
> -		ctx->mm = get_task_mm(current);
> -
> -		/* ensure this mm_struct can't be freed */
> -		cxl_context_mm_count_get(ctx);
> -
> -		if (ctx->mm) {
> -			/* decrement the use count from above */
> -			mmput(ctx->mm);
> -			/* make TLBIs for this context global */
> -			mm_context_add_copro(ctx->mm);
> -		}
> -	}
> -
> -	/*
> -	 * Increment driver use count. Enables global TLBIs for hash
> -	 * and callbacks to handle the segment table
> -	 */
> -	cxl_ctx_get();
> -
> -	/* See the comment in afu_ioctl_start_work() */
> -	smp_mb();
> -
> -	if ((rc = cxl_ops->attach_process(ctx, kernel, wed, 0))) {
> -		put_pid(ctx->pid);
> -		ctx->pid = NULL;
> -		cxl_adapter_context_put(ctx->afu->adapter);
> -		cxl_ctx_put();
> -		if (task) {
> -			cxl_context_mm_count_put(ctx);
> -			if (ctx->mm)
> -				mm_context_remove_copro(ctx->mm);
> -		}
> -		goto out;
> -	}
> -
> -	ctx->status = STARTED;
> -out:
> -	mutex_unlock(&ctx->status_mutex);
> -	return rc;
> -}
> -EXPORT_SYMBOL_GPL(cxl_start_context);
> -
> -int cxl_process_element(struct cxl_context *ctx)
> -{
> -	return ctx->external_pe;
> -}
> -EXPORT_SYMBOL_GPL(cxl_process_element);
> -
> -/* Stop a context.  Returns 0 on success, otherwise -Errno */
> -int cxl_stop_context(struct cxl_context *ctx)
> -{
> -	return __detach_context(ctx);
> -}
> -EXPORT_SYMBOL_GPL(cxl_stop_context);
> -
> -void cxl_set_master(struct cxl_context *ctx)
> -{
> -	ctx->master = true;
> -}
> -EXPORT_SYMBOL_GPL(cxl_set_master);
> -
> -/* wrappers around afu_* file ops which are EXPORTED */
> -int cxl_fd_open(struct inode *inode, struct file *file)
> -{
> -	return afu_open(inode, file);
> -}
> -EXPORT_SYMBOL_GPL(cxl_fd_open);
> -int cxl_fd_release(struct inode *inode, struct file *file)
> -{
> -	return afu_release(inode, file);
> -}
> -EXPORT_SYMBOL_GPL(cxl_fd_release);
> -long cxl_fd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> -{
> -	return afu_ioctl(file, cmd, arg);
> -}
> -EXPORT_SYMBOL_GPL(cxl_fd_ioctl);
> -int cxl_fd_mmap(struct file *file, struct vm_area_struct *vm)
> -{
> -	return afu_mmap(file, vm);
> -}
> -EXPORT_SYMBOL_GPL(cxl_fd_mmap);
> -__poll_t cxl_fd_poll(struct file *file, struct poll_table_struct *poll)
> -{
> -	return afu_poll(file, poll);
> -}
> -EXPORT_SYMBOL_GPL(cxl_fd_poll);
> -ssize_t cxl_fd_read(struct file *file, char __user *buf, size_t count,
> -			loff_t *off)
> -{
> -	return afu_read(file, buf, count, off);
> -}
> -EXPORT_SYMBOL_GPL(cxl_fd_read);
> -
> -#define PATCH_FOPS(NAME) if (!fops->NAME) fops->NAME = afu_fops.NAME
> -
> -/* Get a struct file and fd for a context and attach the ops */
> -struct file *cxl_get_fd(struct cxl_context *ctx, struct file_operations *fops,
> -			int *fd)
> -{
> -	struct file *file;
> -	int rc, flags, fdtmp;
> -	char *name = NULL;
> -
> -	/* only allow one per context */
> -	if (ctx->mapping)
> -		return ERR_PTR(-EEXIST);
> -
> -	flags = O_RDWR | O_CLOEXEC;
> -
> -	/* This code is similar to anon_inode_getfd() */
> -	rc = get_unused_fd_flags(flags);
> -	if (rc < 0)
> -		return ERR_PTR(rc);
> -	fdtmp = rc;
> -
> -	/*
> -	 * Patch the file ops.  Needs to be careful that this is rentrant safe.
> -	 */
> -	if (fops) {
> -		PATCH_FOPS(open);
> -		PATCH_FOPS(poll);
> -		PATCH_FOPS(read);
> -		PATCH_FOPS(release);
> -		PATCH_FOPS(unlocked_ioctl);
> -		PATCH_FOPS(compat_ioctl);
> -		PATCH_FOPS(mmap);
> -	} else /* use default ops */
> -		fops = (struct file_operations *)&afu_fops;
> -
> -	name = kasprintf(GFP_KERNEL, "cxl:%d", ctx->pe);
> -	file = cxl_getfile(name, fops, ctx, flags);
> -	kfree(name);
> -	if (IS_ERR(file))
> -		goto err_fd;
> -
> -	cxl_context_set_mapping(ctx, file->f_mapping);
> -	*fd = fdtmp;
> -	return file;
> -
> -err_fd:
> -	put_unused_fd(fdtmp);
> -	return NULL;
> -}
> -EXPORT_SYMBOL_GPL(cxl_get_fd);
> -
> -struct cxl_context *cxl_fops_get_context(struct file *file)
> -{
> -	return file->private_data;
> -}
> -EXPORT_SYMBOL_GPL(cxl_fops_get_context);
> -
> -void cxl_set_driver_ops(struct cxl_context *ctx,
> -			struct cxl_afu_driver_ops *ops)
> -{
> -	WARN_ON(!ops->fetch_event || !ops->event_delivered);
> -	atomic_set(&ctx->afu_driver_events, 0);
> -	ctx->afu_driver_ops = ops;
> -}
> -EXPORT_SYMBOL_GPL(cxl_set_driver_ops);
> -
> -void cxl_context_events_pending(struct cxl_context *ctx,
> -				unsigned int new_events)
> -{
> -	atomic_add(new_events, &ctx->afu_driver_events);
> -	wake_up_all(&ctx->wq);
> -}
> -EXPORT_SYMBOL_GPL(cxl_context_events_pending);
> -
> -int cxl_start_work(struct cxl_context *ctx,
> -		   struct cxl_ioctl_start_work *work)
> -{
> -	int rc;
> -
> -	/* code taken from afu_ioctl_start_work */
> -	if (!(work->flags & CXL_START_WORK_NUM_IRQS))
> -		work->num_interrupts = ctx->afu->pp_irqs;
> -	else if ((work->num_interrupts < ctx->afu->pp_irqs) ||
> -		 (work->num_interrupts > ctx->afu->irqs_max)) {
> -		return -EINVAL;
> -	}
> -
> -	rc = afu_register_irqs(ctx, work->num_interrupts);
> -	if (rc)
> -		return rc;
> -
> -	rc = cxl_start_context(ctx, work->work_element_descriptor, current);
> -	if (rc < 0) {
> -		afu_release_irqs(ctx, ctx);
> -		return rc;
> -	}
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL_GPL(cxl_start_work);
> -
> -void __iomem *cxl_psa_map(struct cxl_context *ctx)
> -{
> -	if (ctx->status != STARTED)
> -		return NULL;
> -
> -	pr_devel("%s: psn_phys%llx size:%llx\n",
> -		__func__, ctx->psn_phys, ctx->psn_size);
> -	return ioremap(ctx->psn_phys, ctx->psn_size);
> -}
> -EXPORT_SYMBOL_GPL(cxl_psa_map);
> -
> -void cxl_psa_unmap(void __iomem *addr)
> -{
> -	iounmap(addr);
> -}
> -EXPORT_SYMBOL_GPL(cxl_psa_unmap);
> -
> -int cxl_afu_reset(struct cxl_context *ctx)
> -{
> -	struct cxl_afu *afu = ctx->afu;
> -	int rc;
> -
> -	rc = cxl_ops->afu_reset(afu);
> -	if (rc)
> -		return rc;
> -
> -	return cxl_ops->afu_check_and_enable(afu);
> -}
> -EXPORT_SYMBOL_GPL(cxl_afu_reset);
> -
> -void cxl_perst_reloads_same_image(struct cxl_afu *afu,
> -				  bool perst_reloads_same_image)
> -{
> -	afu->adapter->perst_same_image = perst_reloads_same_image;
> -}
> -EXPORT_SYMBOL_GPL(cxl_perst_reloads_same_image);
> -
> -ssize_t cxl_read_adapter_vpd(struct pci_dev *dev, void *buf, size_t count)
> -{
> -	struct cxl_afu *afu = cxl_pci_to_afu(dev);
> -	if (IS_ERR(afu))
> -		return -ENODEV;
> -
> -	return cxl_ops->read_adapter_vpd(afu->adapter, buf, count);
> -}
> -EXPORT_SYMBOL_GPL(cxl_read_adapter_vpd);
> diff --git a/drivers/misc/cxl/base.c b/drivers/misc/cxl/base.c
> deleted file mode 100644
> index b054562c046e..000000000000
> --- a/drivers/misc/cxl/base.c
> +++ /dev/null
> @@ -1,126 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * Copyright 2014 IBM Corp.
> - */
> -
> -#include <linux/module.h>
> -#include <linux/rcupdate.h>
> -#include <asm/errno.h>
> -#include <misc/cxl-base.h>
> -#include <linux/of.h>
> -#include <linux/of_platform.h>
> -#include "cxl.h"
> -
> -/* protected by rcu */
> -static struct cxl_calls *cxl_calls;
> -
> -atomic_t cxl_use_count = ATOMIC_INIT(0);
> -EXPORT_SYMBOL(cxl_use_count);
> -
> -#ifdef CONFIG_CXL_MODULE
> -
> -static inline struct cxl_calls *cxl_calls_get(void)
> -{
> -	struct cxl_calls *calls = NULL;
> -
> -	rcu_read_lock();
> -	calls = rcu_dereference(cxl_calls);
> -	if (calls && !try_module_get(calls->owner))
> -		calls = NULL;
> -	rcu_read_unlock();
> -
> -	return calls;
> -}
> -
> -static inline void cxl_calls_put(struct cxl_calls *calls)
> -{
> -	BUG_ON(calls != cxl_calls);
> -
> -	/* we don't need to rcu this, as we hold a reference to the module */
> -	module_put(cxl_calls->owner);
> -}
> -
> -#else /* !defined CONFIG_CXL_MODULE */
> -
> -static inline struct cxl_calls *cxl_calls_get(void)
> -{
> -	return cxl_calls;
> -}
> -
> -static inline void cxl_calls_put(struct cxl_calls *calls) { }
> -
> -#endif /* CONFIG_CXL_MODULE */
> -
> -/* AFU refcount management */
> -struct cxl_afu *cxl_afu_get(struct cxl_afu *afu)
> -{
> -	return (get_device(&afu->dev) == NULL) ? NULL : afu;
> -}
> -EXPORT_SYMBOL_GPL(cxl_afu_get);
> -
> -void cxl_afu_put(struct cxl_afu *afu)
> -{
> -	put_device(&afu->dev);
> -}
> -EXPORT_SYMBOL_GPL(cxl_afu_put);
> -
> -void cxl_slbia(struct mm_struct *mm)
> -{
> -	struct cxl_calls *calls;
> -
> -	calls = cxl_calls_get();
> -	if (!calls)
> -		return;
> -
> -	if (cxl_ctx_in_use())
> -	    calls->cxl_slbia(mm);
> -
> -	cxl_calls_put(calls);
> -}
> -
> -int register_cxl_calls(struct cxl_calls *calls)
> -{
> -	if (cxl_calls)
> -		return -EBUSY;
> -
> -	rcu_assign_pointer(cxl_calls, calls);
> -	return 0;
> -}
> -EXPORT_SYMBOL_GPL(register_cxl_calls);
> -
> -void unregister_cxl_calls(struct cxl_calls *calls)
> -{
> -	BUG_ON(cxl_calls->owner != calls->owner);
> -	RCU_INIT_POINTER(cxl_calls, NULL);
> -	synchronize_rcu();
> -}
> -EXPORT_SYMBOL_GPL(unregister_cxl_calls);
> -
> -int cxl_update_properties(struct device_node *dn,
> -			  struct property *new_prop)
> -{
> -	return of_update_property(dn, new_prop);
> -}
> -EXPORT_SYMBOL_GPL(cxl_update_properties);
> -
> -static int __init cxl_base_init(void)
> -{
> -	struct device_node *np;
> -	struct platform_device *dev;
> -	int count = 0;
> -
> -	/*
> -	 * Scan for compatible devices in guest only
> -	 */
> -	if (cpu_has_feature(CPU_FTR_HVMODE))
> -		return 0;
> -
> -	for_each_compatible_node(np, NULL, "ibm,coherent-platform-facility") {
> -		dev = of_platform_device_create(np, NULL, NULL);
> -		if (dev)
> -			count++;
> -	}
> -	pr_devel("Found %d cxl device(s)\n", count);
> -	return 0;
> -}
> -device_initcall(cxl_base_init);
> diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
> deleted file mode 100644
> index 76b5ea66dfa1..000000000000
> --- a/drivers/misc/cxl/context.c
> +++ /dev/null
> @@ -1,362 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * Copyright 2014 IBM Corp.
> - */
> -
> -#include <linux/module.h>
> -#include <linux/kernel.h>
> -#include <linux/bitmap.h>
> -#include <linux/sched.h>
> -#include <linux/pid.h>
> -#include <linux/fs.h>
> -#include <linux/mm.h>
> -#include <linux/debugfs.h>
> -#include <linux/slab.h>
> -#include <linux/idr.h>
> -#include <linux/sched/mm.h>
> -#include <linux/mmu_context.h>
> -#include <asm/cputable.h>
> -#include <asm/current.h>
> -#include <asm/copro.h>
> -
> -#include "cxl.h"
> -
> -/*
> - * Allocates space for a CXL context.
> - */
> -struct cxl_context *cxl_context_alloc(void)
> -{
> -	return kzalloc(sizeof(struct cxl_context), GFP_KERNEL);
> -}
> -
> -/*
> - * Initialises a CXL context.
> - */
> -int cxl_context_init(struct cxl_context *ctx, struct cxl_afu *afu, bool master)
> -{
> -	int i;
> -
> -	ctx->afu = afu;
> -	ctx->master = master;
> -	ctx->pid = NULL; /* Set in start work ioctl */
> -	mutex_init(&ctx->mapping_lock);
> -	ctx->mapping = NULL;
> -	ctx->tidr = 0;
> -	ctx->assign_tidr = false;
> -
> -	if (cxl_is_power8()) {
> -		spin_lock_init(&ctx->sste_lock);
> -
> -		/*
> -		 * Allocate the segment table before we put it in the IDR so that we
> -		 * can always access it when dereferenced from IDR. For the same
> -		 * reason, the segment table is only destroyed after the context is
> -		 * removed from the IDR.  Access to this in the IOCTL is protected by
> -		 * Linux filesystem semantics (can't IOCTL until open is complete).
> -		 */
> -		i = cxl_alloc_sst(ctx);
> -		if (i)
> -			return i;
> -	}
> -
> -	INIT_WORK(&ctx->fault_work, cxl_handle_fault);
> -
> -	init_waitqueue_head(&ctx->wq);
> -	spin_lock_init(&ctx->lock);
> -
> -	ctx->irq_bitmap = NULL;
> -	ctx->pending_irq = false;
> -	ctx->pending_fault = false;
> -	ctx->pending_afu_err = false;
> -
> -	INIT_LIST_HEAD(&ctx->irq_names);
> -
> -	/*
> -	 * When we have to destroy all contexts in cxl_context_detach_all() we
> -	 * end up with afu_release_irqs() called from inside a
> -	 * idr_for_each_entry(). Hence we need to make sure that anything
> -	 * dereferenced from this IDR is ok before we allocate the IDR here.
> -	 * This clears out the IRQ ranges to ensure this.
> -	 */
> -	for (i = 0; i < CXL_IRQ_RANGES; i++)
> -		ctx->irqs.range[i] = 0;
> -
> -	mutex_init(&ctx->status_mutex);
> -
> -	ctx->status = OPENED;
> -
> -	/*
> -	 * Allocating IDR! We better make sure everything's setup that
> -	 * dereferences from it.
> -	 */
> -	mutex_lock(&afu->contexts_lock);
> -	idr_preload(GFP_KERNEL);
> -	i = idr_alloc(&ctx->afu->contexts_idr, ctx, 0,
> -		      ctx->afu->num_procs, GFP_NOWAIT);
> -	idr_preload_end();
> -	mutex_unlock(&afu->contexts_lock);
> -	if (i < 0)
> -		return i;
> -
> -	ctx->pe = i;
> -	if (cpu_has_feature(CPU_FTR_HVMODE)) {
> -		ctx->elem = &ctx->afu->native->spa[i];
> -		ctx->external_pe = ctx->pe;
> -	} else {
> -		ctx->external_pe = -1; /* assigned when attaching */
> -	}
> -	ctx->pe_inserted = false;
> -
> -	/*
> -	 * take a ref on the afu so that it stays alive at-least till
> -	 * this context is reclaimed inside reclaim_ctx.
> -	 */
> -	cxl_afu_get(afu);
> -	return 0;
> -}
> -
> -void cxl_context_set_mapping(struct cxl_context *ctx,
> -			struct address_space *mapping)
> -{
> -	mutex_lock(&ctx->mapping_lock);
> -	ctx->mapping = mapping;
> -	mutex_unlock(&ctx->mapping_lock);
> -}
> -
> -static vm_fault_t cxl_mmap_fault(struct vm_fault *vmf)
> -{
> -	struct vm_area_struct *vma = vmf->vma;
> -	struct cxl_context *ctx = vma->vm_file->private_data;
> -	u64 area, offset;
> -	vm_fault_t ret;
> -
> -	offset = vmf->pgoff << PAGE_SHIFT;
> -
> -	pr_devel("%s: pe: %i address: 0x%lx offset: 0x%llx\n",
> -			__func__, ctx->pe, vmf->address, offset);
> -
> -	if (ctx->afu->current_mode == CXL_MODE_DEDICATED) {
> -		area = ctx->afu->psn_phys;
> -		if (offset >= ctx->afu->adapter->ps_size)
> -			return VM_FAULT_SIGBUS;
> -	} else {
> -		area = ctx->psn_phys;
> -		if (offset >= ctx->psn_size)
> -			return VM_FAULT_SIGBUS;
> -	}
> -
> -	mutex_lock(&ctx->status_mutex);
> -
> -	if (ctx->status != STARTED) {
> -		mutex_unlock(&ctx->status_mutex);
> -		pr_devel("%s: Context not started, failing problem state access\n", __func__);
> -		if (ctx->mmio_err_ff) {
> -			if (!ctx->ff_page) {
> -				ctx->ff_page = alloc_page(GFP_USER);
> -				if (!ctx->ff_page)
> -					return VM_FAULT_OOM;
> -				memset(page_address(ctx->ff_page), 0xff, PAGE_SIZE);
> -			}
> -			get_page(ctx->ff_page);
> -			vmf->page = ctx->ff_page;
> -			vma->vm_page_prot = pgprot_cached(vma->vm_page_prot);
> -			return 0;
> -		}
> -		return VM_FAULT_SIGBUS;
> -	}
> -
> -	ret = vmf_insert_pfn(vma, vmf->address, (area + offset) >> PAGE_SHIFT);
> -
> -	mutex_unlock(&ctx->status_mutex);
> -
> -	return ret;
> -}
> -
> -static const struct vm_operations_struct cxl_mmap_vmops = {
> -	.fault = cxl_mmap_fault,
> -};
> -
> -/*
> - * Map a per-context mmio space into the given vma.
> - */
> -int cxl_context_iomap(struct cxl_context *ctx, struct vm_area_struct *vma)
> -{
> -	u64 start = vma->vm_pgoff << PAGE_SHIFT;
> -	u64 len = vma->vm_end - vma->vm_start;
> -
> -	if (ctx->afu->current_mode == CXL_MODE_DEDICATED) {
> -		if (start + len > ctx->afu->adapter->ps_size)
> -			return -EINVAL;
> -
> -		if (cxl_is_power9()) {
> -			/*
> -			 * Make sure there is a valid problem state
> -			 * area space for this AFU.
> -			 */
> -			if (ctx->master && !ctx->afu->psa) {
> -				pr_devel("AFU doesn't support mmio space\n");
> -				return -EINVAL;
> -			}
> -
> -			/* Can't mmap until the AFU is enabled */
> -			if (!ctx->afu->enabled)
> -				return -EBUSY;
> -		}
> -	} else {
> -		if (start + len > ctx->psn_size)
> -			return -EINVAL;
> -
> -		/* Make sure there is a valid per process space for this AFU */
> -		if ((ctx->master && !ctx->afu->psa) || (!ctx->afu->pp_psa)) {
> -			pr_devel("AFU doesn't support mmio space\n");
> -			return -EINVAL;
> -		}
> -
> -		/* Can't mmap until the AFU is enabled */
> -		if (!ctx->afu->enabled)
> -			return -EBUSY;
> -	}
> -
> -	pr_devel("%s: mmio physical: %llx pe: %i master:%i\n", __func__,
> -		 ctx->psn_phys, ctx->pe , ctx->master);
> -
> -	vm_flags_set(vma, VM_IO | VM_PFNMAP);
> -	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> -	vma->vm_ops = &cxl_mmap_vmops;
> -	return 0;
> -}
> -
> -/*
> - * Detach a context from the hardware. This disables interrupts and doesn't
> - * return until all outstanding interrupts for this context have completed. The
> - * hardware should no longer access *ctx after this has returned.
> - */
> -int __detach_context(struct cxl_context *ctx)
> -{
> -	enum cxl_context_status status;
> -
> -	mutex_lock(&ctx->status_mutex);
> -	status = ctx->status;
> -	ctx->status = CLOSED;
> -	mutex_unlock(&ctx->status_mutex);
> -	if (status != STARTED)
> -		return -EBUSY;
> -
> -	/* Only warn if we detached while the link was OK.
> -	 * If detach fails when hw is down, we don't care.
> -	 */
> -	WARN_ON(cxl_ops->detach_process(ctx) &&
> -		cxl_ops->link_ok(ctx->afu->adapter, ctx->afu));
> -	flush_work(&ctx->fault_work); /* Only needed for dedicated process */
> -
> -	/*
> -	 * Wait until no further interrupts are presented by the PSL
> -	 * for this context.
> -	 */
> -	if (cxl_ops->irq_wait)
> -		cxl_ops->irq_wait(ctx);
> -
> -	/* release the reference to the group leader and mm handling pid */
> -	put_pid(ctx->pid);
> -
> -	cxl_ctx_put();
> -
> -	/* Decrease the attached context count on the adapter */
> -	cxl_adapter_context_put(ctx->afu->adapter);
> -
> -	/* Decrease the mm count on the context */
> -	cxl_context_mm_count_put(ctx);
> -	if (ctx->mm)
> -		mm_context_remove_copro(ctx->mm);
> -	ctx->mm = NULL;
> -
> -	return 0;
> -}
> -
> -/*
> - * Detach the given context from the AFU. This doesn't actually
> - * free the context but it should stop the context running in hardware
> - * (ie. prevent this context from generating any further interrupts
> - * so that it can be freed).
> - */
> -void cxl_context_detach(struct cxl_context *ctx)
> -{
> -	int rc;
> -
> -	rc = __detach_context(ctx);
> -	if (rc)
> -		return;
> -
> -	afu_release_irqs(ctx, ctx);
> -	wake_up_all(&ctx->wq);
> -}
> -
> -/*
> - * Detach all contexts on the given AFU.
> - */
> -void cxl_context_detach_all(struct cxl_afu *afu)
> -{
> -	struct cxl_context *ctx;
> -	int tmp;
> -
> -	mutex_lock(&afu->contexts_lock);
> -	idr_for_each_entry(&afu->contexts_idr, ctx, tmp) {
> -		/*
> -		 * Anything done in here needs to be setup before the IDR is
> -		 * created and torn down after the IDR removed
> -		 */
> -		cxl_context_detach(ctx);
> -
> -		/*
> -		 * We are force detaching - remove any active PSA mappings so
> -		 * userspace cannot interfere with the card if it comes back.
> -		 * Easiest way to exercise this is to unbind and rebind the
> -		 * driver via sysfs while it is in use.
> -		 */
> -		mutex_lock(&ctx->mapping_lock);
> -		if (ctx->mapping)
> -			unmap_mapping_range(ctx->mapping, 0, 0, 1);
> -		mutex_unlock(&ctx->mapping_lock);
> -	}
> -	mutex_unlock(&afu->contexts_lock);
> -}
> -
> -static void reclaim_ctx(struct rcu_head *rcu)
> -{
> -	struct cxl_context *ctx = container_of(rcu, struct cxl_context, rcu);
> -
> -	if (cxl_is_power8())
> -		free_page((u64)ctx->sstp);
> -	if (ctx->ff_page)
> -		__free_page(ctx->ff_page);
> -	ctx->sstp = NULL;
> -
> -	bitmap_free(ctx->irq_bitmap);
> -
> -	/* Drop ref to the afu device taken during cxl_context_init */
> -	cxl_afu_put(ctx->afu);
> -
> -	kfree(ctx);
> -}
> -
> -void cxl_context_free(struct cxl_context *ctx)
> -{
> -	if (ctx->kernelapi && ctx->mapping)
> -		cxl_release_mapping(ctx);
> -	mutex_lock(&ctx->afu->contexts_lock);
> -	idr_remove(&ctx->afu->contexts_idr, ctx->pe);
> -	mutex_unlock(&ctx->afu->contexts_lock);
> -	call_rcu(&ctx->rcu, reclaim_ctx);
> -}
> -
> -void cxl_context_mm_count_get(struct cxl_context *ctx)
> -{
> -	if (ctx->mm)
> -		mmgrab(ctx->mm);
> -}
> -
> -void cxl_context_mm_count_put(struct cxl_context *ctx)
> -{
> -	if (ctx->mm)
> -		mmdrop(ctx->mm);
> -}
> diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
> deleted file mode 100644
> index 6ad0ab892675..000000000000
> --- a/drivers/misc/cxl/cxl.h
> +++ /dev/null
> @@ -1,1135 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * Copyright 2014 IBM Corp.
> - */
> -
> -#ifndef _CXL_H_
> -#define _CXL_H_
> -
> -#include <linux/interrupt.h>
> -#include <linux/semaphore.h>
> -#include <linux/device.h>
> -#include <linux/types.h>
> -#include <linux/cdev.h>
> -#include <linux/pid.h>
> -#include <linux/io.h>
> -#include <linux/pci.h>
> -#include <linux/fs.h>
> -#include <asm/cputable.h>
> -#include <asm/mmu.h>
> -#include <asm/reg.h>
> -#include <misc/cxl-base.h>
> -
> -#include <misc/cxl.h>
> -#include <uapi/misc/cxl.h>
> -
> -extern uint cxl_verbose;
> -
> -struct property;
> -
> -#define CXL_TIMEOUT 5
> -
> -/*
> - * Bump version each time a user API change is made, whether it is
> - * backwards compatible ot not.
> - */
> -#define CXL_API_VERSION 3
> -#define CXL_API_VERSION_COMPATIBLE 1
> -
> -/*
> - * Opaque types to avoid accidentally passing registers for the wrong MMIO
> - *
> - * At the end of the day, I'm not married to using typedef here, but it might
> - * (and has!) help avoid bugs like mixing up CXL_PSL_CtxTime and
> - * CXL_PSL_CtxTime_An, or calling cxl_p1n_write instead of cxl_p1_write.
> - *
> - * I'm quite happy if these are changed back to #defines before upstreaming, it
> - * should be little more than a regexp search+replace operation in this file.
> - */
> -typedef struct {
> -	const int x;
> -} cxl_p1_reg_t;
> -typedef struct {
> -	const int x;
> -} cxl_p1n_reg_t;
> -typedef struct {
> -	const int x;
> -} cxl_p2n_reg_t;
> -#define cxl_reg_off(reg) \
> -	(reg.x)
> -
> -/* Memory maps. Ref CXL Appendix A */
> -
> -/* PSL Privilege 1 Memory Map */
> -/* Configuration and Control area - CAIA 1&2 */
> -static const cxl_p1_reg_t CXL_PSL_CtxTime = {0x0000};
> -static const cxl_p1_reg_t CXL_PSL_ErrIVTE = {0x0008};
> -static const cxl_p1_reg_t CXL_PSL_KEY1    = {0x0010};
> -static const cxl_p1_reg_t CXL_PSL_KEY2    = {0x0018};
> -static const cxl_p1_reg_t CXL_PSL_Control = {0x0020};
> -/* Downloading */
> -static const cxl_p1_reg_t CXL_PSL_DLCNTL  = {0x0060};
> -static const cxl_p1_reg_t CXL_PSL_DLADDR  = {0x0068};
> -
> -/* PSL Lookaside Buffer Management Area - CAIA 1 */
> -static const cxl_p1_reg_t CXL_PSL_LBISEL  = {0x0080};
> -static const cxl_p1_reg_t CXL_PSL_SLBIE   = {0x0088};
> -static const cxl_p1_reg_t CXL_PSL_SLBIA   = {0x0090};
> -static const cxl_p1_reg_t CXL_PSL_TLBIE   = {0x00A0};
> -static const cxl_p1_reg_t CXL_PSL_TLBIA   = {0x00A8};
> -static const cxl_p1_reg_t CXL_PSL_AFUSEL  = {0x00B0};
> -
> -/* 0x00C0:7EFF Implementation dependent area */
> -/* PSL registers - CAIA 1 */
> -static const cxl_p1_reg_t CXL_PSL_FIR1      = {0x0100};
> -static const cxl_p1_reg_t CXL_PSL_FIR2      = {0x0108};
> -static const cxl_p1_reg_t CXL_PSL_Timebase  = {0x0110};
> -static const cxl_p1_reg_t CXL_PSL_VERSION   = {0x0118};
> -static const cxl_p1_reg_t CXL_PSL_RESLCKTO  = {0x0128};
> -static const cxl_p1_reg_t CXL_PSL_TB_CTLSTAT = {0x0140};
> -static const cxl_p1_reg_t CXL_PSL_FIR_CNTL  = {0x0148};
> -static const cxl_p1_reg_t CXL_PSL_DSNDCTL   = {0x0150};
> -static const cxl_p1_reg_t CXL_PSL_SNWRALLOC = {0x0158};
> -static const cxl_p1_reg_t CXL_PSL_TRACE     = {0x0170};
> -/* PSL registers - CAIA 2 */
> -static const cxl_p1_reg_t CXL_PSL9_CONTROL  = {0x0020};
> -static const cxl_p1_reg_t CXL_XSL9_INV      = {0x0110};
> -static const cxl_p1_reg_t CXL_XSL9_DBG      = {0x0130};
> -static const cxl_p1_reg_t CXL_XSL9_DEF      = {0x0140};
> -static const cxl_p1_reg_t CXL_XSL9_DSNCTL   = {0x0168};
> -static const cxl_p1_reg_t CXL_PSL9_FIR1     = {0x0300};
> -static const cxl_p1_reg_t CXL_PSL9_FIR_MASK = {0x0308};
> -static const cxl_p1_reg_t CXL_PSL9_Timebase = {0x0310};
> -static const cxl_p1_reg_t CXL_PSL9_DEBUG    = {0x0320};
> -static const cxl_p1_reg_t CXL_PSL9_FIR_CNTL = {0x0348};
> -static const cxl_p1_reg_t CXL_PSL9_DSNDCTL  = {0x0350};
> -static const cxl_p1_reg_t CXL_PSL9_TB_CTLSTAT = {0x0340};
> -static const cxl_p1_reg_t CXL_PSL9_TRACECFG = {0x0368};
> -static const cxl_p1_reg_t CXL_PSL9_APCDEDALLOC = {0x0378};
> -static const cxl_p1_reg_t CXL_PSL9_APCDEDTYPE = {0x0380};
> -static const cxl_p1_reg_t CXL_PSL9_TNR_ADDR = {0x0388};
> -static const cxl_p1_reg_t CXL_PSL9_CTCCFG = {0x0390};
> -static const cxl_p1_reg_t CXL_PSL9_GP_CT = {0x0398};
> -static const cxl_p1_reg_t CXL_XSL9_IERAT = {0x0588};
> -static const cxl_p1_reg_t CXL_XSL9_ILPP  = {0x0590};
> -
> -/* 0x7F00:7FFF Reserved PCIe MSI-X Pending Bit Array area */
> -/* 0x8000:FFFF Reserved PCIe MSI-X Table Area */
> -
> -/* PSL Slice Privilege 1 Memory Map */
> -/* Configuration Area - CAIA 1&2 */
> -static const cxl_p1n_reg_t CXL_PSL_SR_An          = {0x00};
> -static const cxl_p1n_reg_t CXL_PSL_LPID_An        = {0x08};
> -static const cxl_p1n_reg_t CXL_PSL_AMBAR_An       = {0x10};
> -static const cxl_p1n_reg_t CXL_PSL_SPOffset_An    = {0x18};
> -static const cxl_p1n_reg_t CXL_PSL_ID_An          = {0x20};
> -static const cxl_p1n_reg_t CXL_PSL_SERR_An        = {0x28};
> -/* Memory Management and Lookaside Buffer Management - CAIA 1*/
> -static const cxl_p1n_reg_t CXL_PSL_SDR_An         = {0x30};
> -/* Memory Management and Lookaside Buffer Management - CAIA 1&2 */
> -static const cxl_p1n_reg_t CXL_PSL_AMOR_An        = {0x38};
> -/* Pointer Area - CAIA 1&2 */
> -static const cxl_p1n_reg_t CXL_HAURP_An           = {0x80};
> -static const cxl_p1n_reg_t CXL_PSL_SPAP_An        = {0x88};
> -static const cxl_p1n_reg_t CXL_PSL_LLCMD_An       = {0x90};
> -/* Control Area - CAIA 1&2 */
> -static const cxl_p1n_reg_t CXL_PSL_SCNTL_An       = {0xA0};
> -static const cxl_p1n_reg_t CXL_PSL_CtxTime_An     = {0xA8};
> -static const cxl_p1n_reg_t CXL_PSL_IVTE_Offset_An = {0xB0};
> -static const cxl_p1n_reg_t CXL_PSL_IVTE_Limit_An  = {0xB8};
> -/* 0xC0:FF Implementation Dependent Area - CAIA 1&2 */
> -static const cxl_p1n_reg_t CXL_PSL_FIR_SLICE_An   = {0xC0};
> -static const cxl_p1n_reg_t CXL_AFU_DEBUG_An       = {0xC8};
> -/* 0xC0:FF Implementation Dependent Area - CAIA 1 */
> -static const cxl_p1n_reg_t CXL_PSL_APCALLOC_A     = {0xD0};
> -static const cxl_p1n_reg_t CXL_PSL_COALLOC_A      = {0xD8};
> -static const cxl_p1n_reg_t CXL_PSL_RXCTL_A        = {0xE0};
> -static const cxl_p1n_reg_t CXL_PSL_SLICE_TRACE    = {0xE8};
> -
> -/* PSL Slice Privilege 2 Memory Map */
> -/* Configuration and Control Area - CAIA 1&2 */
> -static const cxl_p2n_reg_t CXL_PSL_PID_TID_An = {0x000};
> -static const cxl_p2n_reg_t CXL_CSRP_An        = {0x008};
> -/* Configuration and Control Area - CAIA 1 */
> -static const cxl_p2n_reg_t CXL_AURP0_An       = {0x010};
> -static const cxl_p2n_reg_t CXL_AURP1_An       = {0x018};
> -static const cxl_p2n_reg_t CXL_SSTP0_An       = {0x020};
> -static const cxl_p2n_reg_t CXL_SSTP1_An       = {0x028};
> -/* Configuration and Control Area - CAIA 1 */
> -static const cxl_p2n_reg_t CXL_PSL_AMR_An     = {0x030};
> -/* Segment Lookaside Buffer Management - CAIA 1 */
> -static const cxl_p2n_reg_t CXL_SLBIE_An       = {0x040};
> -static const cxl_p2n_reg_t CXL_SLBIA_An       = {0x048};
> -static const cxl_p2n_reg_t CXL_SLBI_Select_An = {0x050};
> -/* Interrupt Registers - CAIA 1&2 */
> -static const cxl_p2n_reg_t CXL_PSL_DSISR_An   = {0x060};
> -static const cxl_p2n_reg_t CXL_PSL_DAR_An     = {0x068};
> -static const cxl_p2n_reg_t CXL_PSL_DSR_An     = {0x070};
> -static const cxl_p2n_reg_t CXL_PSL_TFC_An     = {0x078};
> -static const cxl_p2n_reg_t CXL_PSL_PEHandle_An = {0x080};
> -static const cxl_p2n_reg_t CXL_PSL_ErrStat_An = {0x088};
> -/* AFU Registers - CAIA 1&2 */
> -static const cxl_p2n_reg_t CXL_AFU_Cntl_An    = {0x090};
> -static const cxl_p2n_reg_t CXL_AFU_ERR_An     = {0x098};
> -/* Work Element Descriptor - CAIA 1&2 */
> -static const cxl_p2n_reg_t CXL_PSL_WED_An     = {0x0A0};
> -/* 0x0C0:FFF Implementation Dependent Area */
> -
> -#define CXL_PSL_SPAP_Addr 0x0ffffffffffff000ULL
> -#define CXL_PSL_SPAP_Size 0x0000000000000ff0ULL
> -#define CXL_PSL_SPAP_Size_Shift 4
> -#define CXL_PSL_SPAP_V    0x0000000000000001ULL
> -
> -/****** CXL_PSL_Control ****************************************************/
> -#define CXL_PSL_Control_tb              (0x1ull << (63-63))
> -#define CXL_PSL_Control_Fr              (0x1ull << (63-31))
> -#define CXL_PSL_Control_Fs_MASK         (0x3ull << (63-29))
> -#define CXL_PSL_Control_Fs_Complete     (0x3ull << (63-29))
> -
> -/****** CXL_PSL_DLCNTL *****************************************************/
> -#define CXL_PSL_DLCNTL_D (0x1ull << (63-28))
> -#define CXL_PSL_DLCNTL_C (0x1ull << (63-29))
> -#define CXL_PSL_DLCNTL_E (0x1ull << (63-30))
> -#define CXL_PSL_DLCNTL_S (0x1ull << (63-31))
> -#define CXL_PSL_DLCNTL_CE (CXL_PSL_DLCNTL_C | CXL_PSL_DLCNTL_E)
> -#define CXL_PSL_DLCNTL_DCES (CXL_PSL_DLCNTL_D | CXL_PSL_DLCNTL_CE | CXL_PSL_DLCNTL_S)
> -
> -/****** CXL_PSL_SR_An ******************************************************/
> -#define CXL_PSL_SR_An_SF  MSR_SF            /* 64bit */
> -#define CXL_PSL_SR_An_TA  (1ull << (63-1))  /* Tags active,   GA1: 0 */
> -#define CXL_PSL_SR_An_HV  MSR_HV            /* Hypervisor,    GA1: 0 */
> -#define CXL_PSL_SR_An_XLAT_hpt (0ull << (63-6))/* Hashed page table (HPT) mode */
> -#define CXL_PSL_SR_An_XLAT_roh (2ull << (63-6))/* Radix on HPT mode */
> -#define CXL_PSL_SR_An_XLAT_ror (3ull << (63-6))/* Radix on Radix mode */
> -#define CXL_PSL_SR_An_BOT (1ull << (63-10)) /* Use the in-memory segment table */
> -#define CXL_PSL_SR_An_PR  MSR_PR            /* Problem state, GA1: 1 */
> -#define CXL_PSL_SR_An_ISL (1ull << (63-53)) /* Ignore Segment Large Page */
> -#define CXL_PSL_SR_An_TC  (1ull << (63-54)) /* Page Table secondary hash */
> -#define CXL_PSL_SR_An_US  (1ull << (63-56)) /* User state,    GA1: X */
> -#define CXL_PSL_SR_An_SC  (1ull << (63-58)) /* Segment Table secondary hash */
> -#define CXL_PSL_SR_An_R   MSR_DR            /* Relocate,      GA1: 1 */
> -#define CXL_PSL_SR_An_MP  (1ull << (63-62)) /* Master Process */
> -#define CXL_PSL_SR_An_LE  (1ull << (63-63)) /* Little Endian */
> -
> -/****** CXL_PSL_ID_An ****************************************************/
> -#define CXL_PSL_ID_An_F	(1ull << (63-31))
> -#define CXL_PSL_ID_An_L	(1ull << (63-30))
> -
> -/****** CXL_PSL_SERR_An ****************************************************/
> -#define CXL_PSL_SERR_An_afuto	(1ull << (63-0))
> -#define CXL_PSL_SERR_An_afudis	(1ull << (63-1))
> -#define CXL_PSL_SERR_An_afuov	(1ull << (63-2))
> -#define CXL_PSL_SERR_An_badsrc	(1ull << (63-3))
> -#define CXL_PSL_SERR_An_badctx	(1ull << (63-4))
> -#define CXL_PSL_SERR_An_llcmdis	(1ull << (63-5))
> -#define CXL_PSL_SERR_An_llcmdto	(1ull << (63-6))
> -#define CXL_PSL_SERR_An_afupar	(1ull << (63-7))
> -#define CXL_PSL_SERR_An_afudup	(1ull << (63-8))
> -#define CXL_PSL_SERR_An_IRQS	( \
> -	CXL_PSL_SERR_An_afuto | CXL_PSL_SERR_An_afudis | CXL_PSL_SERR_An_afuov | \
> -	CXL_PSL_SERR_An_badsrc | CXL_PSL_SERR_An_badctx | CXL_PSL_SERR_An_llcmdis | \
> -	CXL_PSL_SERR_An_llcmdto | CXL_PSL_SERR_An_afupar | CXL_PSL_SERR_An_afudup)
> -#define CXL_PSL_SERR_An_afuto_mask	(1ull << (63-32))
> -#define CXL_PSL_SERR_An_afudis_mask	(1ull << (63-33))
> -#define CXL_PSL_SERR_An_afuov_mask	(1ull << (63-34))
> -#define CXL_PSL_SERR_An_badsrc_mask	(1ull << (63-35))
> -#define CXL_PSL_SERR_An_badctx_mask	(1ull << (63-36))
> -#define CXL_PSL_SERR_An_llcmdis_mask	(1ull << (63-37))
> -#define CXL_PSL_SERR_An_llcmdto_mask	(1ull << (63-38))
> -#define CXL_PSL_SERR_An_afupar_mask	(1ull << (63-39))
> -#define CXL_PSL_SERR_An_afudup_mask	(1ull << (63-40))
> -#define CXL_PSL_SERR_An_IRQ_MASKS	( \
> -	CXL_PSL_SERR_An_afuto_mask | CXL_PSL_SERR_An_afudis_mask | CXL_PSL_SERR_An_afuov_mask | \
> -	CXL_PSL_SERR_An_badsrc_mask | CXL_PSL_SERR_An_badctx_mask | CXL_PSL_SERR_An_llcmdis_mask | \
> -	CXL_PSL_SERR_An_llcmdto_mask | CXL_PSL_SERR_An_afupar_mask | CXL_PSL_SERR_An_afudup_mask)
> -
> -#define CXL_PSL_SERR_An_AE	(1ull << (63-30))
> -
> -/****** CXL_PSL_SCNTL_An ****************************************************/
> -#define CXL_PSL_SCNTL_An_CR          (0x1ull << (63-15))
> -/* Programming Modes: */
> -#define CXL_PSL_SCNTL_An_PM_MASK     (0xffffull << (63-31))
> -#define CXL_PSL_SCNTL_An_PM_Shared   (0x0000ull << (63-31))
> -#define CXL_PSL_SCNTL_An_PM_OS       (0x0001ull << (63-31))
> -#define CXL_PSL_SCNTL_An_PM_Process  (0x0002ull << (63-31))
> -#define CXL_PSL_SCNTL_An_PM_AFU      (0x0004ull << (63-31))
> -#define CXL_PSL_SCNTL_An_PM_AFU_PBT  (0x0104ull << (63-31))
> -/* Purge Status (ro) */
> -#define CXL_PSL_SCNTL_An_Ps_MASK     (0x3ull << (63-39))
> -#define CXL_PSL_SCNTL_An_Ps_Pending  (0x1ull << (63-39))
> -#define CXL_PSL_SCNTL_An_Ps_Complete (0x3ull << (63-39))
> -/* Purge */
> -#define CXL_PSL_SCNTL_An_Pc          (0x1ull << (63-48))
> -/* Suspend Status (ro) */
> -#define CXL_PSL_SCNTL_An_Ss_MASK     (0x3ull << (63-55))
> -#define CXL_PSL_SCNTL_An_Ss_Pending  (0x1ull << (63-55))
> -#define CXL_PSL_SCNTL_An_Ss_Complete (0x3ull << (63-55))
> -/* Suspend Control */
> -#define CXL_PSL_SCNTL_An_Sc          (0x1ull << (63-63))
> -
> -/* AFU Slice Enable Status (ro) */
> -#define CXL_AFU_Cntl_An_ES_MASK     (0x7ull << (63-2))
> -#define CXL_AFU_Cntl_An_ES_Disabled (0x0ull << (63-2))
> -#define CXL_AFU_Cntl_An_ES_Enabled  (0x4ull << (63-2))
> -/* AFU Slice Enable */
> -#define CXL_AFU_Cntl_An_E           (0x1ull << (63-3))
> -/* AFU Slice Reset status (ro) */
> -#define CXL_AFU_Cntl_An_RS_MASK     (0x3ull << (63-5))
> -#define CXL_AFU_Cntl_An_RS_Pending  (0x1ull << (63-5))
> -#define CXL_AFU_Cntl_An_RS_Complete (0x2ull << (63-5))
> -/* AFU Slice Reset */
> -#define CXL_AFU_Cntl_An_RA          (0x1ull << (63-7))
> -
> -/****** CXL_SSTP0/1_An ******************************************************/
> -/* These top bits are for the segment that CONTAINS the segment table */
> -#define CXL_SSTP0_An_B_SHIFT    SLB_VSID_SSIZE_SHIFT
> -#define CXL_SSTP0_An_KS             (1ull << (63-2))
> -#define CXL_SSTP0_An_KP             (1ull << (63-3))
> -#define CXL_SSTP0_An_N              (1ull << (63-4))
> -#define CXL_SSTP0_An_L              (1ull << (63-5))
> -#define CXL_SSTP0_An_C              (1ull << (63-6))
> -#define CXL_SSTP0_An_TA             (1ull << (63-7))
> -#define CXL_SSTP0_An_LP_SHIFT                (63-9)  /* 2 Bits */
> -/* And finally, the virtual address & size of the segment table: */
> -#define CXL_SSTP0_An_SegTableSize_SHIFT      (63-31) /* 12 Bits */
> -#define CXL_SSTP0_An_SegTableSize_MASK \
> -	(((1ull << 12) - 1) << CXL_SSTP0_An_SegTableSize_SHIFT)
> -#define CXL_SSTP0_An_STVA_U_MASK   ((1ull << (63-49))-1)
> -#define CXL_SSTP1_An_STVA_L_MASK (~((1ull << (63-55))-1))
> -#define CXL_SSTP1_An_V              (1ull << (63-63))
> -
> -/****** CXL_PSL_SLBIE_[An] - CAIA 1 **************************************************/
> -/* write: */
> -#define CXL_SLBIE_C        PPC_BIT(36)         /* Class */
> -#define CXL_SLBIE_SS       PPC_BITMASK(37, 38) /* Segment Size */
> -#define CXL_SLBIE_SS_SHIFT PPC_BITLSHIFT(38)
> -#define CXL_SLBIE_TA       PPC_BIT(38)         /* Tags Active */
> -/* read: */
> -#define CXL_SLBIE_MAX      PPC_BITMASK(24, 31)
> -#define CXL_SLBIE_PENDING  PPC_BITMASK(56, 63)
> -
> -/****** Common to all CXL_TLBIA/SLBIA_[An] - CAIA 1 **********************************/
> -#define CXL_TLB_SLB_P          (1ull) /* Pending (read) */
> -
> -/****** Common to all CXL_TLB/SLB_IA/IE_[An] registers - CAIA 1 **********************/
> -#define CXL_TLB_SLB_IQ_ALL     (0ull) /* Inv qualifier */
> -#define CXL_TLB_SLB_IQ_LPID    (1ull) /* Inv qualifier */
> -#define CXL_TLB_SLB_IQ_LPIDPID (3ull) /* Inv qualifier */
> -
> -/****** CXL_PSL_AFUSEL ******************************************************/
> -#define CXL_PSL_AFUSEL_A (1ull << (63-55)) /* Adapter wide invalidates affect all AFUs */
> -
> -/****** CXL_PSL_DSISR_An - CAIA 1 ****************************************************/
> -#define CXL_PSL_DSISR_An_DS (1ull << (63-0))  /* Segment not found */
> -#define CXL_PSL_DSISR_An_DM (1ull << (63-1))  /* PTE not found (See also: M) or protection fault */
> -#define CXL_PSL_DSISR_An_ST (1ull << (63-2))  /* Segment Table PTE not found */
> -#define CXL_PSL_DSISR_An_UR (1ull << (63-3))  /* AURP PTE not found */
> -#define CXL_PSL_DSISR_TRANS (CXL_PSL_DSISR_An_DS | CXL_PSL_DSISR_An_DM | CXL_PSL_DSISR_An_ST | CXL_PSL_DSISR_An_UR)
> -#define CXL_PSL_DSISR_An_PE (1ull << (63-4))  /* PSL Error (implementation specific) */
> -#define CXL_PSL_DSISR_An_AE (1ull << (63-5))  /* AFU Error */
> -#define CXL_PSL_DSISR_An_OC (1ull << (63-6))  /* OS Context Warning */
> -#define CXL_PSL_DSISR_PENDING (CXL_PSL_DSISR_TRANS | CXL_PSL_DSISR_An_PE | CXL_PSL_DSISR_An_AE | CXL_PSL_DSISR_An_OC)
> -/* NOTE: Bits 32:63 are undefined if DSISR[DS] = 1 */
> -#define CXL_PSL_DSISR_An_M  DSISR_NOHPTE      /* PTE not found */
> -#define CXL_PSL_DSISR_An_P  DSISR_PROTFAULT   /* Storage protection violation */
> -#define CXL_PSL_DSISR_An_A  (1ull << (63-37)) /* AFU lock access to write through or cache inhibited storage */
> -#define CXL_PSL_DSISR_An_S  DSISR_ISSTORE     /* Access was afu_wr or afu_zero */
> -#define CXL_PSL_DSISR_An_K  DSISR_KEYFAULT    /* Access not permitted by virtual page class key protection */
> -
> -/****** CXL_PSL_DSISR_An - CAIA 2 ****************************************************/
> -#define CXL_PSL9_DSISR_An_TF (1ull << (63-3))  /* Translation fault */
> -#define CXL_PSL9_DSISR_An_PE (1ull << (63-4))  /* PSL Error (implementation specific) */
> -#define CXL_PSL9_DSISR_An_AE (1ull << (63-5))  /* AFU Error */
> -#define CXL_PSL9_DSISR_An_OC (1ull << (63-6))  /* OS Context Warning */
> -#define CXL_PSL9_DSISR_An_S (1ull << (63-38))  /* TF for a write operation */
> -#define CXL_PSL9_DSISR_PENDING (CXL_PSL9_DSISR_An_TF | CXL_PSL9_DSISR_An_PE | CXL_PSL9_DSISR_An_AE | CXL_PSL9_DSISR_An_OC)
> -/*
> - * NOTE: Bits 56:63 (Checkout Response Status) are valid when DSISR_An[TF] = 1
> - * Status (0:7) Encoding
> - */
> -#define CXL_PSL9_DSISR_An_CO_MASK 0x00000000000000ffULL
> -#define CXL_PSL9_DSISR_An_SF      0x0000000000000080ULL  /* Segment Fault                        0b10000000 */
> -#define CXL_PSL9_DSISR_An_PF_SLR  0x0000000000000088ULL  /* PTE not found (Single Level Radix)   0b10001000 */
> -#define CXL_PSL9_DSISR_An_PF_RGC  0x000000000000008CULL  /* PTE not found (Radix Guest (child))  0b10001100 */
> -#define CXL_PSL9_DSISR_An_PF_RGP  0x0000000000000090ULL  /* PTE not found (Radix Guest (parent)) 0b10010000 */
> -#define CXL_PSL9_DSISR_An_PF_HRH  0x0000000000000094ULL  /* PTE not found (HPT/Radix Host)       0b10010100 */
> -#define CXL_PSL9_DSISR_An_PF_STEG 0x000000000000009CULL  /* PTE not found (STEG VA)              0b10011100 */
> -#define CXL_PSL9_DSISR_An_URTCH   0x00000000000000B4ULL  /* Unsupported Radix Tree Configuration 0b10110100 */
> -
> -/****** CXL_PSL_TFC_An ******************************************************/
> -#define CXL_PSL_TFC_An_A  (1ull << (63-28)) /* Acknowledge non-translation fault */
> -#define CXL_PSL_TFC_An_C  (1ull << (63-29)) /* Continue (abort transaction) */
> -#define CXL_PSL_TFC_An_AE (1ull << (63-30)) /* Restart PSL with address error */
> -#define CXL_PSL_TFC_An_R  (1ull << (63-31)) /* Restart PSL transaction */
> -
> -/****** CXL_PSL_DEBUG *****************************************************/
> -#define CXL_PSL_DEBUG_CDC  (1ull << (63-27)) /* Coherent Data cache support */
> -
> -/****** CXL_XSL9_IERAT_ERAT - CAIA 2 **********************************/
> -#define CXL_XSL9_IERAT_MLPID    (1ull << (63-0))  /* Match LPID */
> -#define CXL_XSL9_IERAT_MPID     (1ull << (63-1))  /* Match PID */
> -#define CXL_XSL9_IERAT_PRS      (1ull << (63-4))  /* PRS bit for Radix invalidations */
> -#define CXL_XSL9_IERAT_INVR     (1ull << (63-3))  /* Invalidate Radix */
> -#define CXL_XSL9_IERAT_IALL     (1ull << (63-8))  /* Invalidate All */
> -#define CXL_XSL9_IERAT_IINPROG  (1ull << (63-63)) /* Invalidate in progress */
> -
> -/* cxl_process_element->software_status */
> -#define CXL_PE_SOFTWARE_STATE_V (1ul << (31 -  0)) /* Valid */
> -#define CXL_PE_SOFTWARE_STATE_C (1ul << (31 - 29)) /* Complete */
> -#define CXL_PE_SOFTWARE_STATE_S (1ul << (31 - 30)) /* Suspend */
> -#define CXL_PE_SOFTWARE_STATE_T (1ul << (31 - 31)) /* Terminate */
> -
> -/****** CXL_PSL_RXCTL_An (Implementation Specific) **************************
> - * Controls AFU Hang Pulse, which sets the timeout for the AFU to respond to
> - * the PSL for any response (except MMIO). Timeouts will occur between 1x to 2x
> - * of the hang pulse frequency.
> - */
> -#define CXL_PSL_RXCTL_AFUHP_4S      0x7000000000000000ULL
> -
> -/* SPA->sw_command_status */
> -#define CXL_SPA_SW_CMD_MASK         0xffff000000000000ULL
> -#define CXL_SPA_SW_CMD_TERMINATE    0x0001000000000000ULL
> -#define CXL_SPA_SW_CMD_REMOVE       0x0002000000000000ULL
> -#define CXL_SPA_SW_CMD_SUSPEND      0x0003000000000000ULL
> -#define CXL_SPA_SW_CMD_RESUME       0x0004000000000000ULL
> -#define CXL_SPA_SW_CMD_ADD          0x0005000000000000ULL
> -#define CXL_SPA_SW_CMD_UPDATE       0x0006000000000000ULL
> -#define CXL_SPA_SW_STATE_MASK       0x0000ffff00000000ULL
> -#define CXL_SPA_SW_STATE_TERMINATED 0x0000000100000000ULL
> -#define CXL_SPA_SW_STATE_REMOVED    0x0000000200000000ULL
> -#define CXL_SPA_SW_STATE_SUSPENDED  0x0000000300000000ULL
> -#define CXL_SPA_SW_STATE_RESUMED    0x0000000400000000ULL
> -#define CXL_SPA_SW_STATE_ADDED      0x0000000500000000ULL
> -#define CXL_SPA_SW_STATE_UPDATED    0x0000000600000000ULL
> -#define CXL_SPA_SW_PSL_ID_MASK      0x00000000ffff0000ULL
> -#define CXL_SPA_SW_LINK_MASK        0x000000000000ffffULL
> -
> -#define CXL_MAX_SLICES 4
> -#define MAX_AFU_MMIO_REGS 3
> -
> -#define CXL_MODE_TIME_SLICED 0x4
> -#define CXL_SUPPORTED_MODES (CXL_MODE_DEDICATED | CXL_MODE_DIRECTED)
> -
> -#define CXL_DEV_MINORS 13   /* 1 control + 4 AFUs * 3 (dedicated/master/shared) */
> -#define CXL_CARD_MINOR(adapter) (adapter->adapter_num * CXL_DEV_MINORS)
> -#define CXL_DEVT_ADAPTER(dev) (MINOR(dev) / CXL_DEV_MINORS)
> -
> -#define CXL_PSL9_TRACEID_MAX 0xAU
> -#define CXL_PSL9_TRACESTATE_FIN 0x3U
> -
> -enum cxl_context_status {
> -	CLOSED,
> -	OPENED,
> -	STARTED
> -};
> -
> -enum prefault_modes {
> -	CXL_PREFAULT_NONE,
> -	CXL_PREFAULT_WED,
> -	CXL_PREFAULT_ALL,
> -};
> -
> -enum cxl_attrs {
> -	CXL_ADAPTER_ATTRS,
> -	CXL_AFU_MASTER_ATTRS,
> -	CXL_AFU_ATTRS,
> -};
> -
> -struct cxl_sste {
> -	__be64 esid_data;
> -	__be64 vsid_data;
> -};
> -
> -#define to_cxl_adapter(d) container_of(d, struct cxl, dev)
> -#define to_cxl_afu(d) container_of(d, struct cxl_afu, dev)
> -
> -struct cxl_afu_native {
> -	void __iomem *p1n_mmio;
> -	void __iomem *afu_desc_mmio;
> -	irq_hw_number_t psl_hwirq;
> -	unsigned int psl_virq;
> -	struct mutex spa_mutex;
> -	/*
> -	 * Only the first part of the SPA is used for the process element
> -	 * linked list. The only other part that software needs to worry about
> -	 * is sw_command_status, which we store a separate pointer to.
> -	 * Everything else in the SPA is only used by hardware
> -	 */
> -	struct cxl_process_element *spa;
> -	__be64 *sw_command_status;
> -	unsigned int spa_size;
> -	int spa_order;
> -	int spa_max_procs;
> -	u64 pp_offset;
> -};
> -
> -struct cxl_afu_guest {
> -	struct cxl_afu *parent;
> -	u64 handle;
> -	phys_addr_t p2n_phys;
> -	u64 p2n_size;
> -	int max_ints;
> -	bool handle_err;
> -	struct delayed_work work_err;
> -	int previous_state;
> -};
> -
> -struct cxl_afu {
> -	struct cxl_afu_native *native;
> -	struct cxl_afu_guest *guest;
> -	irq_hw_number_t serr_hwirq;
> -	unsigned int serr_virq;
> -	char *psl_irq_name;
> -	char *err_irq_name;
> -	void __iomem *p2n_mmio;
> -	phys_addr_t psn_phys;
> -	u64 pp_size;
> -
> -	struct cxl *adapter;
> -	struct device dev;
> -	struct cdev afu_cdev_s, afu_cdev_m, afu_cdev_d;
> -	struct device *chardev_s, *chardev_m, *chardev_d;
> -	struct idr contexts_idr;
> -	struct dentry *debugfs;
> -	struct mutex contexts_lock;
> -	spinlock_t afu_cntl_lock;
> -
> -	/* -1: AFU deconfigured/locked, >= 0: number of readers */
> -	atomic_t configured_state;
> -
> -	/* AFU error buffer fields and bin attribute for sysfs */
> -	u64 eb_len, eb_offset;
> -	struct bin_attribute attr_eb;
> -
> -	/* pointer to the vphb */
> -	struct pci_controller *phb;
> -
> -	int pp_irqs;
> -	int irqs_max;
> -	int num_procs;
> -	int max_procs_virtualised;
> -	int slice;
> -	int modes_supported;
> -	int current_mode;
> -	int crs_num;
> -	u64 crs_len;
> -	u64 crs_offset;
> -	struct list_head crs;
> -	enum prefault_modes prefault_mode;
> -	bool psa;
> -	bool pp_psa;
> -	bool enabled;
> -};
> -
> -
> -struct cxl_irq_name {
> -	struct list_head list;
> -	char *name;
> -};
> -
> -struct irq_avail {
> -	irq_hw_number_t offset;
> -	irq_hw_number_t range;
> -	unsigned long   *bitmap;
> -};
> -
> -/*
> - * This is a cxl context.  If the PSL is in dedicated mode, there will be one
> - * of these per AFU.  If in AFU directed there can be lots of these.
> - */
> -struct cxl_context {
> -	struct cxl_afu *afu;
> -
> -	/* Problem state MMIO */
> -	phys_addr_t psn_phys;
> -	u64 psn_size;
> -
> -	/* Used to unmap any mmaps when force detaching */
> -	struct address_space *mapping;
> -	struct mutex mapping_lock;
> -	struct page *ff_page;
> -	bool mmio_err_ff;
> -	bool kernelapi;
> -
> -	spinlock_t sste_lock; /* Protects segment table entries */
> -	struct cxl_sste *sstp;
> -	u64 sstp0, sstp1;
> -	unsigned int sst_size, sst_lru;
> -
> -	wait_queue_head_t wq;
> -	/* use mm context associated with this pid for ds faults */
> -	struct pid *pid;
> -	spinlock_t lock; /* Protects pending_irq_mask, pending_fault and fault_addr */
> -	/* Only used in PR mode */
> -	u64 process_token;
> -
> -	/* driver private data */
> -	void *priv;
> -
> -	unsigned long *irq_bitmap; /* Accessed from IRQ context */
> -	struct cxl_irq_ranges irqs;
> -	struct list_head irq_names;
> -	u64 fault_addr;
> -	u64 fault_dsisr;
> -	u64 afu_err;
> -
> -	/*
> -	 * This status and it's lock pretects start and detach context
> -	 * from racing.  It also prevents detach from racing with
> -	 * itself
> -	 */
> -	enum cxl_context_status status;
> -	struct mutex status_mutex;
> -
> -
> -	/* XXX: Is it possible to need multiple work items at once? */
> -	struct work_struct fault_work;
> -	u64 dsisr;
> -	u64 dar;
> -
> -	struct cxl_process_element *elem;
> -
> -	/*
> -	 * pe is the process element handle, assigned by this driver when the
> -	 * context is initialized.
> -	 *
> -	 * external_pe is the PE shown outside of cxl.
> -	 * On bare-metal, pe=external_pe, because we decide what the handle is.
> -	 * In a guest, we only find out about the pe used by pHyp when the
> -	 * context is attached, and that's the value we want to report outside
> -	 * of cxl.
> -	 */
> -	int pe;
> -	int external_pe;
> -
> -	u32 irq_count;
> -	bool pe_inserted;
> -	bool master;
> -	bool kernel;
> -	bool pending_irq;
> -	bool pending_fault;
> -	bool pending_afu_err;
> -
> -	/* Used by AFU drivers for driver specific event delivery */
> -	struct cxl_afu_driver_ops *afu_driver_ops;
> -	atomic_t afu_driver_events;
> -
> -	struct rcu_head rcu;
> -
> -	struct mm_struct *mm;
> -
> -	u16 tidr;
> -	bool assign_tidr;
> -};
> -
> -struct cxl_irq_info;
> -
> -struct cxl_service_layer_ops {
> -	int (*adapter_regs_init)(struct cxl *adapter, struct pci_dev *dev);
> -	int (*invalidate_all)(struct cxl *adapter);
> -	int (*afu_regs_init)(struct cxl_afu *afu);
> -	int (*sanitise_afu_regs)(struct cxl_afu *afu);
> -	int (*register_serr_irq)(struct cxl_afu *afu);
> -	void (*release_serr_irq)(struct cxl_afu *afu);
> -	irqreturn_t (*handle_interrupt)(int irq, struct cxl_context *ctx, struct cxl_irq_info *irq_info);
> -	irqreturn_t (*fail_irq)(struct cxl_afu *afu, struct cxl_irq_info *irq_info);
> -	int (*activate_dedicated_process)(struct cxl_afu *afu);
> -	int (*attach_afu_directed)(struct cxl_context *ctx, u64 wed, u64 amr);
> -	int (*attach_dedicated_process)(struct cxl_context *ctx, u64 wed, u64 amr);
> -	void (*update_dedicated_ivtes)(struct cxl_context *ctx);
> -	void (*debugfs_add_adapter_regs)(struct cxl *adapter, struct dentry *dir);
> -	void (*debugfs_add_afu_regs)(struct cxl_afu *afu, struct dentry *dir);
> -	void (*psl_irq_dump_registers)(struct cxl_context *ctx);
> -	void (*err_irq_dump_registers)(struct cxl *adapter);
> -	void (*debugfs_stop_trace)(struct cxl *adapter);
> -	void (*write_timebase_ctrl)(struct cxl *adapter);
> -	u64 (*timebase_read)(struct cxl *adapter);
> -	int capi_mode;
> -	bool needs_reset_before_disable;
> -};
> -
> -struct cxl_native {
> -	u64 afu_desc_off;
> -	u64 afu_desc_size;
> -	void __iomem *p1_mmio;
> -	void __iomem *p2_mmio;
> -	irq_hw_number_t err_hwirq;
> -	unsigned int err_virq;
> -	u64 ps_off;
> -	bool no_data_cache; /* set if no data cache on the card */
> -	const struct cxl_service_layer_ops *sl_ops;
> -};
> -
> -struct cxl_guest {
> -	struct platform_device *pdev;
> -	int irq_nranges;
> -	struct cdev cdev;
> -	irq_hw_number_t irq_base_offset;
> -	struct irq_avail *irq_avail;
> -	spinlock_t irq_alloc_lock;
> -	u64 handle;
> -	char *status;
> -	u16 vendor;
> -	u16 device;
> -	u16 subsystem_vendor;
> -	u16 subsystem;
> -};
> -
> -struct cxl {
> -	struct cxl_native *native;
> -	struct cxl_guest *guest;
> -	spinlock_t afu_list_lock;
> -	struct cxl_afu *afu[CXL_MAX_SLICES];
> -	struct device dev;
> -	struct dentry *trace;
> -	struct dentry *psl_err_chk;
> -	struct dentry *debugfs;
> -	char *irq_name;
> -	struct bin_attribute cxl_attr;
> -	int adapter_num;
> -	int user_irqs;
> -	u64 ps_size;
> -	u16 psl_rev;
> -	u16 base_image;
> -	u8 vsec_status;
> -	u8 caia_major;
> -	u8 caia_minor;
> -	u8 slices;
> -	bool user_image_loaded;
> -	bool perst_loads_image;
> -	bool perst_select_user;
> -	bool perst_same_image;
> -	bool psl_timebase_synced;
> -	bool tunneled_ops_supported;
> -
> -	/*
> -	 * number of contexts mapped on to this card. Possible values are:
> -	 * >0: Number of contexts mapped and new one can be mapped.
> -	 *  0: No active contexts and new ones can be mapped.
> -	 * -1: No contexts mapped and new ones cannot be mapped.
> -	 */
> -	atomic_t contexts_num;
> -};
> -
> -int cxl_pci_alloc_one_irq(struct cxl *adapter);
> -void cxl_pci_release_one_irq(struct cxl *adapter, int hwirq);
> -int cxl_pci_alloc_irq_ranges(struct cxl_irq_ranges *irqs, struct cxl *adapter, unsigned int num);
> -void cxl_pci_release_irq_ranges(struct cxl_irq_ranges *irqs, struct cxl *adapter);
> -int cxl_pci_setup_irq(struct cxl *adapter, unsigned int hwirq, unsigned int virq);
> -int cxl_update_image_control(struct cxl *adapter);
> -int cxl_pci_reset(struct cxl *adapter);
> -void cxl_pci_release_afu(struct device *dev);
> -ssize_t cxl_pci_read_adapter_vpd(struct cxl *adapter, void *buf, size_t len);
> -
> -/* common == phyp + powernv - CAIA 1&2 */
> -struct cxl_process_element_common {
> -	__be32 tid;
> -	__be32 pid;
> -	__be64 csrp;
> -	union {
> -		struct {
> -			__be64 aurp0;
> -			__be64 aurp1;
> -			__be64 sstp0;
> -			__be64 sstp1;
> -		} psl8;  /* CAIA 1 */
> -		struct {
> -			u8     reserved2[8];
> -			u8     reserved3[8];
> -			u8     reserved4[8];
> -			u8     reserved5[8];
> -		} psl9;  /* CAIA 2 */
> -	} u;
> -	__be64 amr;
> -	u8     reserved6[4];
> -	__be64 wed;
> -} __packed;
> -
> -/* just powernv - CAIA 1&2 */
> -struct cxl_process_element {
> -	__be64 sr;
> -	__be64 SPOffset;
> -	union {
> -		__be64 sdr;          /* CAIA 1 */
> -		u8     reserved1[8]; /* CAIA 2 */
> -	} u;
> -	__be64 haurp;
> -	__be32 ctxtime;
> -	__be16 ivte_offsets[4];
> -	__be16 ivte_ranges[4];
> -	__be32 lpid;
> -	struct cxl_process_element_common common;
> -	__be32 software_state;
> -} __packed;
> -
> -static inline bool cxl_adapter_link_ok(struct cxl *cxl, struct cxl_afu *afu)
> -{
> -	struct pci_dev *pdev;
> -
> -	if (cpu_has_feature(CPU_FTR_HVMODE)) {
> -		pdev = to_pci_dev(cxl->dev.parent);
> -		return !pci_channel_offline(pdev);
> -	}
> -	return true;
> -}
> -
> -static inline void __iomem *_cxl_p1_addr(struct cxl *cxl, cxl_p1_reg_t reg)
> -{
> -	WARN_ON(!cpu_has_feature(CPU_FTR_HVMODE));
> -	return cxl->native->p1_mmio + cxl_reg_off(reg);
> -}
> -
> -static inline void cxl_p1_write(struct cxl *cxl, cxl_p1_reg_t reg, u64 val)
> -{
> -	if (likely(cxl_adapter_link_ok(cxl, NULL)))
> -		out_be64(_cxl_p1_addr(cxl, reg), val);
> -}
> -
> -static inline u64 cxl_p1_read(struct cxl *cxl, cxl_p1_reg_t reg)
> -{
> -	if (likely(cxl_adapter_link_ok(cxl, NULL)))
> -		return in_be64(_cxl_p1_addr(cxl, reg));
> -	else
> -		return ~0ULL;
> -}
> -
> -static inline void __iomem *_cxl_p1n_addr(struct cxl_afu *afu, cxl_p1n_reg_t reg)
> -{
> -	WARN_ON(!cpu_has_feature(CPU_FTR_HVMODE));
> -	return afu->native->p1n_mmio + cxl_reg_off(reg);
> -}
> -
> -static inline void cxl_p1n_write(struct cxl_afu *afu, cxl_p1n_reg_t reg, u64 val)
> -{
> -	if (likely(cxl_adapter_link_ok(afu->adapter, afu)))
> -		out_be64(_cxl_p1n_addr(afu, reg), val);
> -}
> -
> -static inline u64 cxl_p1n_read(struct cxl_afu *afu, cxl_p1n_reg_t reg)
> -{
> -	if (likely(cxl_adapter_link_ok(afu->adapter, afu)))
> -		return in_be64(_cxl_p1n_addr(afu, reg));
> -	else
> -		return ~0ULL;
> -}
> -
> -static inline void __iomem *_cxl_p2n_addr(struct cxl_afu *afu, cxl_p2n_reg_t reg)
> -{
> -	return afu->p2n_mmio + cxl_reg_off(reg);
> -}
> -
> -static inline void cxl_p2n_write(struct cxl_afu *afu, cxl_p2n_reg_t reg, u64 val)
> -{
> -	if (likely(cxl_adapter_link_ok(afu->adapter, afu)))
> -		out_be64(_cxl_p2n_addr(afu, reg), val);
> -}
> -
> -static inline u64 cxl_p2n_read(struct cxl_afu *afu, cxl_p2n_reg_t reg)
> -{
> -	if (likely(cxl_adapter_link_ok(afu->adapter, afu)))
> -		return in_be64(_cxl_p2n_addr(afu, reg));
> -	else
> -		return ~0ULL;
> -}
> -
> -static inline bool cxl_is_power8(void)
> -{
> -	if ((pvr_version_is(PVR_POWER8E)) ||
> -	    (pvr_version_is(PVR_POWER8NVL)) ||
> -	    (pvr_version_is(PVR_POWER8)) ||
> -	    (pvr_version_is(PVR_HX_C2000)))
> -		return true;
> -	return false;
> -}
> -
> -static inline bool cxl_is_power9(void)
> -{
> -	if (pvr_version_is(PVR_POWER9))
> -		return true;
> -	return false;
> -}
> -
> -ssize_t cxl_pci_afu_read_err_buffer(struct cxl_afu *afu, char *buf,
> -				loff_t off, size_t count);
> -
> -
> -struct cxl_calls {
> -	void (*cxl_slbia)(struct mm_struct *mm);
> -	struct module *owner;
> -};
> -int register_cxl_calls(struct cxl_calls *calls);
> -void unregister_cxl_calls(struct cxl_calls *calls);
> -int cxl_update_properties(struct device_node *dn, struct property *new_prop);
> -
> -void cxl_remove_adapter_nr(struct cxl *adapter);
> -
> -void cxl_release_spa(struct cxl_afu *afu);
> -
> -dev_t cxl_get_dev(void);
> -int cxl_file_init(void);
> -void cxl_file_exit(void);
> -int cxl_register_adapter(struct cxl *adapter);
> -int cxl_register_afu(struct cxl_afu *afu);
> -int cxl_chardev_d_afu_add(struct cxl_afu *afu);
> -int cxl_chardev_m_afu_add(struct cxl_afu *afu);
> -int cxl_chardev_s_afu_add(struct cxl_afu *afu);
> -void cxl_chardev_afu_remove(struct cxl_afu *afu);
> -
> -void cxl_context_detach_all(struct cxl_afu *afu);
> -void cxl_context_free(struct cxl_context *ctx);
> -void cxl_context_detach(struct cxl_context *ctx);
> -
> -int cxl_sysfs_adapter_add(struct cxl *adapter);
> -void cxl_sysfs_adapter_remove(struct cxl *adapter);
> -int cxl_sysfs_afu_add(struct cxl_afu *afu);
> -void cxl_sysfs_afu_remove(struct cxl_afu *afu);
> -int cxl_sysfs_afu_m_add(struct cxl_afu *afu);
> -void cxl_sysfs_afu_m_remove(struct cxl_afu *afu);
> -
> -struct cxl *cxl_alloc_adapter(void);
> -struct cxl_afu *cxl_alloc_afu(struct cxl *adapter, int slice);
> -int cxl_afu_select_best_mode(struct cxl_afu *afu);
> -
> -int cxl_native_register_psl_irq(struct cxl_afu *afu);
> -void cxl_native_release_psl_irq(struct cxl_afu *afu);
> -int cxl_native_register_psl_err_irq(struct cxl *adapter);
> -void cxl_native_release_psl_err_irq(struct cxl *adapter);
> -int cxl_native_register_serr_irq(struct cxl_afu *afu);
> -void cxl_native_release_serr_irq(struct cxl_afu *afu);
> -int afu_register_irqs(struct cxl_context *ctx, u32 count);
> -void afu_release_irqs(struct cxl_context *ctx, void *cookie);
> -void afu_irq_name_free(struct cxl_context *ctx);
> -
> -int cxl_attach_afu_directed_psl9(struct cxl_context *ctx, u64 wed, u64 amr);
> -int cxl_attach_afu_directed_psl8(struct cxl_context *ctx, u64 wed, u64 amr);
> -int cxl_activate_dedicated_process_psl9(struct cxl_afu *afu);
> -int cxl_activate_dedicated_process_psl8(struct cxl_afu *afu);
> -int cxl_attach_dedicated_process_psl9(struct cxl_context *ctx, u64 wed, u64 amr);
> -int cxl_attach_dedicated_process_psl8(struct cxl_context *ctx, u64 wed, u64 amr);
> -void cxl_update_dedicated_ivtes_psl9(struct cxl_context *ctx);
> -void cxl_update_dedicated_ivtes_psl8(struct cxl_context *ctx);
> -
> -#ifdef CONFIG_DEBUG_FS
> -
> -void cxl_debugfs_init(void);
> -void cxl_debugfs_exit(void);
> -void cxl_debugfs_adapter_add(struct cxl *adapter);
> -void cxl_debugfs_adapter_remove(struct cxl *adapter);
> -void cxl_debugfs_afu_add(struct cxl_afu *afu);
> -void cxl_debugfs_afu_remove(struct cxl_afu *afu);
> -void cxl_debugfs_add_adapter_regs_psl9(struct cxl *adapter, struct dentry *dir);
> -void cxl_debugfs_add_adapter_regs_psl8(struct cxl *adapter, struct dentry *dir);
> -void cxl_debugfs_add_afu_regs_psl9(struct cxl_afu *afu, struct dentry *dir);
> -void cxl_debugfs_add_afu_regs_psl8(struct cxl_afu *afu, struct dentry *dir);
> -
> -#else /* CONFIG_DEBUG_FS */
> -
> -static inline void __init cxl_debugfs_init(void)
> -{
> -}
> -
> -static inline void cxl_debugfs_exit(void)
> -{
> -}
> -
> -static inline void cxl_debugfs_adapter_add(struct cxl *adapter)
> -{
> -}
> -
> -static inline void cxl_debugfs_adapter_remove(struct cxl *adapter)
> -{
> -}
> -
> -static inline void cxl_debugfs_afu_add(struct cxl_afu *afu)
> -{
> -}
> -
> -static inline void cxl_debugfs_afu_remove(struct cxl_afu *afu)
> -{
> -}
> -
> -static inline void cxl_debugfs_add_adapter_regs_psl9(struct cxl *adapter,
> -						    struct dentry *dir)
> -{
> -}
> -
> -static inline void cxl_debugfs_add_adapter_regs_psl8(struct cxl *adapter,
> -						    struct dentry *dir)
> -{
> -}
> -
> -static inline void cxl_debugfs_add_afu_regs_psl9(struct cxl_afu *afu, struct dentry *dir)
> -{
> -}
> -
> -static inline void cxl_debugfs_add_afu_regs_psl8(struct cxl_afu *afu, struct dentry *dir)
> -{
> -}
> -
> -#endif /* CONFIG_DEBUG_FS */
> -
> -void cxl_handle_fault(struct work_struct *work);
> -void cxl_prefault(struct cxl_context *ctx, u64 wed);
> -int cxl_handle_mm_fault(struct mm_struct *mm, u64 dsisr, u64 dar);
> -
> -struct cxl *get_cxl_adapter(int num);
> -int cxl_alloc_sst(struct cxl_context *ctx);
> -void cxl_dump_debug_buffer(void *addr, size_t size);
> -
> -void init_cxl_native(void);
> -
> -struct cxl_context *cxl_context_alloc(void);
> -int cxl_context_init(struct cxl_context *ctx, struct cxl_afu *afu, bool master);
> -void cxl_context_set_mapping(struct cxl_context *ctx,
> -			struct address_space *mapping);
> -void cxl_context_free(struct cxl_context *ctx);
> -int cxl_context_iomap(struct cxl_context *ctx, struct vm_area_struct *vma);
> -unsigned int cxl_map_irq(struct cxl *adapter, irq_hw_number_t hwirq,
> -			 irq_handler_t handler, void *cookie, const char *name);
> -void cxl_unmap_irq(unsigned int virq, void *cookie);
> -int __detach_context(struct cxl_context *ctx);
> -
> -/*
> - * This must match the layout of the H_COLLECT_CA_INT_INFO retbuf defined
> - * in PAPR.
> - * Field pid_tid is now 'reserved' because it's no more used on bare-metal.
> - * On a guest environment, PSL_PID_An is located on the upper 32 bits and
> - * PSL_TID_An register in the lower 32 bits.
> - */
> -struct cxl_irq_info {
> -	u64 dsisr;
> -	u64 dar;
> -	u64 dsr;
> -	u64 reserved;
> -	u64 afu_err;
> -	u64 errstat;
> -	u64 proc_handle;
> -	u64 padding[2]; /* to match the expected retbuf size for plpar_hcall9 */
> -};
> -
> -void cxl_assign_psn_space(struct cxl_context *ctx);
> -int cxl_invalidate_all_psl9(struct cxl *adapter);
> -int cxl_invalidate_all_psl8(struct cxl *adapter);
> -irqreturn_t cxl_irq_psl9(int irq, struct cxl_context *ctx, struct cxl_irq_info *irq_info);
> -irqreturn_t cxl_irq_psl8(int irq, struct cxl_context *ctx, struct cxl_irq_info *irq_info);
> -irqreturn_t cxl_fail_irq_psl(struct cxl_afu *afu, struct cxl_irq_info *irq_info);
> -int cxl_register_one_irq(struct cxl *adapter, irq_handler_t handler,
> -			void *cookie, irq_hw_number_t *dest_hwirq,
> -			unsigned int *dest_virq, const char *name);
> -
> -int cxl_check_error(struct cxl_afu *afu);
> -int cxl_afu_slbia(struct cxl_afu *afu);
> -int cxl_data_cache_flush(struct cxl *adapter);
> -int cxl_afu_disable(struct cxl_afu *afu);
> -int cxl_psl_purge(struct cxl_afu *afu);
> -int cxl_calc_capp_routing(struct pci_dev *dev, u64 *chipid,
> -			  u32 *phb_index, u64 *capp_unit_id);
> -int cxl_slot_is_switched(struct pci_dev *dev);
> -int cxl_get_xsl9_dsnctl(struct pci_dev *dev, u64 capp_unit_id, u64 *reg);
> -u64 cxl_calculate_sr(bool master, bool kernel, bool real_mode, bool p9);
> -
> -void cxl_native_irq_dump_regs_psl9(struct cxl_context *ctx);
> -void cxl_native_irq_dump_regs_psl8(struct cxl_context *ctx);
> -void cxl_native_err_irq_dump_regs_psl8(struct cxl *adapter);
> -void cxl_native_err_irq_dump_regs_psl9(struct cxl *adapter);
> -int cxl_pci_vphb_add(struct cxl_afu *afu);
> -void cxl_pci_vphb_remove(struct cxl_afu *afu);
> -void cxl_release_mapping(struct cxl_context *ctx);
> -
> -extern struct pci_driver cxl_pci_driver;
> -extern struct platform_driver cxl_of_driver;
> -int afu_allocate_irqs(struct cxl_context *ctx, u32 count);
> -
> -int afu_open(struct inode *inode, struct file *file);
> -int afu_release(struct inode *inode, struct file *file);
> -long afu_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
> -int afu_mmap(struct file *file, struct vm_area_struct *vm);
> -__poll_t afu_poll(struct file *file, struct poll_table_struct *poll);
> -ssize_t afu_read(struct file *file, char __user *buf, size_t count, loff_t *off);
> -extern const struct file_operations afu_fops;
> -
> -struct cxl *cxl_guest_init_adapter(struct device_node *np, struct platform_device *dev);
> -void cxl_guest_remove_adapter(struct cxl *adapter);
> -int cxl_of_read_adapter_handle(struct cxl *adapter, struct device_node *np);
> -int cxl_of_read_adapter_properties(struct cxl *adapter, struct device_node *np);
> -ssize_t cxl_guest_read_adapter_vpd(struct cxl *adapter, void *buf, size_t len);
> -ssize_t cxl_guest_read_afu_vpd(struct cxl_afu *afu, void *buf, size_t len);
> -int cxl_guest_init_afu(struct cxl *adapter, int slice, struct device_node *afu_np);
> -void cxl_guest_remove_afu(struct cxl_afu *afu);
> -int cxl_of_read_afu_handle(struct cxl_afu *afu, struct device_node *afu_np);
> -int cxl_of_read_afu_properties(struct cxl_afu *afu, struct device_node *afu_np);
> -int cxl_guest_add_chardev(struct cxl *adapter);
> -void cxl_guest_remove_chardev(struct cxl *adapter);
> -void cxl_guest_reload_module(struct cxl *adapter);
> -int cxl_of_probe(struct platform_device *pdev);
> -
> -struct cxl_backend_ops {
> -	struct module *module;
> -	int (*adapter_reset)(struct cxl *adapter);
> -	int (*alloc_one_irq)(struct cxl *adapter);
> -	void (*release_one_irq)(struct cxl *adapter, int hwirq);
> -	int (*alloc_irq_ranges)(struct cxl_irq_ranges *irqs,
> -				struct cxl *adapter, unsigned int num);
> -	void (*release_irq_ranges)(struct cxl_irq_ranges *irqs,
> -				struct cxl *adapter);
> -	int (*setup_irq)(struct cxl *adapter, unsigned int hwirq,
> -			unsigned int virq);
> -	irqreturn_t (*handle_psl_slice_error)(struct cxl_context *ctx,
> -					u64 dsisr, u64 errstat);
> -	irqreturn_t (*psl_interrupt)(int irq, void *data);
> -	int (*ack_irq)(struct cxl_context *ctx, u64 tfc, u64 psl_reset_mask);
> -	void (*irq_wait)(struct cxl_context *ctx);
> -	int (*attach_process)(struct cxl_context *ctx, bool kernel,
> -			u64 wed, u64 amr);
> -	int (*detach_process)(struct cxl_context *ctx);
> -	void (*update_ivtes)(struct cxl_context *ctx);
> -	bool (*support_attributes)(const char *attr_name, enum cxl_attrs type);
> -	bool (*link_ok)(struct cxl *cxl, struct cxl_afu *afu);
> -	void (*release_afu)(struct device *dev);
> -	ssize_t (*afu_read_err_buffer)(struct cxl_afu *afu, char *buf,
> -				loff_t off, size_t count);
> -	int (*afu_check_and_enable)(struct cxl_afu *afu);
> -	int (*afu_activate_mode)(struct cxl_afu *afu, int mode);
> -	int (*afu_deactivate_mode)(struct cxl_afu *afu, int mode);
> -	int (*afu_reset)(struct cxl_afu *afu);
> -	int (*afu_cr_read8)(struct cxl_afu *afu, int cr_idx, u64 offset, u8 *val);
> -	int (*afu_cr_read16)(struct cxl_afu *afu, int cr_idx, u64 offset, u16 *val);
> -	int (*afu_cr_read32)(struct cxl_afu *afu, int cr_idx, u64 offset, u32 *val);
> -	int (*afu_cr_read64)(struct cxl_afu *afu, int cr_idx, u64 offset, u64 *val);
> -	int (*afu_cr_write8)(struct cxl_afu *afu, int cr_idx, u64 offset, u8 val);
> -	int (*afu_cr_write16)(struct cxl_afu *afu, int cr_idx, u64 offset, u16 val);
> -	int (*afu_cr_write32)(struct cxl_afu *afu, int cr_idx, u64 offset, u32 val);
> -	ssize_t (*read_adapter_vpd)(struct cxl *adapter, void *buf, size_t count);
> -};
> -extern const struct cxl_backend_ops cxl_native_ops;
> -extern const struct cxl_backend_ops cxl_guest_ops;
> -extern const struct cxl_backend_ops *cxl_ops;
> -
> -/* check if the given pci_dev is on the cxl vphb bus */
> -bool cxl_pci_is_vphb_device(struct pci_dev *dev);
> -
> -/* decode AFU error bits in the PSL register PSL_SERR_An */
> -void cxl_afu_decode_psl_serr(struct cxl_afu *afu, u64 serr);
> -
> -/*
> - * Increments the number of attached contexts on an adapter.
> - * In case an adapter_context_lock is taken the return -EBUSY.
> - */
> -int cxl_adapter_context_get(struct cxl *adapter);
> -
> -/* Decrements the number of attached contexts on an adapter */
> -void cxl_adapter_context_put(struct cxl *adapter);
> -
> -/* If no active contexts then prevents contexts from being attached */
> -int cxl_adapter_context_lock(struct cxl *adapter);
> -
> -/* Unlock the contexts-lock if taken. Warn and force unlock otherwise */
> -void cxl_adapter_context_unlock(struct cxl *adapter);
> -
> -/* Increases the reference count to "struct mm_struct" */
> -void cxl_context_mm_count_get(struct cxl_context *ctx);
> -
> -/* Decrements the reference count to "struct mm_struct" */
> -void cxl_context_mm_count_put(struct cxl_context *ctx);
> -
> -#endif
> diff --git a/drivers/misc/cxl/cxllib.c b/drivers/misc/cxl/cxllib.c
> deleted file mode 100644
> index e5fe0a171472..000000000000
> --- a/drivers/misc/cxl/cxllib.c
> +++ /dev/null
> @@ -1,271 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * Copyright 2017 IBM Corp.
> - */
> -
> -#include <linux/hugetlb.h>
> -#include <linux/sched/mm.h>
> -#include <asm/opal-api.h>
> -#include <asm/pnv-pci.h>
> -#include <misc/cxllib.h>
> -
> -#include "cxl.h"
> -
> -#define CXL_INVALID_DRA                 ~0ull
> -#define CXL_DUMMY_READ_SIZE             128
> -#define CXL_DUMMY_READ_ALIGN            8
> -#define CXL_CAPI_WINDOW_START           0x2000000000000ull
> -#define CXL_CAPI_WINDOW_LOG_SIZE        48
> -#define CXL_XSL_CONFIG_CURRENT_VERSION  CXL_XSL_CONFIG_VERSION1
> -
> -
> -bool cxllib_slot_is_supported(struct pci_dev *dev, unsigned long flags)
> -{
> -	int rc;
> -	u32 phb_index;
> -	u64 chip_id, capp_unit_id;
> -
> -	/* No flags currently supported */
> -	if (flags)
> -		return false;
> -
> -	if (!cpu_has_feature(CPU_FTR_HVMODE))
> -		return false;
> -
> -	if (!cxl_is_power9())
> -		return false;
> -
> -	if (cxl_slot_is_switched(dev))
> -		return false;
> -
> -	/* on p9, some pci slots are not connected to a CAPP unit */
> -	rc = cxl_calc_capp_routing(dev, &chip_id, &phb_index, &capp_unit_id);
> -	if (rc)
> -		return false;
> -
> -	return true;
> -}
> -EXPORT_SYMBOL_GPL(cxllib_slot_is_supported);
> -
> -static DEFINE_MUTEX(dra_mutex);
> -static u64 dummy_read_addr = CXL_INVALID_DRA;
> -
> -static int allocate_dummy_read_buf(void)
> -{
> -	u64 buf, vaddr;
> -	size_t buf_size;
> -
> -	/*
> -	 * Dummy read buffer is 128-byte long, aligned on a
> -	 * 256-byte boundary and we need the physical address.
> -	 */
> -	buf_size = CXL_DUMMY_READ_SIZE + (1ull << CXL_DUMMY_READ_ALIGN);
> -	buf = (u64) kzalloc(buf_size, GFP_KERNEL);
> -	if (!buf)
> -		return -ENOMEM;
> -
> -	vaddr = (buf + (1ull << CXL_DUMMY_READ_ALIGN) - 1) &
> -					(~0ull << CXL_DUMMY_READ_ALIGN);
> -
> -	WARN((vaddr + CXL_DUMMY_READ_SIZE) > (buf + buf_size),
> -		"Dummy read buffer alignment issue");
> -	dummy_read_addr = virt_to_phys((void *) vaddr);
> -	return 0;
> -}
> -
> -int cxllib_get_xsl_config(struct pci_dev *dev, struct cxllib_xsl_config *cfg)
> -{
> -	int rc;
> -	u32 phb_index;
> -	u64 chip_id, capp_unit_id;
> -
> -	if (!cpu_has_feature(CPU_FTR_HVMODE))
> -		return -EINVAL;
> -
> -	mutex_lock(&dra_mutex);
> -	if (dummy_read_addr == CXL_INVALID_DRA) {
> -		rc = allocate_dummy_read_buf();
> -		if (rc) {
> -			mutex_unlock(&dra_mutex);
> -			return rc;
> -		}
> -	}
> -	mutex_unlock(&dra_mutex);
> -
> -	rc = cxl_calc_capp_routing(dev, &chip_id, &phb_index, &capp_unit_id);
> -	if (rc)
> -		return rc;
> -
> -	rc = cxl_get_xsl9_dsnctl(dev, capp_unit_id, &cfg->dsnctl);
> -	if (rc)
> -		return rc;
> -
> -	cfg->version  = CXL_XSL_CONFIG_CURRENT_VERSION;
> -	cfg->log_bar_size = CXL_CAPI_WINDOW_LOG_SIZE;
> -	cfg->bar_addr = CXL_CAPI_WINDOW_START;
> -	cfg->dra = dummy_read_addr;
> -	return 0;
> -}
> -EXPORT_SYMBOL_GPL(cxllib_get_xsl_config);
> -
> -int cxllib_switch_phb_mode(struct pci_dev *dev, enum cxllib_mode mode,
> -			unsigned long flags)
> -{
> -	int rc = 0;
> -
> -	if (!cpu_has_feature(CPU_FTR_HVMODE))
> -		return -EINVAL;
> -
> -	switch (mode) {
> -	case CXL_MODE_PCI:
> -		/*
> -		 * We currently don't support going back to PCI mode
> -		 * However, we'll turn the invalidations off, so that
> -		 * the firmware doesn't have to ack them and can do
> -		 * things like reset, etc.. with no worries.
> -		 * So always return EPERM (can't go back to PCI) or
> -		 * EBUSY if we couldn't even turn off snooping
> -		 */
> -		rc = pnv_phb_to_cxl_mode(dev, OPAL_PHB_CAPI_MODE_SNOOP_OFF);
> -		if (rc)
> -			rc = -EBUSY;
> -		else
> -			rc = -EPERM;
> -		break;
> -	case CXL_MODE_CXL:
> -		/* DMA only supported on TVT1 for the time being */
> -		if (flags != CXL_MODE_DMA_TVT1)
> -			return -EINVAL;
> -		rc = pnv_phb_to_cxl_mode(dev, OPAL_PHB_CAPI_MODE_DMA_TVT1);
> -		if (rc)
> -			return rc;
> -		rc = pnv_phb_to_cxl_mode(dev, OPAL_PHB_CAPI_MODE_SNOOP_ON);
> -		break;
> -	default:
> -		rc = -EINVAL;
> -	}
> -	return rc;
> -}
> -EXPORT_SYMBOL_GPL(cxllib_switch_phb_mode);
> -
> -/*
> - * When switching the PHB to capi mode, the TVT#1 entry for
> - * the Partitionable Endpoint is set in bypass mode, like
> - * in PCI mode.
> - * Configure the device dma to use TVT#1, which is done
> - * by calling dma_set_mask() with a mask large enough.
> - */
> -int cxllib_set_device_dma(struct pci_dev *dev, unsigned long flags)
> -{
> -	int rc;
> -
> -	if (flags)
> -		return -EINVAL;
> -
> -	rc = dma_set_mask(&dev->dev, DMA_BIT_MASK(64));
> -	return rc;
> -}
> -EXPORT_SYMBOL_GPL(cxllib_set_device_dma);
> -
> -int cxllib_get_PE_attributes(struct task_struct *task,
> -			     unsigned long translation_mode,
> -			     struct cxllib_pe_attributes *attr)
> -{
> -	if (translation_mode != CXL_TRANSLATED_MODE &&
> -		translation_mode != CXL_REAL_MODE)
> -		return -EINVAL;
> -
> -	attr->sr = cxl_calculate_sr(false,
> -				task == NULL,
> -				translation_mode == CXL_REAL_MODE,
> -				true);
> -	attr->lpid = mfspr(SPRN_LPID);
> -	if (task) {
> -		struct mm_struct *mm = get_task_mm(task);
> -		if (mm == NULL)
> -			return -EINVAL;
> -		/*
> -		 * Caller is keeping a reference on mm_users for as long
> -		 * as XSL uses the memory context
> -		 */
> -		attr->pid = mm->context.id;
> -		mmput(mm);
> -		attr->tid = task->thread.tidr;
> -	} else {
> -		attr->pid = 0;
> -		attr->tid = 0;
> -	}
> -	return 0;
> -}
> -EXPORT_SYMBOL_GPL(cxllib_get_PE_attributes);
> -
> -static int get_vma_info(struct mm_struct *mm, u64 addr,
> -			u64 *vma_start, u64 *vma_end,
> -			unsigned long *page_size)
> -{
> -	struct vm_area_struct *vma = NULL;
> -	int rc = 0;
> -
> -	mmap_read_lock(mm);
> -
> -	vma = find_vma(mm, addr);
> -	if (!vma) {
> -		rc = -EFAULT;
> -		goto out;
> -	}
> -	*page_size = vma_kernel_pagesize(vma);
> -	*vma_start = vma->vm_start;
> -	*vma_end = vma->vm_end;
> -out:
> -	mmap_read_unlock(mm);
> -	return rc;
> -}
> -
> -int cxllib_handle_fault(struct mm_struct *mm, u64 addr, u64 size, u64 flags)
> -{
> -	int rc;
> -	u64 dar, vma_start, vma_end;
> -	unsigned long page_size;
> -
> -	if (mm == NULL)
> -		return -EFAULT;
> -
> -	/*
> -	 * The buffer we have to process can extend over several pages
> -	 * and may also cover several VMAs.
> -	 * We iterate over all the pages. The page size could vary
> -	 * between VMAs.
> -	 */
> -	rc = get_vma_info(mm, addr, &vma_start, &vma_end, &page_size);
> -	if (rc)
> -		return rc;
> -
> -	for (dar = (addr & ~(page_size - 1)); dar < (addr + size);
> -	     dar += page_size) {
> -		if (dar < vma_start || dar >= vma_end) {
> -			/*
> -			 * We don't hold mm->mmap_lock while iterating, since
> -			 * the lock is required by one of the lower-level page
> -			 * fault processing functions and it could
> -			 * create a deadlock.
> -			 *
> -			 * It means the VMAs can be altered between 2
> -			 * loop iterations and we could theoretically
> -			 * miss a page (however unlikely). But that's
> -			 * not really a problem, as the driver will
> -			 * retry access, get another page fault on the
> -			 * missing page and call us again.
> -			 */
> -			rc = get_vma_info(mm, dar, &vma_start, &vma_end,
> -					&page_size);
> -			if (rc)
> -				return rc;
> -		}
> -
> -		rc = cxl_handle_mm_fault(mm, flags, dar);
> -		if (rc)
> -			return -EFAULT;
> -	}
> -	return 0;
> -}
> -EXPORT_SYMBOL_GPL(cxllib_handle_fault);
> diff --git a/drivers/misc/cxl/debugfs.c b/drivers/misc/cxl/debugfs.c
> deleted file mode 100644
> index 7b987bf498b5..000000000000
> --- a/drivers/misc/cxl/debugfs.c
> +++ /dev/null
> @@ -1,134 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * Copyright 2014 IBM Corp.
> - */
> -
> -#include <linux/debugfs.h>
> -#include <linux/kernel.h>
> -#include <linux/slab.h>
> -
> -#include "cxl.h"
> -
> -static struct dentry *cxl_debugfs;
> -
> -/* Helpers to export CXL mmaped IO registers via debugfs */
> -static int debugfs_io_u64_get(void *data, u64 *val)
> -{
> -	*val = in_be64((u64 __iomem *)data);
> -	return 0;
> -}
> -
> -static int debugfs_io_u64_set(void *data, u64 val)
> -{
> -	out_be64((u64 __iomem *)data, val);
> -	return 0;
> -}
> -DEFINE_DEBUGFS_ATTRIBUTE(fops_io_x64, debugfs_io_u64_get, debugfs_io_u64_set,
> -			 "0x%016llx\n");
> -
> -static void debugfs_create_io_x64(const char *name, umode_t mode,
> -				  struct dentry *parent, u64 __iomem *value)
> -{
> -	debugfs_create_file_unsafe(name, mode, parent, (void __force *)value,
> -				   &fops_io_x64);
> -}
> -
> -void cxl_debugfs_add_adapter_regs_psl9(struct cxl *adapter, struct dentry *dir)
> -{
> -	debugfs_create_io_x64("fir1", S_IRUSR, dir, _cxl_p1_addr(adapter, CXL_PSL9_FIR1));
> -	debugfs_create_io_x64("fir_mask", 0400, dir,
> -			      _cxl_p1_addr(adapter, CXL_PSL9_FIR_MASK));
> -	debugfs_create_io_x64("fir_cntl", S_IRUSR, dir, _cxl_p1_addr(adapter, CXL_PSL9_FIR_CNTL));
> -	debugfs_create_io_x64("trace", S_IRUSR | S_IWUSR, dir, _cxl_p1_addr(adapter, CXL_PSL9_TRACECFG));
> -	debugfs_create_io_x64("debug", 0600, dir,
> -			      _cxl_p1_addr(adapter, CXL_PSL9_DEBUG));
> -	debugfs_create_io_x64("xsl-debug", 0600, dir,
> -			      _cxl_p1_addr(adapter, CXL_XSL9_DBG));
> -}
> -
> -void cxl_debugfs_add_adapter_regs_psl8(struct cxl *adapter, struct dentry *dir)
> -{
> -	debugfs_create_io_x64("fir1", S_IRUSR, dir, _cxl_p1_addr(adapter, CXL_PSL_FIR1));
> -	debugfs_create_io_x64("fir2", S_IRUSR, dir, _cxl_p1_addr(adapter, CXL_PSL_FIR2));
> -	debugfs_create_io_x64("fir_cntl", S_IRUSR, dir, _cxl_p1_addr(adapter, CXL_PSL_FIR_CNTL));
> -	debugfs_create_io_x64("trace", S_IRUSR | S_IWUSR, dir, _cxl_p1_addr(adapter, CXL_PSL_TRACE));
> -}
> -
> -void cxl_debugfs_adapter_add(struct cxl *adapter)
> -{
> -	struct dentry *dir;
> -	char buf[32];
> -
> -	if (!cxl_debugfs)
> -		return;
> -
> -	snprintf(buf, 32, "card%i", adapter->adapter_num);
> -	dir = debugfs_create_dir(buf, cxl_debugfs);
> -	adapter->debugfs = dir;
> -
> -	debugfs_create_io_x64("err_ivte", S_IRUSR, dir, _cxl_p1_addr(adapter, CXL_PSL_ErrIVTE));
> -
> -	if (adapter->native->sl_ops->debugfs_add_adapter_regs)
> -		adapter->native->sl_ops->debugfs_add_adapter_regs(adapter, dir);
> -}
> -
> -void cxl_debugfs_adapter_remove(struct cxl *adapter)
> -{
> -	debugfs_remove_recursive(adapter->debugfs);
> -}
> -
> -void cxl_debugfs_add_afu_regs_psl9(struct cxl_afu *afu, struct dentry *dir)
> -{
> -	debugfs_create_io_x64("serr", S_IRUSR, dir, _cxl_p1n_addr(afu, CXL_PSL_SERR_An));
> -}
> -
> -void cxl_debugfs_add_afu_regs_psl8(struct cxl_afu *afu, struct dentry *dir)
> -{
> -	debugfs_create_io_x64("sstp0", S_IRUSR, dir, _cxl_p2n_addr(afu, CXL_SSTP0_An));
> -	debugfs_create_io_x64("sstp1", S_IRUSR, dir, _cxl_p2n_addr(afu, CXL_SSTP1_An));
> -
> -	debugfs_create_io_x64("fir", S_IRUSR, dir, _cxl_p1n_addr(afu, CXL_PSL_FIR_SLICE_An));
> -	debugfs_create_io_x64("serr", S_IRUSR, dir, _cxl_p1n_addr(afu, CXL_PSL_SERR_An));
> -	debugfs_create_io_x64("afu_debug", S_IRUSR, dir, _cxl_p1n_addr(afu, CXL_AFU_DEBUG_An));
> -	debugfs_create_io_x64("trace", S_IRUSR | S_IWUSR, dir, _cxl_p1n_addr(afu, CXL_PSL_SLICE_TRACE));
> -}
> -
> -void cxl_debugfs_afu_add(struct cxl_afu *afu)
> -{
> -	struct dentry *dir;
> -	char buf[32];
> -
> -	if (!afu->adapter->debugfs)
> -		return;
> -
> -	snprintf(buf, 32, "psl%i.%i", afu->adapter->adapter_num, afu->slice);
> -	dir = debugfs_create_dir(buf, afu->adapter->debugfs);
> -	afu->debugfs = dir;
> -
> -	debugfs_create_io_x64("sr",         S_IRUSR, dir, _cxl_p1n_addr(afu, CXL_PSL_SR_An));
> -	debugfs_create_io_x64("dsisr",      S_IRUSR, dir, _cxl_p2n_addr(afu, CXL_PSL_DSISR_An));
> -	debugfs_create_io_x64("dar",        S_IRUSR, dir, _cxl_p2n_addr(afu, CXL_PSL_DAR_An));
> -
> -	debugfs_create_io_x64("err_status", S_IRUSR, dir, _cxl_p2n_addr(afu, CXL_PSL_ErrStat_An));
> -
> -	if (afu->adapter->native->sl_ops->debugfs_add_afu_regs)
> -		afu->adapter->native->sl_ops->debugfs_add_afu_regs(afu, dir);
> -}
> -
> -void cxl_debugfs_afu_remove(struct cxl_afu *afu)
> -{
> -	debugfs_remove_recursive(afu->debugfs);
> -}
> -
> -void __init cxl_debugfs_init(void)
> -{
> -	if (!cpu_has_feature(CPU_FTR_HVMODE))
> -		return;
> -
> -	cxl_debugfs = debugfs_create_dir("cxl", NULL);
> -}
> -
> -void cxl_debugfs_exit(void)
> -{
> -	debugfs_remove_recursive(cxl_debugfs);
> -}
> diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
> deleted file mode 100644
> index 2c64f55cf01f..000000000000
> --- a/drivers/misc/cxl/fault.c
> +++ /dev/null
> @@ -1,341 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * Copyright 2014 IBM Corp.
> - */
> -
> -#include <linux/workqueue.h>
> -#include <linux/sched/signal.h>
> -#include <linux/sched/mm.h>
> -#include <linux/pid.h>
> -#include <linux/mm.h>
> -#include <linux/moduleparam.h>
> -
> -#undef MODULE_PARAM_PREFIX
> -#define MODULE_PARAM_PREFIX "cxl" "."
> -#include <asm/current.h>
> -#include <asm/copro.h>
> -#include <asm/mmu.h>
> -
> -#include "cxl.h"
> -#include "trace.h"
> -
> -static bool sste_matches(struct cxl_sste *sste, struct copro_slb *slb)
> -{
> -	return ((sste->vsid_data == cpu_to_be64(slb->vsid)) &&
> -		(sste->esid_data == cpu_to_be64(slb->esid)));
> -}
> -
> -/*
> - * This finds a free SSTE for the given SLB, or returns NULL if it's already in
> - * the segment table.
> - */
> -static struct cxl_sste *find_free_sste(struct cxl_context *ctx,
> -				       struct copro_slb *slb)
> -{
> -	struct cxl_sste *primary, *sste, *ret = NULL;
> -	unsigned int mask = (ctx->sst_size >> 7) - 1; /* SSTP0[SegTableSize] */
> -	unsigned int entry;
> -	unsigned int hash;
> -
> -	if (slb->vsid & SLB_VSID_B_1T)
> -		hash = (slb->esid >> SID_SHIFT_1T) & mask;
> -	else /* 256M */
> -		hash = (slb->esid >> SID_SHIFT) & mask;
> -
> -	primary = ctx->sstp + (hash << 3);
> -
> -	for (entry = 0, sste = primary; entry < 8; entry++, sste++) {
> -		if (!ret && !(be64_to_cpu(sste->esid_data) & SLB_ESID_V))
> -			ret = sste;
> -		if (sste_matches(sste, slb))
> -			return NULL;
> -	}
> -	if (ret)
> -		return ret;
> -
> -	/* Nothing free, select an entry to cast out */
> -	ret = primary + ctx->sst_lru;
> -	ctx->sst_lru = (ctx->sst_lru + 1) & 0x7;
> -
> -	return ret;
> -}
> -
> -static void cxl_load_segment(struct cxl_context *ctx, struct copro_slb *slb)
> -{
> -	/* mask is the group index, we search primary and secondary here. */
> -	struct cxl_sste *sste;
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&ctx->sste_lock, flags);
> -	sste = find_free_sste(ctx, slb);
> -	if (!sste)
> -		goto out_unlock;
> -
> -	pr_devel("CXL Populating SST[%li]: %#llx %#llx\n",
> -			sste - ctx->sstp, slb->vsid, slb->esid);
> -	trace_cxl_ste_write(ctx, sste - ctx->sstp, slb->esid, slb->vsid);
> -
> -	sste->vsid_data = cpu_to_be64(slb->vsid);
> -	sste->esid_data = cpu_to_be64(slb->esid);
> -out_unlock:
> -	spin_unlock_irqrestore(&ctx->sste_lock, flags);
> -}
> -
> -static int cxl_fault_segment(struct cxl_context *ctx, struct mm_struct *mm,
> -			     u64 ea)
> -{
> -	struct copro_slb slb = {0,0};
> -	int rc;
> -
> -	if (!(rc = copro_calculate_slb(mm, ea, &slb))) {
> -		cxl_load_segment(ctx, &slb);
> -	}
> -
> -	return rc;
> -}
> -
> -static void cxl_ack_ae(struct cxl_context *ctx)
> -{
> -	unsigned long flags;
> -
> -	cxl_ops->ack_irq(ctx, CXL_PSL_TFC_An_AE, 0);
> -
> -	spin_lock_irqsave(&ctx->lock, flags);
> -	ctx->pending_fault = true;
> -	ctx->fault_addr = ctx->dar;
> -	ctx->fault_dsisr = ctx->dsisr;
> -	spin_unlock_irqrestore(&ctx->lock, flags);
> -
> -	wake_up_all(&ctx->wq);
> -}
> -
> -static int cxl_handle_segment_miss(struct cxl_context *ctx,
> -				   struct mm_struct *mm, u64 ea)
> -{
> -	int rc;
> -
> -	pr_devel("CXL interrupt: Segment fault pe: %i ea: %#llx\n", ctx->pe, ea);
> -	trace_cxl_ste_miss(ctx, ea);
> -
> -	if ((rc = cxl_fault_segment(ctx, mm, ea)))
> -		cxl_ack_ae(ctx);
> -	else {
> -
> -		mb(); /* Order seg table write to TFC MMIO write */
> -		cxl_ops->ack_irq(ctx, CXL_PSL_TFC_An_R, 0);
> -	}
> -
> -	return IRQ_HANDLED;
> -}
> -
> -int cxl_handle_mm_fault(struct mm_struct *mm, u64 dsisr, u64 dar)
> -{
> -	vm_fault_t flt = 0;
> -	int result;
> -	unsigned long access, flags, inv_flags = 0;
> -
> -	/*
> -	 * Add the fault handling cpu to task mm cpumask so that we
> -	 * can do a safe lockless page table walk when inserting the
> -	 * hash page table entry. This function get called with a
> -	 * valid mm for user space addresses. Hence using the if (mm)
> -	 * check is sufficient here.
> -	 */
> -	if (mm && !cpumask_test_cpu(smp_processor_id(), mm_cpumask(mm))) {
> -		cpumask_set_cpu(smp_processor_id(), mm_cpumask(mm));
> -		/*
> -		 * We need to make sure we walk the table only after
> -		 * we update the cpumask. The other side of the barrier
> -		 * is explained in serialize_against_pte_lookup()
> -		 */
> -		smp_mb();
> -	}
> -	if ((result = copro_handle_mm_fault(mm, dar, dsisr, &flt))) {
> -		pr_devel("copro_handle_mm_fault failed: %#x\n", result);
> -		return result;
> -	}
> -
> -	if (!radix_enabled()) {
> -		/*
> -		 * update_mmu_cache() will not have loaded the hash since current->trap
> -		 * is not a 0x400 or 0x300, so just call hash_page_mm() here.
> -		 */
> -		access = _PAGE_PRESENT | _PAGE_READ;
> -		if (dsisr & CXL_PSL_DSISR_An_S)
> -			access |= _PAGE_WRITE;
> -
> -		if (!mm && (get_region_id(dar) != USER_REGION_ID))
> -			access |= _PAGE_PRIVILEGED;
> -
> -		if (dsisr & DSISR_NOHPTE)
> -			inv_flags |= HPTE_NOHPTE_UPDATE;
> -
> -		local_irq_save(flags);
> -		hash_page_mm(mm, dar, access, 0x300, inv_flags);
> -		local_irq_restore(flags);
> -	}
> -	return 0;
> -}
> -
> -static void cxl_handle_page_fault(struct cxl_context *ctx,
> -				  struct mm_struct *mm,
> -				  u64 dsisr, u64 dar)
> -{
> -	trace_cxl_pte_miss(ctx, dsisr, dar);
> -
> -	if (cxl_handle_mm_fault(mm, dsisr, dar)) {
> -		cxl_ack_ae(ctx);
> -	} else {
> -		pr_devel("Page fault successfully handled for pe: %i!\n", ctx->pe);
> -		cxl_ops->ack_irq(ctx, CXL_PSL_TFC_An_R, 0);
> -	}
> -}
> -
> -/*
> - * Returns the mm_struct corresponding to the context ctx.
> - * mm_users == 0, the context may be in the process of being closed.
> - */
> -static struct mm_struct *get_mem_context(struct cxl_context *ctx)
> -{
> -	if (ctx->mm == NULL)
> -		return NULL;
> -
> -	if (!mmget_not_zero(ctx->mm))
> -		return NULL;
> -
> -	return ctx->mm;
> -}
> -
> -static bool cxl_is_segment_miss(struct cxl_context *ctx, u64 dsisr)
> -{
> -	if ((cxl_is_power8() && (dsisr & CXL_PSL_DSISR_An_DS)))
> -		return true;
> -
> -	return false;
> -}
> -
> -static bool cxl_is_page_fault(struct cxl_context *ctx, u64 dsisr)
> -{
> -	if ((cxl_is_power8()) && (dsisr & CXL_PSL_DSISR_An_DM))
> -		return true;
> -
> -	if (cxl_is_power9())
> -		return true;
> -
> -	return false;
> -}
> -
> -void cxl_handle_fault(struct work_struct *fault_work)
> -{
> -	struct cxl_context *ctx =
> -		container_of(fault_work, struct cxl_context, fault_work);
> -	u64 dsisr = ctx->dsisr;
> -	u64 dar = ctx->dar;
> -	struct mm_struct *mm = NULL;
> -
> -	if (cpu_has_feature(CPU_FTR_HVMODE)) {
> -		if (cxl_p2n_read(ctx->afu, CXL_PSL_DSISR_An) != dsisr ||
> -		    cxl_p2n_read(ctx->afu, CXL_PSL_DAR_An) != dar ||
> -		    cxl_p2n_read(ctx->afu, CXL_PSL_PEHandle_An) != ctx->pe) {
> -			/* Most likely explanation is harmless - a dedicated
> -			 * process has detached and these were cleared by the
> -			 * PSL purge, but warn about it just in case
> -			 */
> -			dev_notice(&ctx->afu->dev, "cxl_handle_fault: Translation fault regs changed\n");
> -			return;
> -		}
> -	}
> -
> -	/* Early return if the context is being / has been detached */
> -	if (ctx->status == CLOSED) {
> -		cxl_ack_ae(ctx);
> -		return;
> -	}
> -
> -	pr_devel("CXL BOTTOM HALF handling fault for afu pe: %i. "
> -		"DSISR: %#llx DAR: %#llx\n", ctx->pe, dsisr, dar);
> -
> -	if (!ctx->kernel) {
> -
> -		mm = get_mem_context(ctx);
> -		if (mm == NULL) {
> -			pr_devel("%s: unable to get mm for pe=%d pid=%i\n",
> -				 __func__, ctx->pe, pid_nr(ctx->pid));
> -			cxl_ack_ae(ctx);
> -			return;
> -		} else {
> -			pr_devel("Handling page fault for pe=%d pid=%i\n",
> -				 ctx->pe, pid_nr(ctx->pid));
> -		}
> -	}
> -
> -	if (cxl_is_segment_miss(ctx, dsisr))
> -		cxl_handle_segment_miss(ctx, mm, dar);
> -	else if (cxl_is_page_fault(ctx, dsisr))
> -		cxl_handle_page_fault(ctx, mm, dsisr, dar);
> -	else
> -		WARN(1, "cxl_handle_fault has nothing to handle\n");
> -
> -	if (mm)
> -		mmput(mm);
> -}
> -
> -static u64 next_segment(u64 ea, u64 vsid)
> -{
> -	if (vsid & SLB_VSID_B_1T)
> -		ea |= (1ULL << 40) - 1;
> -	else
> -		ea |= (1ULL << 28) - 1;
> -
> -	return ea + 1;
> -}
> -
> -static void cxl_prefault_vma(struct cxl_context *ctx, struct mm_struct *mm)
> -{
> -	u64 ea, last_esid = 0;
> -	struct copro_slb slb;
> -	VMA_ITERATOR(vmi, mm, 0);
> -	struct vm_area_struct *vma;
> -	int rc;
> -
> -	mmap_read_lock(mm);
> -	for_each_vma(vmi, vma) {
> -		for (ea = vma->vm_start; ea < vma->vm_end;
> -				ea = next_segment(ea, slb.vsid)) {
> -			rc = copro_calculate_slb(mm, ea, &slb);
> -			if (rc)
> -				continue;
> -
> -			if (last_esid == slb.esid)
> -				continue;
> -
> -			cxl_load_segment(ctx, &slb);
> -			last_esid = slb.esid;
> -		}
> -	}
> -	mmap_read_unlock(mm);
> -}
> -
> -void cxl_prefault(struct cxl_context *ctx, u64 wed)
> -{
> -	struct mm_struct *mm = get_mem_context(ctx);
> -
> -	if (mm == NULL) {
> -		pr_devel("cxl_prefault unable to get mm %i\n",
> -			 pid_nr(ctx->pid));
> -		return;
> -	}
> -
> -	switch (ctx->afu->prefault_mode) {
> -	case CXL_PREFAULT_WED:
> -		cxl_fault_segment(ctx, mm, wed);
> -		break;
> -	case CXL_PREFAULT_ALL:
> -		cxl_prefault_vma(ctx, mm);
> -		break;
> -	default:
> -		break;
> -	}
> -
> -	mmput(mm);
> -}
> diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
> deleted file mode 100644
> index 012e11b959bc..000000000000
> --- a/drivers/misc/cxl/file.c
> +++ /dev/null
> @@ -1,699 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * Copyright 2014 IBM Corp.
> - */
> -
> -#include <linux/spinlock.h>
> -#include <linux/module.h>
> -#include <linux/export.h>
> -#include <linux/kernel.h>
> -#include <linux/bitmap.h>
> -#include <linux/sched/signal.h>
> -#include <linux/poll.h>
> -#include <linux/pid.h>
> -#include <linux/fs.h>
> -#include <linux/mm.h>
> -#include <linux/slab.h>
> -#include <linux/sched/mm.h>
> -#include <linux/mmu_context.h>
> -#include <asm/cputable.h>
> -#include <asm/current.h>
> -#include <asm/copro.h>
> -
> -#include "cxl.h"
> -#include "trace.h"
> -
> -#define CXL_NUM_MINORS 256 /* Total to reserve */
> -
> -#define CXL_AFU_MINOR_D(afu) (CXL_CARD_MINOR(afu->adapter) + 1 + (3 * afu->slice))
> -#define CXL_AFU_MINOR_M(afu) (CXL_AFU_MINOR_D(afu) + 1)
> -#define CXL_AFU_MINOR_S(afu) (CXL_AFU_MINOR_D(afu) + 2)
> -#define CXL_AFU_MKDEV_D(afu) MKDEV(MAJOR(cxl_dev), CXL_AFU_MINOR_D(afu))
> -#define CXL_AFU_MKDEV_M(afu) MKDEV(MAJOR(cxl_dev), CXL_AFU_MINOR_M(afu))
> -#define CXL_AFU_MKDEV_S(afu) MKDEV(MAJOR(cxl_dev), CXL_AFU_MINOR_S(afu))
> -
> -#define CXL_DEVT_AFU(dev) ((MINOR(dev) % CXL_DEV_MINORS - 1) / 3)
> -
> -#define CXL_DEVT_IS_CARD(dev) (MINOR(dev) % CXL_DEV_MINORS == 0)
> -
> -static dev_t cxl_dev;
> -
> -static int __afu_open(struct inode *inode, struct file *file, bool master)
> -{
> -	struct cxl *adapter;
> -	struct cxl_afu *afu;
> -	struct cxl_context *ctx;
> -	int adapter_num = CXL_DEVT_ADAPTER(inode->i_rdev);
> -	int slice = CXL_DEVT_AFU(inode->i_rdev);
> -	int rc = -ENODEV;
> -
> -	pr_devel("afu_open afu%i.%i\n", slice, adapter_num);
> -
> -	if (!(adapter = get_cxl_adapter(adapter_num)))
> -		return -ENODEV;
> -
> -	if (slice > adapter->slices)
> -		goto err_put_adapter;
> -
> -	spin_lock(&adapter->afu_list_lock);
> -	if (!(afu = adapter->afu[slice])) {
> -		spin_unlock(&adapter->afu_list_lock);
> -		goto err_put_adapter;
> -	}
> -
> -	/*
> -	 * taking a ref to the afu so that it doesn't go away
> -	 * for rest of the function. This ref is released before
> -	 * we return.
> -	 */
> -	cxl_afu_get(afu);
> -	spin_unlock(&adapter->afu_list_lock);
> -
> -	if (!afu->current_mode)
> -		goto err_put_afu;
> -
> -	if (!cxl_ops->link_ok(adapter, afu)) {
> -		rc = -EIO;
> -		goto err_put_afu;
> -	}
> -
> -	if (!(ctx = cxl_context_alloc())) {
> -		rc = -ENOMEM;
> -		goto err_put_afu;
> -	}
> -
> -	rc = cxl_context_init(ctx, afu, master);
> -	if (rc)
> -		goto err_put_afu;
> -
> -	cxl_context_set_mapping(ctx, inode->i_mapping);
> -
> -	pr_devel("afu_open pe: %i\n", ctx->pe);
> -	file->private_data = ctx;
> -
> -	/* indicate success */
> -	rc = 0;
> -
> -err_put_afu:
> -	/* release the ref taken earlier */
> -	cxl_afu_put(afu);
> -err_put_adapter:
> -	put_device(&adapter->dev);
> -	return rc;
> -}
> -
> -int afu_open(struct inode *inode, struct file *file)
> -{
> -	return __afu_open(inode, file, false);
> -}
> -
> -static int afu_master_open(struct inode *inode, struct file *file)
> -{
> -	return __afu_open(inode, file, true);
> -}
> -
> -int afu_release(struct inode *inode, struct file *file)
> -{
> -	struct cxl_context *ctx = file->private_data;
> -
> -	pr_devel("%s: closing cxl file descriptor. pe: %i\n",
> -		 __func__, ctx->pe);
> -	cxl_context_detach(ctx);
> -
> -
> -	/*
> -	 * Delete the context's mapping pointer, unless it's created by the
> -	 * kernel API, in which case leave it so it can be freed by reclaim_ctx()
> -	 */
> -	if (!ctx->kernelapi) {
> -		mutex_lock(&ctx->mapping_lock);
> -		ctx->mapping = NULL;
> -		mutex_unlock(&ctx->mapping_lock);
> -	}
> -
> -	/*
> -	 * At this this point all bottom halfs have finished and we should be
> -	 * getting no more IRQs from the hardware for this context.  Once it's
> -	 * removed from the IDR (and RCU synchronised) it's safe to free the
> -	 * sstp and context.
> -	 */
> -	cxl_context_free(ctx);
> -
> -	return 0;
> -}
> -
> -static long afu_ioctl_start_work(struct cxl_context *ctx,
> -				 struct cxl_ioctl_start_work __user *uwork)
> -{
> -	struct cxl_ioctl_start_work work;
> -	u64 amr = 0;
> -	int rc;
> -
> -	pr_devel("%s: pe: %i\n", __func__, ctx->pe);
> -
> -	/* Do this outside the status_mutex to avoid a circular dependency with
> -	 * the locking in cxl_mmap_fault() */
> -	if (copy_from_user(&work, uwork, sizeof(work)))
> -		return -EFAULT;
> -
> -	mutex_lock(&ctx->status_mutex);
> -	if (ctx->status != OPENED) {
> -		rc = -EIO;
> -		goto out;
> -	}
> -
> -	/*
> -	 * if any of the reserved fields are set or any of the unused
> -	 * flags are set it's invalid
> -	 */
> -	if (work.reserved1 || work.reserved2 || work.reserved3 ||
> -	    work.reserved4 || work.reserved5 ||
> -	    (work.flags & ~CXL_START_WORK_ALL)) {
> -		rc = -EINVAL;
> -		goto out;
> -	}
> -
> -	if (!(work.flags & CXL_START_WORK_NUM_IRQS))
> -		work.num_interrupts = ctx->afu->pp_irqs;
> -	else if ((work.num_interrupts < ctx->afu->pp_irqs) ||
> -		 (work.num_interrupts > ctx->afu->irqs_max)) {
> -		rc =  -EINVAL;
> -		goto out;
> -	}
> -
> -	if ((rc = afu_register_irqs(ctx, work.num_interrupts)))
> -		goto out;
> -
> -	if (work.flags & CXL_START_WORK_AMR)
> -		amr = work.amr & mfspr(SPRN_UAMOR);
> -
> -	if (work.flags & CXL_START_WORK_TID)
> -		ctx->assign_tidr = true;
> -
> -	ctx->mmio_err_ff = !!(work.flags & CXL_START_WORK_ERR_FF);
> -
> -	/*
> -	 * Increment the mapped context count for adapter. This also checks
> -	 * if adapter_context_lock is taken.
> -	 */
> -	rc = cxl_adapter_context_get(ctx->afu->adapter);
> -	if (rc) {
> -		afu_release_irqs(ctx, ctx);
> -		goto out;
> -	}
> -
> -	/*
> -	 * We grab the PID here and not in the file open to allow for the case
> -	 * where a process (master, some daemon, etc) has opened the chardev on
> -	 * behalf of another process, so the AFU's mm gets bound to the process
> -	 * that performs this ioctl and not the process that opened the file.
> -	 * Also we grab the PID of the group leader so that if the task that
> -	 * has performed the attach operation exits the mm context of the
> -	 * process is still accessible.
> -	 */
> -	ctx->pid = get_task_pid(current, PIDTYPE_PID);
> -
> -	/* acquire a reference to the task's mm */
> -	ctx->mm = get_task_mm(current);
> -
> -	/* ensure this mm_struct can't be freed */
> -	cxl_context_mm_count_get(ctx);
> -
> -	if (ctx->mm) {
> -		/* decrement the use count from above */
> -		mmput(ctx->mm);
> -		/* make TLBIs for this context global */
> -		mm_context_add_copro(ctx->mm);
> -	}
> -
> -	/*
> -	 * Increment driver use count. Enables global TLBIs for hash
> -	 * and callbacks to handle the segment table
> -	 */
> -	cxl_ctx_get();
> -
> -	/*
> -	 * A barrier is needed to make sure all TLBIs are global
> -	 * before we attach and the context starts being used by the
> -	 * adapter.
> -	 *
> -	 * Needed after mm_context_add_copro() for radix and
> -	 * cxl_ctx_get() for hash/p8.
> -	 *
> -	 * The barrier should really be mb(), since it involves a
> -	 * device. However, it's only useful when we have local
> -	 * vs. global TLBIs, i.e SMP=y. So keep smp_mb().
> -	 */
> -	smp_mb();
> -
> -	trace_cxl_attach(ctx, work.work_element_descriptor, work.num_interrupts, amr);
> -
> -	if ((rc = cxl_ops->attach_process(ctx, false, work.work_element_descriptor,
> -							amr))) {
> -		afu_release_irqs(ctx, ctx);
> -		cxl_adapter_context_put(ctx->afu->adapter);
> -		put_pid(ctx->pid);
> -		ctx->pid = NULL;
> -		cxl_ctx_put();
> -		cxl_context_mm_count_put(ctx);
> -		if (ctx->mm)
> -			mm_context_remove_copro(ctx->mm);
> -		goto out;
> -	}
> -
> -	rc = 0;
> -	if (work.flags & CXL_START_WORK_TID) {
> -		work.tid = ctx->tidr;
> -		if (copy_to_user(uwork, &work, sizeof(work)))
> -			rc = -EFAULT;
> -	}
> -
> -	ctx->status = STARTED;
> -
> -out:
> -	mutex_unlock(&ctx->status_mutex);
> -	return rc;
> -}
> -
> -static long afu_ioctl_process_element(struct cxl_context *ctx,
> -				      int __user *upe)
> -{
> -	pr_devel("%s: pe: %i\n", __func__, ctx->pe);
> -
> -	if (copy_to_user(upe, &ctx->external_pe, sizeof(__u32)))
> -		return -EFAULT;
> -
> -	return 0;
> -}
> -
> -static long afu_ioctl_get_afu_id(struct cxl_context *ctx,
> -				 struct cxl_afu_id __user *upafuid)
> -{
> -	struct cxl_afu_id afuid = { 0 };
> -
> -	afuid.card_id = ctx->afu->adapter->adapter_num;
> -	afuid.afu_offset = ctx->afu->slice;
> -	afuid.afu_mode = ctx->afu->current_mode;
> -
> -	/* set the flag bit in case the afu is a slave */
> -	if (ctx->afu->current_mode == CXL_MODE_DIRECTED && !ctx->master)
> -		afuid.flags |= CXL_AFUID_FLAG_SLAVE;
> -
> -	if (copy_to_user(upafuid, &afuid, sizeof(afuid)))
> -		return -EFAULT;
> -
> -	return 0;
> -}
> -
> -long afu_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> -{
> -	struct cxl_context *ctx = file->private_data;
> -
> -	if (ctx->status == CLOSED)
> -		return -EIO;
> -
> -	if (!cxl_ops->link_ok(ctx->afu->adapter, ctx->afu))
> -		return -EIO;
> -
> -	pr_devel("afu_ioctl\n");
> -	switch (cmd) {
> -	case CXL_IOCTL_START_WORK:
> -		return afu_ioctl_start_work(ctx, (struct cxl_ioctl_start_work __user *)arg);
> -	case CXL_IOCTL_GET_PROCESS_ELEMENT:
> -		return afu_ioctl_process_element(ctx, (__u32 __user *)arg);
> -	case CXL_IOCTL_GET_AFU_ID:
> -		return afu_ioctl_get_afu_id(ctx, (struct cxl_afu_id __user *)
> -					    arg);
> -	}
> -	return -EINVAL;
> -}
> -
> -static long afu_compat_ioctl(struct file *file, unsigned int cmd,
> -			     unsigned long arg)
> -{
> -	return afu_ioctl(file, cmd, arg);
> -}
> -
> -int afu_mmap(struct file *file, struct vm_area_struct *vm)
> -{
> -	struct cxl_context *ctx = file->private_data;
> -
> -	/* AFU must be started before we can MMIO */
> -	if (ctx->status != STARTED)
> -		return -EIO;
> -
> -	if (!cxl_ops->link_ok(ctx->afu->adapter, ctx->afu))
> -		return -EIO;
> -
> -	return cxl_context_iomap(ctx, vm);
> -}
> -
> -static inline bool ctx_event_pending(struct cxl_context *ctx)
> -{
> -	if (ctx->pending_irq || ctx->pending_fault || ctx->pending_afu_err)
> -		return true;
> -
> -	if (ctx->afu_driver_ops && atomic_read(&ctx->afu_driver_events))
> -		return true;
> -
> -	return false;
> -}
> -
> -__poll_t afu_poll(struct file *file, struct poll_table_struct *poll)
> -{
> -	struct cxl_context *ctx = file->private_data;
> -	__poll_t mask = 0;
> -	unsigned long flags;
> -
> -
> -	poll_wait(file, &ctx->wq, poll);
> -
> -	pr_devel("afu_poll wait done pe: %i\n", ctx->pe);
> -
> -	spin_lock_irqsave(&ctx->lock, flags);
> -	if (ctx_event_pending(ctx))
> -		mask |= EPOLLIN | EPOLLRDNORM;
> -	else if (ctx->status == CLOSED)
> -		/* Only error on closed when there are no futher events pending
> -		 */
> -		mask |= EPOLLERR;
> -	spin_unlock_irqrestore(&ctx->lock, flags);
> -
> -	pr_devel("afu_poll pe: %i returning %#x\n", ctx->pe, mask);
> -
> -	return mask;
> -}
> -
> -static ssize_t afu_driver_event_copy(struct cxl_context *ctx,
> -				     char __user *buf,
> -				     struct cxl_event *event,
> -				     struct cxl_event_afu_driver_reserved *pl)
> -{
> -	/* Check event */
> -	if (!pl) {
> -		ctx->afu_driver_ops->event_delivered(ctx, pl, -EINVAL);
> -		return -EFAULT;
> -	}
> -
> -	/* Check event size */
> -	event->header.size += pl->data_size;
> -	if (event->header.size > CXL_READ_MIN_SIZE) {
> -		ctx->afu_driver_ops->event_delivered(ctx, pl, -EINVAL);
> -		return -EFAULT;
> -	}
> -
> -	/* Copy event header */
> -	if (copy_to_user(buf, event, sizeof(struct cxl_event_header))) {
> -		ctx->afu_driver_ops->event_delivered(ctx, pl, -EFAULT);
> -		return -EFAULT;
> -	}
> -
> -	/* Copy event data */
> -	buf += sizeof(struct cxl_event_header);
> -	if (copy_to_user(buf, &pl->data, pl->data_size)) {
> -		ctx->afu_driver_ops->event_delivered(ctx, pl, -EFAULT);
> -		return -EFAULT;
> -	}
> -
> -	ctx->afu_driver_ops->event_delivered(ctx, pl, 0); /* Success */
> -	return event->header.size;
> -}
> -
> -ssize_t afu_read(struct file *file, char __user *buf, size_t count,
> -			loff_t *off)
> -{
> -	struct cxl_context *ctx = file->private_data;
> -	struct cxl_event_afu_driver_reserved *pl = NULL;
> -	struct cxl_event event;
> -	unsigned long flags;
> -	int rc;
> -	DEFINE_WAIT(wait);
> -
> -	if (!cxl_ops->link_ok(ctx->afu->adapter, ctx->afu))
> -		return -EIO;
> -
> -	if (count < CXL_READ_MIN_SIZE)
> -		return -EINVAL;
> -
> -	spin_lock_irqsave(&ctx->lock, flags);
> -
> -	for (;;) {
> -		prepare_to_wait(&ctx->wq, &wait, TASK_INTERRUPTIBLE);
> -		if (ctx_event_pending(ctx) || (ctx->status == CLOSED))
> -			break;
> -
> -		if (!cxl_ops->link_ok(ctx->afu->adapter, ctx->afu)) {
> -			rc = -EIO;
> -			goto out;
> -		}
> -
> -		if (file->f_flags & O_NONBLOCK) {
> -			rc = -EAGAIN;
> -			goto out;
> -		}
> -
> -		if (signal_pending(current)) {
> -			rc = -ERESTARTSYS;
> -			goto out;
> -		}
> -
> -		spin_unlock_irqrestore(&ctx->lock, flags);
> -		pr_devel("afu_read going to sleep...\n");
> -		schedule();
> -		pr_devel("afu_read woken up\n");
> -		spin_lock_irqsave(&ctx->lock, flags);
> -	}
> -
> -	finish_wait(&ctx->wq, &wait);
> -
> -	memset(&event, 0, sizeof(event));
> -	event.header.process_element = ctx->pe;
> -	event.header.size = sizeof(struct cxl_event_header);
> -	if (ctx->afu_driver_ops && atomic_read(&ctx->afu_driver_events)) {
> -		pr_devel("afu_read delivering AFU driver specific event\n");
> -		pl = ctx->afu_driver_ops->fetch_event(ctx);
> -		atomic_dec(&ctx->afu_driver_events);
> -		event.header.type = CXL_EVENT_AFU_DRIVER;
> -	} else if (ctx->pending_irq) {
> -		pr_devel("afu_read delivering AFU interrupt\n");
> -		event.header.size += sizeof(struct cxl_event_afu_interrupt);
> -		event.header.type = CXL_EVENT_AFU_INTERRUPT;
> -		event.irq.irq = find_first_bit(ctx->irq_bitmap, ctx->irq_count) + 1;
> -		clear_bit(event.irq.irq - 1, ctx->irq_bitmap);
> -		if (bitmap_empty(ctx->irq_bitmap, ctx->irq_count))
> -			ctx->pending_irq = false;
> -	} else if (ctx->pending_fault) {
> -		pr_devel("afu_read delivering data storage fault\n");
> -		event.header.size += sizeof(struct cxl_event_data_storage);
> -		event.header.type = CXL_EVENT_DATA_STORAGE;
> -		event.fault.addr = ctx->fault_addr;
> -		event.fault.dsisr = ctx->fault_dsisr;
> -		ctx->pending_fault = false;
> -	} else if (ctx->pending_afu_err) {
> -		pr_devel("afu_read delivering afu error\n");
> -		event.header.size += sizeof(struct cxl_event_afu_error);
> -		event.header.type = CXL_EVENT_AFU_ERROR;
> -		event.afu_error.error = ctx->afu_err;
> -		ctx->pending_afu_err = false;
> -	} else if (ctx->status == CLOSED) {
> -		pr_devel("afu_read fatal error\n");
> -		spin_unlock_irqrestore(&ctx->lock, flags);
> -		return -EIO;
> -	} else
> -		WARN(1, "afu_read must be buggy\n");
> -
> -	spin_unlock_irqrestore(&ctx->lock, flags);
> -
> -	if (event.header.type == CXL_EVENT_AFU_DRIVER)
> -		return afu_driver_event_copy(ctx, buf, &event, pl);
> -
> -	if (copy_to_user(buf, &event, event.header.size))
> -		return -EFAULT;
> -	return event.header.size;
> -
> -out:
> -	finish_wait(&ctx->wq, &wait);
> -	spin_unlock_irqrestore(&ctx->lock, flags);
> -	return rc;
> -}
> -
> -/*
> - * Note: if this is updated, we need to update api.c to patch the new ones in
> - * too
> - */
> -const struct file_operations afu_fops = {
> -	.owner		= THIS_MODULE,
> -	.open           = afu_open,
> -	.poll		= afu_poll,
> -	.read		= afu_read,
> -	.release        = afu_release,
> -	.unlocked_ioctl = afu_ioctl,
> -	.compat_ioctl   = afu_compat_ioctl,
> -	.mmap           = afu_mmap,
> -};
> -
> -static const struct file_operations afu_master_fops = {
> -	.owner		= THIS_MODULE,
> -	.open           = afu_master_open,
> -	.poll		= afu_poll,
> -	.read		= afu_read,
> -	.release        = afu_release,
> -	.unlocked_ioctl = afu_ioctl,
> -	.compat_ioctl   = afu_compat_ioctl,
> -	.mmap           = afu_mmap,
> -};
> -
> -
> -static char *cxl_devnode(const struct device *dev, umode_t *mode)
> -{
> -	if (cpu_has_feature(CPU_FTR_HVMODE) &&
> -	    CXL_DEVT_IS_CARD(dev->devt)) {
> -		/*
> -		 * These minor numbers will eventually be used to program the
> -		 * PSL and AFUs once we have dynamic reprogramming support
> -		 */
> -		return NULL;
> -	}
> -	return kasprintf(GFP_KERNEL, "cxl/%s", dev_name(dev));
> -}
> -
> -static const struct class cxl_class = {
> -	.name =		"cxl",
> -	.devnode =	cxl_devnode,
> -};
> -
> -static int cxl_add_chardev(struct cxl_afu *afu, dev_t devt, struct cdev *cdev,
> -			   struct device **chardev, char *postfix, char *desc,
> -			   const struct file_operations *fops)
> -{
> -	struct device *dev;
> -	int rc;
> -
> -	cdev_init(cdev, fops);
> -	rc = cdev_add(cdev, devt, 1);
> -	if (rc) {
> -		dev_err(&afu->dev, "Unable to add %s chardev: %i\n", desc, rc);
> -		return rc;
> -	}
> -
> -	dev = device_create(&cxl_class, &afu->dev, devt, afu,
> -			"afu%i.%i%s", afu->adapter->adapter_num, afu->slice, postfix);
> -	if (IS_ERR(dev)) {
> -		rc = PTR_ERR(dev);
> -		dev_err(&afu->dev, "Unable to create %s chardev in sysfs: %i\n", desc, rc);
> -		goto err;
> -	}
> -
> -	*chardev = dev;
> -
> -	return 0;
> -err:
> -	cdev_del(cdev);
> -	return rc;
> -}
> -
> -int cxl_chardev_d_afu_add(struct cxl_afu *afu)
> -{
> -	return cxl_add_chardev(afu, CXL_AFU_MKDEV_D(afu), &afu->afu_cdev_d,
> -			       &afu->chardev_d, "d", "dedicated",
> -			       &afu_master_fops); /* Uses master fops */
> -}
> -
> -int cxl_chardev_m_afu_add(struct cxl_afu *afu)
> -{
> -	return cxl_add_chardev(afu, CXL_AFU_MKDEV_M(afu), &afu->afu_cdev_m,
> -			       &afu->chardev_m, "m", "master",
> -			       &afu_master_fops);
> -}
> -
> -int cxl_chardev_s_afu_add(struct cxl_afu *afu)
> -{
> -	return cxl_add_chardev(afu, CXL_AFU_MKDEV_S(afu), &afu->afu_cdev_s,
> -			       &afu->chardev_s, "s", "shared",
> -			       &afu_fops);
> -}
> -
> -void cxl_chardev_afu_remove(struct cxl_afu *afu)
> -{
> -	if (afu->chardev_d) {
> -		cdev_del(&afu->afu_cdev_d);
> -		device_unregister(afu->chardev_d);
> -		afu->chardev_d = NULL;
> -	}
> -	if (afu->chardev_m) {
> -		cdev_del(&afu->afu_cdev_m);
> -		device_unregister(afu->chardev_m);
> -		afu->chardev_m = NULL;
> -	}
> -	if (afu->chardev_s) {
> -		cdev_del(&afu->afu_cdev_s);
> -		device_unregister(afu->chardev_s);
> -		afu->chardev_s = NULL;
> -	}
> -}
> -
> -int cxl_register_afu(struct cxl_afu *afu)
> -{
> -	afu->dev.class = &cxl_class;
> -
> -	return device_register(&afu->dev);
> -}
> -
> -int cxl_register_adapter(struct cxl *adapter)
> -{
> -	adapter->dev.class = &cxl_class;
> -
> -	/*
> -	 * Future: When we support dynamically reprogramming the PSL & AFU we
> -	 * will expose the interface to do that via a chardev:
> -	 * adapter->dev.devt = CXL_CARD_MKDEV(adapter);
> -	 */
> -
> -	return device_register(&adapter->dev);
> -}
> -
> -dev_t cxl_get_dev(void)
> -{
> -	return cxl_dev;
> -}
> -
> -int __init cxl_file_init(void)
> -{
> -	int rc;
> -
> -	/*
> -	 * If these change we really need to update API.  Either change some
> -	 * flags or update API version number CXL_API_VERSION.
> -	 */
> -	BUILD_BUG_ON(CXL_API_VERSION != 3);
> -	BUILD_BUG_ON(sizeof(struct cxl_ioctl_start_work) != 64);
> -	BUILD_BUG_ON(sizeof(struct cxl_event_header) != 8);
> -	BUILD_BUG_ON(sizeof(struct cxl_event_afu_interrupt) != 8);
> -	BUILD_BUG_ON(sizeof(struct cxl_event_data_storage) != 32);
> -	BUILD_BUG_ON(sizeof(struct cxl_event_afu_error) != 16);
> -
> -	if ((rc = alloc_chrdev_region(&cxl_dev, 0, CXL_NUM_MINORS, "cxl"))) {
> -		pr_err("Unable to allocate CXL major number: %i\n", rc);
> -		return rc;
> -	}
> -
> -	pr_devel("CXL device allocated, MAJOR %i\n", MAJOR(cxl_dev));
> -
> -	rc = class_register(&cxl_class);
> -	if (rc) {
> -		pr_err("Unable to create CXL class\n");
> -		goto err;
> -	}
> -
> -	return 0;
> -
> -err:
> -	unregister_chrdev_region(cxl_dev, CXL_NUM_MINORS);
> -	return rc;
> -}
> -
> -void cxl_file_exit(void)
> -{
> -	unregister_chrdev_region(cxl_dev, CXL_NUM_MINORS);
> -	class_unregister(&cxl_class);
> -}
> diff --git a/drivers/misc/cxl/flash.c b/drivers/misc/cxl/flash.c
> deleted file mode 100644
> index eee9decc121e..000000000000
> --- a/drivers/misc/cxl/flash.c
> +++ /dev/null
> @@ -1,538 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <linux/kernel.h>
> -#include <linux/fs.h>
> -#include <linux/semaphore.h>
> -#include <linux/slab.h>
> -#include <linux/uaccess.h>
> -#include <linux/of.h>
> -#include <asm/rtas.h>
> -
> -#include "cxl.h"
> -#include "hcalls.h"
> -
> -#define DOWNLOAD_IMAGE 1
> -#define VALIDATE_IMAGE 2
> -
> -struct ai_header {
> -	u16 version;
> -	u8  reserved0[6];
> -	u16 vendor;
> -	u16 device;
> -	u16 subsystem_vendor;
> -	u16 subsystem;
> -	u64 image_offset;
> -	u64 image_length;
> -	u8  reserved1[96];
> -};
> -
> -static struct semaphore sem;
> -static unsigned long *buffer[CXL_AI_MAX_ENTRIES];
> -static struct sg_list *le;
> -static u64 continue_token;
> -static unsigned int transfer;
> -
> -struct update_props_workarea {
> -	__be32 phandle;
> -	__be32 state;
> -	__be64 reserved;
> -	__be32 nprops;
> -} __packed;
> -
> -struct update_nodes_workarea {
> -	__be32 state;
> -	__be64 unit_address;
> -	__be32 reserved;
> -} __packed;
> -
> -#define DEVICE_SCOPE 3
> -#define NODE_ACTION_MASK	0xff000000
> -#define NODE_COUNT_MASK		0x00ffffff
> -#define OPCODE_DELETE	0x01000000
> -#define OPCODE_UPDATE	0x02000000
> -#define OPCODE_ADD	0x03000000
> -
> -static int rcall(int token, char *buf, s32 scope)
> -{
> -	int rc;
> -
> -	spin_lock(&rtas_data_buf_lock);
> -
> -	memcpy(rtas_data_buf, buf, RTAS_DATA_BUF_SIZE);
> -	rc = rtas_call(token, 2, 1, NULL, rtas_data_buf, scope);
> -	memcpy(buf, rtas_data_buf, RTAS_DATA_BUF_SIZE);
> -
> -	spin_unlock(&rtas_data_buf_lock);
> -	return rc;
> -}
> -
> -static int update_property(struct device_node *dn, const char *name,
> -			   u32 vd, char *value)
> -{
> -	struct property *new_prop;
> -	u32 *val;
> -	int rc;
> -
> -	new_prop = kzalloc(sizeof(*new_prop), GFP_KERNEL);
> -	if (!new_prop)
> -		return -ENOMEM;
> -
> -	new_prop->name = kstrdup(name, GFP_KERNEL);
> -	if (!new_prop->name) {
> -		kfree(new_prop);
> -		return -ENOMEM;
> -	}
> -
> -	new_prop->length = vd;
> -	new_prop->value = kzalloc(new_prop->length, GFP_KERNEL);
> -	if (!new_prop->value) {
> -		kfree(new_prop->name);
> -		kfree(new_prop);
> -		return -ENOMEM;
> -	}
> -	memcpy(new_prop->value, value, vd);
> -
> -	val = (u32 *)new_prop->value;
> -	rc = cxl_update_properties(dn, new_prop);
> -	pr_devel("%pOFn: update property (%s, length: %i, value: %#x)\n",
> -		  dn, name, vd, be32_to_cpu(*val));
> -
> -	if (rc) {
> -		kfree(new_prop->name);
> -		kfree(new_prop->value);
> -		kfree(new_prop);
> -	}
> -	return rc;
> -}
> -
> -static int update_node(__be32 phandle, s32 scope)
> -{
> -	struct update_props_workarea *upwa;
> -	struct device_node *dn;
> -	int i, rc, ret;
> -	char *prop_data;
> -	char *buf;
> -	int token;
> -	u32 nprops;
> -	u32 vd;
> -
> -	token = rtas_token("ibm,update-properties");
> -	if (token == RTAS_UNKNOWN_SERVICE)
> -		return -EINVAL;
> -
> -	buf = kzalloc(RTAS_DATA_BUF_SIZE, GFP_KERNEL);
> -	if (!buf)
> -		return -ENOMEM;
> -
> -	dn = of_find_node_by_phandle(be32_to_cpu(phandle));
> -	if (!dn) {
> -		kfree(buf);
> -		return -ENOENT;
> -	}
> -
> -	upwa = (struct update_props_workarea *)&buf[0];
> -	upwa->phandle = phandle;
> -	do {
> -		rc = rcall(token, buf, scope);
> -		if (rc < 0)
> -			break;
> -
> -		prop_data = buf + sizeof(*upwa);
> -		nprops = be32_to_cpu(upwa->nprops);
> -
> -		if (*prop_data == 0) {
> -			prop_data++;
> -			vd = be32_to_cpu(*(__be32 *)prop_data);
> -			prop_data += vd + sizeof(vd);
> -			nprops--;
> -		}
> -
> -		for (i = 0; i < nprops; i++) {
> -			char *prop_name;
> -
> -			prop_name = prop_data;
> -			prop_data += strlen(prop_name) + 1;
> -			vd = be32_to_cpu(*(__be32 *)prop_data);
> -			prop_data += sizeof(vd);
> -
> -			if ((vd != 0x00000000) && (vd != 0x80000000)) {
> -				ret = update_property(dn, prop_name, vd,
> -						prop_data);
> -				if (ret)
> -					pr_err("cxl: Could not update property %s - %i\n",
> -					       prop_name, ret);
> -
> -				prop_data += vd;
> -			}
> -		}
> -	} while (rc == 1);
> -
> -	of_node_put(dn);
> -	kfree(buf);
> -	return rc;
> -}
> -
> -static int update_devicetree(struct cxl *adapter, s32 scope)
> -{
> -	struct update_nodes_workarea *unwa;
> -	u32 action, node_count;
> -	int token, rc, i;
> -	__be32 *data, phandle;
> -	char *buf;
> -
> -	token = rtas_token("ibm,update-nodes");
> -	if (token == RTAS_UNKNOWN_SERVICE)
> -		return -EINVAL;
> -
> -	buf = kzalloc(RTAS_DATA_BUF_SIZE, GFP_KERNEL);
> -	if (!buf)
> -		return -ENOMEM;
> -
> -	unwa = (struct update_nodes_workarea *)&buf[0];
> -	unwa->unit_address = cpu_to_be64(adapter->guest->handle);
> -	do {
> -		rc = rcall(token, buf, scope);
> -		if (rc && rc != 1)
> -			break;
> -
> -		data = (__be32 *)buf + 4;
> -		while (be32_to_cpu(*data) & NODE_ACTION_MASK) {
> -			action = be32_to_cpu(*data) & NODE_ACTION_MASK;
> -			node_count = be32_to_cpu(*data) & NODE_COUNT_MASK;
> -			pr_devel("device reconfiguration - action: %#x, nodes: %#x\n",
> -				 action, node_count);
> -			data++;
> -
> -			for (i = 0; i < node_count; i++) {
> -				phandle = *data++;
> -
> -				switch (action) {
> -				case OPCODE_DELETE:
> -					/* nothing to do */
> -					break;
> -				case OPCODE_UPDATE:
> -					update_node(phandle, scope);
> -					break;
> -				case OPCODE_ADD:
> -					/* nothing to do, just move pointer */
> -					data++;
> -					break;
> -				}
> -			}
> -		}
> -	} while (rc == 1);
> -
> -	kfree(buf);
> -	return 0;
> -}
> -
> -static int handle_image(struct cxl *adapter, int operation,
> -			long (*fct)(u64, u64, u64, u64 *),
> -			struct cxl_adapter_image *ai)
> -{
> -	size_t mod, s_copy, len_chunk = 0;
> -	struct ai_header *header = NULL;
> -	unsigned int entries = 0, i;
> -	void *dest, *from;
> -	int rc = 0, need_header;
> -
> -	/* base adapter image header */
> -	need_header = (ai->flags & CXL_AI_NEED_HEADER);
> -	if (need_header) {
> -		header = kzalloc(sizeof(struct ai_header), GFP_KERNEL);
> -		if (!header)
> -			return -ENOMEM;
> -		header->version = cpu_to_be16(1);
> -		header->vendor = cpu_to_be16(adapter->guest->vendor);
> -		header->device = cpu_to_be16(adapter->guest->device);
> -		header->subsystem_vendor = cpu_to_be16(adapter->guest->subsystem_vendor);
> -		header->subsystem = cpu_to_be16(adapter->guest->subsystem);
> -		header->image_offset = cpu_to_be64(CXL_AI_HEADER_SIZE);
> -		header->image_length = cpu_to_be64(ai->len_image);
> -	}
> -
> -	/* number of entries in the list */
> -	len_chunk = ai->len_data;
> -	if (need_header)
> -		len_chunk += CXL_AI_HEADER_SIZE;
> -
> -	entries = len_chunk / CXL_AI_BUFFER_SIZE;
> -	mod = len_chunk % CXL_AI_BUFFER_SIZE;
> -	if (mod)
> -		entries++;
> -
> -	if (entries > CXL_AI_MAX_ENTRIES) {
> -		rc = -EINVAL;
> -		goto err;
> -	}
> -
> -	/*          < -- MAX_CHUNK_SIZE = 4096 * 256 = 1048576 bytes -->
> -	 * chunk 0  ----------------------------------------------------
> -	 *          | header   |  data                                 |
> -	 *          ----------------------------------------------------
> -	 * chunk 1  ----------------------------------------------------
> -	 *          | data                                             |
> -	 *          ----------------------------------------------------
> -	 * ....
> -	 * chunk n  ----------------------------------------------------
> -	 *          | data                                             |
> -	 *          ----------------------------------------------------
> -	 */
> -	from = (void *) ai->data;
> -	for (i = 0; i < entries; i++) {
> -		dest = buffer[i];
> -		s_copy = CXL_AI_BUFFER_SIZE;
> -
> -		if ((need_header) && (i == 0)) {
> -			/* add adapter image header */
> -			memcpy(buffer[i], header, sizeof(struct ai_header));
> -			s_copy = CXL_AI_BUFFER_SIZE - CXL_AI_HEADER_SIZE;
> -			dest += CXL_AI_HEADER_SIZE; /* image offset */
> -		}
> -		if ((i == (entries - 1)) && mod)
> -			s_copy = mod;
> -
> -		/* copy data */
> -		if (copy_from_user(dest, from, s_copy))
> -			goto err;
> -
> -		/* fill in the list */
> -		le[i].phys_addr = cpu_to_be64(virt_to_phys(buffer[i]));
> -		le[i].len = cpu_to_be64(CXL_AI_BUFFER_SIZE);
> -		if ((i == (entries - 1)) && mod)
> -			le[i].len = cpu_to_be64(mod);
> -		from += s_copy;
> -	}
> -	pr_devel("%s (op: %i, need header: %i, entries: %i, token: %#llx)\n",
> -		 __func__, operation, need_header, entries, continue_token);
> -
> -	/*
> -	 * download/validate the adapter image to the coherent
> -	 * platform facility
> -	 */
> -	rc = fct(adapter->guest->handle, virt_to_phys(le), entries,
> -		&continue_token);
> -	if (rc == 0) /* success of download/validation operation */
> -		continue_token = 0;
> -
> -err:
> -	kfree(header);
> -
> -	return rc;
> -}
> -
> -static int transfer_image(struct cxl *adapter, int operation,
> -			struct cxl_adapter_image *ai)
> -{
> -	int rc = 0;
> -	int afu;
> -
> -	switch (operation) {
> -	case DOWNLOAD_IMAGE:
> -		rc = handle_image(adapter, operation,
> -				&cxl_h_download_adapter_image, ai);
> -		if (rc < 0) {
> -			pr_devel("resetting adapter\n");
> -			cxl_h_reset_adapter(adapter->guest->handle);
> -		}
> -		return rc;
> -
> -	case VALIDATE_IMAGE:
> -		rc = handle_image(adapter, operation,
> -				&cxl_h_validate_adapter_image, ai);
> -		if (rc < 0) {
> -			pr_devel("resetting adapter\n");
> -			cxl_h_reset_adapter(adapter->guest->handle);
> -			return rc;
> -		}
> -		if (rc == 0) {
> -			pr_devel("remove current afu\n");
> -			for (afu = 0; afu < adapter->slices; afu++)
> -				cxl_guest_remove_afu(adapter->afu[afu]);
> -
> -			pr_devel("resetting adapter\n");
> -			cxl_h_reset_adapter(adapter->guest->handle);
> -
> -			/* The entire image has now been
> -			 * downloaded and the validation has
> -			 * been successfully performed.
> -			 * After that, the partition should call
> -			 * ibm,update-nodes and
> -			 * ibm,update-properties to receive the
> -			 * current configuration
> -			 */
> -			rc = update_devicetree(adapter, DEVICE_SCOPE);
> -			transfer = 1;
> -		}
> -		return rc;
> -	}
> -
> -	return -EINVAL;
> -}
> -
> -static long ioctl_transfer_image(struct cxl *adapter, int operation,
> -				struct cxl_adapter_image __user *uai)
> -{
> -	struct cxl_adapter_image ai;
> -
> -	pr_devel("%s\n", __func__);
> -
> -	if (copy_from_user(&ai, uai, sizeof(struct cxl_adapter_image)))
> -		return -EFAULT;
> -
> -	/*
> -	 * Make sure reserved fields and bits are set to 0
> -	 */
> -	if (ai.reserved1 || ai.reserved2 || ai.reserved3 || ai.reserved4 ||
> -		(ai.flags & ~CXL_AI_ALL))
> -		return -EINVAL;
> -
> -	return transfer_image(adapter, operation, &ai);
> -}
> -
> -static int device_open(struct inode *inode, struct file *file)
> -{
> -	int adapter_num = CXL_DEVT_ADAPTER(inode->i_rdev);
> -	struct cxl *adapter;
> -	int rc = 0, i;
> -
> -	pr_devel("in %s\n", __func__);
> -
> -	BUG_ON(sizeof(struct ai_header) != CXL_AI_HEADER_SIZE);
> -
> -	/* Allows one process to open the device by using a semaphore */
> -	if (down_interruptible(&sem) != 0)
> -		return -EPERM;
> -
> -	if (!(adapter = get_cxl_adapter(adapter_num))) {
> -		rc = -ENODEV;
> -		goto err_unlock;
> -	}
> -
> -	file->private_data = adapter;
> -	continue_token = 0;
> -	transfer = 0;
> -
> -	for (i = 0; i < CXL_AI_MAX_ENTRIES; i++)
> -		buffer[i] = NULL;
> -
> -	/* aligned buffer containing list entries which describes up to
> -	 * 1 megabyte of data (256 entries of 4096 bytes each)
> -	 *  Logical real address of buffer 0  -  Buffer 0 length in bytes
> -	 *  Logical real address of buffer 1  -  Buffer 1 length in bytes
> -	 *  Logical real address of buffer 2  -  Buffer 2 length in bytes
> -	 *  ....
> -	 *  ....
> -	 *  Logical real address of buffer N  -  Buffer N length in bytes
> -	 */
> -	le = (struct sg_list *)get_zeroed_page(GFP_KERNEL);
> -	if (!le) {
> -		rc = -ENOMEM;
> -		goto err;
> -	}
> -
> -	for (i = 0; i < CXL_AI_MAX_ENTRIES; i++) {
> -		buffer[i] = (unsigned long *)get_zeroed_page(GFP_KERNEL);
> -		if (!buffer[i]) {
> -			rc = -ENOMEM;
> -			goto err1;
> -		}
> -	}
> -
> -	return 0;
> -
> -err1:
> -	for (i = 0; i < CXL_AI_MAX_ENTRIES; i++) {
> -		if (buffer[i])
> -			free_page((unsigned long) buffer[i]);
> -	}
> -
> -	if (le)
> -		free_page((unsigned long) le);
> -err:
> -	put_device(&adapter->dev);
> -err_unlock:
> -	up(&sem);
> -
> -	return rc;
> -}
> -
> -static long device_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> -{
> -	struct cxl *adapter = file->private_data;
> -
> -	pr_devel("in %s\n", __func__);
> -
> -	if (cmd == CXL_IOCTL_DOWNLOAD_IMAGE)
> -		return ioctl_transfer_image(adapter,
> -					DOWNLOAD_IMAGE,
> -					(struct cxl_adapter_image __user *)arg);
> -	else if (cmd == CXL_IOCTL_VALIDATE_IMAGE)
> -		return ioctl_transfer_image(adapter,
> -					VALIDATE_IMAGE,
> -					(struct cxl_adapter_image __user *)arg);
> -	else
> -		return -EINVAL;
> -}
> -
> -static int device_close(struct inode *inode, struct file *file)
> -{
> -	struct cxl *adapter = file->private_data;
> -	int i;
> -
> -	pr_devel("in %s\n", __func__);
> -
> -	for (i = 0; i < CXL_AI_MAX_ENTRIES; i++) {
> -		if (buffer[i])
> -			free_page((unsigned long) buffer[i]);
> -	}
> -
> -	if (le)
> -		free_page((unsigned long) le);
> -
> -	up(&sem);
> -	put_device(&adapter->dev);
> -	continue_token = 0;
> -
> -	/* reload the module */
> -	if (transfer)
> -		cxl_guest_reload_module(adapter);
> -	else {
> -		pr_devel("resetting adapter\n");
> -		cxl_h_reset_adapter(adapter->guest->handle);
> -	}
> -
> -	transfer = 0;
> -	return 0;
> -}
> -
> -static const struct file_operations fops = {
> -	.owner		= THIS_MODULE,
> -	.open		= device_open,
> -	.unlocked_ioctl	= device_ioctl,
> -	.compat_ioctl	= compat_ptr_ioctl,
> -	.release	= device_close,
> -};
> -
> -void cxl_guest_remove_chardev(struct cxl *adapter)
> -{
> -	cdev_del(&adapter->guest->cdev);
> -}
> -
> -int cxl_guest_add_chardev(struct cxl *adapter)
> -{
> -	dev_t devt;
> -	int rc;
> -
> -	devt = MKDEV(MAJOR(cxl_get_dev()), CXL_CARD_MINOR(adapter));
> -	cdev_init(&adapter->guest->cdev, &fops);
> -	if ((rc = cdev_add(&adapter->guest->cdev, devt, 1))) {
> -		dev_err(&adapter->dev,
> -			"Unable to add chardev on adapter (card%i): %i\n",
> -			adapter->adapter_num, rc);
> -		goto err;
> -	}
> -	adapter->dev.devt = devt;
> -	sema_init(&sem, 1);
> -err:
> -	return rc;
> -}
> diff --git a/drivers/misc/cxl/guest.c b/drivers/misc/cxl/guest.c
> deleted file mode 100644
> index fb95a2d5cef4..000000000000
> --- a/drivers/misc/cxl/guest.c
> +++ /dev/null
> @@ -1,1208 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * Copyright 2015 IBM Corp.
> - */
> -
> -#include <linux/spinlock.h>
> -#include <linux/uaccess.h>
> -#include <linux/delay.h>
> -#include <linux/irqdomain.h>
> -#include <linux/platform_device.h>
> -
> -#include "cxl.h"
> -#include "hcalls.h"
> -#include "trace.h"
> -
> -#define CXL_ERROR_DETECTED_EVENT	1
> -#define CXL_SLOT_RESET_EVENT		2
> -#define CXL_RESUME_EVENT		3
> -
> -static void pci_error_handlers(struct cxl_afu *afu,
> -				int bus_error_event,
> -				pci_channel_state_t state)
> -{
> -	struct pci_dev *afu_dev;
> -	struct pci_driver *afu_drv;
> -	const struct pci_error_handlers *err_handler;
> -
> -	if (afu->phb == NULL)
> -		return;
> -
> -	list_for_each_entry(afu_dev, &afu->phb->bus->devices, bus_list) {
> -		afu_drv = to_pci_driver(afu_dev->dev.driver);
> -		if (!afu_drv)
> -			continue;
> -
> -		err_handler = afu_drv->err_handler;
> -		switch (bus_error_event) {
> -		case CXL_ERROR_DETECTED_EVENT:
> -			afu_dev->error_state = state;
> -
> -			if (err_handler &&
> -			    err_handler->error_detected)
> -				err_handler->error_detected(afu_dev, state);
> -			break;
> -		case CXL_SLOT_RESET_EVENT:
> -			afu_dev->error_state = state;
> -
> -			if (err_handler &&
> -			    err_handler->slot_reset)
> -				err_handler->slot_reset(afu_dev);
> -			break;
> -		case CXL_RESUME_EVENT:
> -			if (err_handler &&
> -			    err_handler->resume)
> -				err_handler->resume(afu_dev);
> -			break;
> -		}
> -	}
> -}
> -
> -static irqreturn_t guest_handle_psl_slice_error(struct cxl_context *ctx, u64 dsisr,
> -					u64 errstat)
> -{
> -	pr_devel("in %s\n", __func__);
> -	dev_crit(&ctx->afu->dev, "PSL ERROR STATUS: 0x%.16llx\n", errstat);
> -
> -	return cxl_ops->ack_irq(ctx, 0, errstat);
> -}
> -
> -static ssize_t guest_collect_vpd(struct cxl *adapter, struct cxl_afu *afu,
> -			void *buf, size_t len)
> -{
> -	unsigned int entries, mod;
> -	unsigned long **vpd_buf = NULL;
> -	struct sg_list *le;
> -	int rc = 0, i, tocopy;
> -	u64 out = 0;
> -
> -	if (buf == NULL)
> -		return -EINVAL;
> -
> -	/* number of entries in the list */
> -	entries = len / SG_BUFFER_SIZE;
> -	mod = len % SG_BUFFER_SIZE;
> -	if (mod)
> -		entries++;
> -
> -	if (entries > SG_MAX_ENTRIES) {
> -		entries = SG_MAX_ENTRIES;
> -		len = SG_MAX_ENTRIES * SG_BUFFER_SIZE;
> -		mod = 0;
> -	}
> -
> -	vpd_buf = kcalloc(entries, sizeof(unsigned long *), GFP_KERNEL);
> -	if (!vpd_buf)
> -		return -ENOMEM;
> -
> -	le = (struct sg_list *)get_zeroed_page(GFP_KERNEL);
> -	if (!le) {
> -		rc = -ENOMEM;
> -		goto err1;
> -	}
> -
> -	for (i = 0; i < entries; i++) {
> -		vpd_buf[i] = (unsigned long *)get_zeroed_page(GFP_KERNEL);
> -		if (!vpd_buf[i]) {
> -			rc = -ENOMEM;
> -			goto err2;
> -		}
> -		le[i].phys_addr = cpu_to_be64(virt_to_phys(vpd_buf[i]));
> -		le[i].len = cpu_to_be64(SG_BUFFER_SIZE);
> -		if ((i == (entries - 1)) && mod)
> -			le[i].len = cpu_to_be64(mod);
> -	}
> -
> -	if (adapter)
> -		rc = cxl_h_collect_vpd_adapter(adapter->guest->handle,
> -					virt_to_phys(le), entries, &out);
> -	else
> -		rc = cxl_h_collect_vpd(afu->guest->handle, 0,
> -				virt_to_phys(le), entries, &out);
> -	pr_devel("length of available (entries: %i), vpd: %#llx\n",
> -		entries, out);
> -
> -	if (!rc) {
> -		/*
> -		 * hcall returns in 'out' the size of available VPDs.
> -		 * It fills the buffer with as much data as possible.
> -		 */
> -		if (out < len)
> -			len = out;
> -		rc = len;
> -		if (out) {
> -			for (i = 0; i < entries; i++) {
> -				if (len < SG_BUFFER_SIZE)
> -					tocopy = len;
> -				else
> -					tocopy = SG_BUFFER_SIZE;
> -				memcpy(buf, vpd_buf[i], tocopy);
> -				buf += tocopy;
> -				len -= tocopy;
> -			}
> -		}
> -	}
> -err2:
> -	for (i = 0; i < entries; i++) {
> -		if (vpd_buf[i])
> -			free_page((unsigned long) vpd_buf[i]);
> -	}
> -	free_page((unsigned long) le);
> -err1:
> -	kfree(vpd_buf);
> -	return rc;
> -}
> -
> -static int guest_get_irq_info(struct cxl_context *ctx, struct cxl_irq_info *info)
> -{
> -	return cxl_h_collect_int_info(ctx->afu->guest->handle, ctx->process_token, info);
> -}
> -
> -static irqreturn_t guest_psl_irq(int irq, void *data)
> -{
> -	struct cxl_context *ctx = data;
> -	struct cxl_irq_info irq_info;
> -	int rc;
> -
> -	pr_devel("%d: received PSL interrupt %i\n", ctx->pe, irq);
> -	rc = guest_get_irq_info(ctx, &irq_info);
> -	if (rc) {
> -		WARN(1, "Unable to get IRQ info: %i\n", rc);
> -		return IRQ_HANDLED;
> -	}
> -
> -	rc = cxl_irq_psl8(irq, ctx, &irq_info);
> -	return rc;
> -}
> -
> -static int afu_read_error_state(struct cxl_afu *afu, int *state_out)
> -{
> -	u64 state;
> -	int rc = 0;
> -
> -	if (!afu)
> -		return -EIO;
> -
> -	rc = cxl_h_read_error_state(afu->guest->handle, &state);
> -	if (!rc) {
> -		WARN_ON(state != H_STATE_NORMAL &&
> -			state != H_STATE_DISABLE &&
> -			state != H_STATE_TEMP_UNAVAILABLE &&
> -			state != H_STATE_PERM_UNAVAILABLE);
> -		*state_out = state & 0xffffffff;
> -	}
> -	return rc;
> -}
> -
> -static irqreturn_t guest_slice_irq_err(int irq, void *data)
> -{
> -	struct cxl_afu *afu = data;
> -	int rc;
> -	u64 serr, afu_error, dsisr;
> -
> -	rc = cxl_h_get_fn_error_interrupt(afu->guest->handle, &serr);
> -	if (rc) {
> -		dev_crit(&afu->dev, "Couldn't read PSL_SERR_An: %d\n", rc);
> -		return IRQ_HANDLED;
> -	}
> -	afu_error = cxl_p2n_read(afu, CXL_AFU_ERR_An);
> -	dsisr = cxl_p2n_read(afu, CXL_PSL_DSISR_An);
> -	cxl_afu_decode_psl_serr(afu, serr);
> -	dev_crit(&afu->dev, "AFU_ERR_An: 0x%.16llx\n", afu_error);
> -	dev_crit(&afu->dev, "PSL_DSISR_An: 0x%.16llx\n", dsisr);
> -
> -	rc = cxl_h_ack_fn_error_interrupt(afu->guest->handle, serr);
> -	if (rc)
> -		dev_crit(&afu->dev, "Couldn't ack slice error interrupt: %d\n",
> -			rc);
> -
> -	return IRQ_HANDLED;
> -}
> -
> -
> -static int irq_alloc_range(struct cxl *adapter, int len, int *irq)
> -{
> -	int i, n;
> -	struct irq_avail *cur;
> -
> -	for (i = 0; i < adapter->guest->irq_nranges; i++) {
> -		cur = &adapter->guest->irq_avail[i];
> -		n = bitmap_find_next_zero_area(cur->bitmap, cur->range,
> -					0, len, 0);
> -		if (n < cur->range) {
> -			bitmap_set(cur->bitmap, n, len);
> -			*irq = cur->offset + n;
> -			pr_devel("guest: allocate IRQs %#x->%#x\n",
> -				*irq, *irq + len - 1);
> -
> -			return 0;
> -		}
> -	}
> -	return -ENOSPC;
> -}
> -
> -static int irq_free_range(struct cxl *adapter, int irq, int len)
> -{
> -	int i, n;
> -	struct irq_avail *cur;
> -
> -	if (len == 0)
> -		return -ENOENT;
> -
> -	for (i = 0; i < adapter->guest->irq_nranges; i++) {
> -		cur = &adapter->guest->irq_avail[i];
> -		if (irq >= cur->offset &&
> -			(irq + len) <= (cur->offset + cur->range)) {
> -			n = irq - cur->offset;
> -			bitmap_clear(cur->bitmap, n, len);
> -			pr_devel("guest: release IRQs %#x->%#x\n",
> -				irq, irq + len - 1);
> -			return 0;
> -		}
> -	}
> -	return -ENOENT;
> -}
> -
> -static int guest_reset(struct cxl *adapter)
> -{
> -	struct cxl_afu *afu = NULL;
> -	int i, rc;
> -
> -	pr_devel("Adapter reset request\n");
> -	spin_lock(&adapter->afu_list_lock);
> -	for (i = 0; i < adapter->slices; i++) {
> -		if ((afu = adapter->afu[i])) {
> -			pci_error_handlers(afu, CXL_ERROR_DETECTED_EVENT,
> -					pci_channel_io_frozen);
> -			cxl_context_detach_all(afu);
> -		}
> -	}
> -
> -	rc = cxl_h_reset_adapter(adapter->guest->handle);
> -	for (i = 0; i < adapter->slices; i++) {
> -		if (!rc && (afu = adapter->afu[i])) {
> -			pci_error_handlers(afu, CXL_SLOT_RESET_EVENT,
> -					pci_channel_io_normal);
> -			pci_error_handlers(afu, CXL_RESUME_EVENT, 0);
> -		}
> -	}
> -	spin_unlock(&adapter->afu_list_lock);
> -	return rc;
> -}
> -
> -static int guest_alloc_one_irq(struct cxl *adapter)
> -{
> -	int irq;
> -
> -	spin_lock(&adapter->guest->irq_alloc_lock);
> -	if (irq_alloc_range(adapter, 1, &irq))
> -		irq = -ENOSPC;
> -	spin_unlock(&adapter->guest->irq_alloc_lock);
> -	return irq;
> -}
> -
> -static void guest_release_one_irq(struct cxl *adapter, int irq)
> -{
> -	spin_lock(&adapter->guest->irq_alloc_lock);
> -	irq_free_range(adapter, irq, 1);
> -	spin_unlock(&adapter->guest->irq_alloc_lock);
> -}
> -
> -static int guest_alloc_irq_ranges(struct cxl_irq_ranges *irqs,
> -				struct cxl *adapter, unsigned int num)
> -{
> -	int i, try, irq;
> -
> -	memset(irqs, 0, sizeof(struct cxl_irq_ranges));
> -
> -	spin_lock(&adapter->guest->irq_alloc_lock);
> -	for (i = 0; i < CXL_IRQ_RANGES && num; i++) {
> -		try = num;
> -		while (try) {
> -			if (irq_alloc_range(adapter, try, &irq) == 0)
> -				break;
> -			try /= 2;
> -		}
> -		if (!try)
> -			goto error;
> -		irqs->offset[i] = irq;
> -		irqs->range[i] = try;
> -		num -= try;
> -	}
> -	if (num)
> -		goto error;
> -	spin_unlock(&adapter->guest->irq_alloc_lock);
> -	return 0;
> -
> -error:
> -	for (i = 0; i < CXL_IRQ_RANGES; i++)
> -		irq_free_range(adapter, irqs->offset[i], irqs->range[i]);
> -	spin_unlock(&adapter->guest->irq_alloc_lock);
> -	return -ENOSPC;
> -}
> -
> -static void guest_release_irq_ranges(struct cxl_irq_ranges *irqs,
> -				struct cxl *adapter)
> -{
> -	int i;
> -
> -	spin_lock(&adapter->guest->irq_alloc_lock);
> -	for (i = 0; i < CXL_IRQ_RANGES; i++)
> -		irq_free_range(adapter, irqs->offset[i], irqs->range[i]);
> -	spin_unlock(&adapter->guest->irq_alloc_lock);
> -}
> -
> -static int guest_register_serr_irq(struct cxl_afu *afu)
> -{
> -	afu->err_irq_name = kasprintf(GFP_KERNEL, "cxl-%s-err",
> -				      dev_name(&afu->dev));
> -	if (!afu->err_irq_name)
> -		return -ENOMEM;
> -
> -	if (!(afu->serr_virq = cxl_map_irq(afu->adapter, afu->serr_hwirq,
> -				 guest_slice_irq_err, afu, afu->err_irq_name))) {
> -		kfree(afu->err_irq_name);
> -		afu->err_irq_name = NULL;
> -		return -ENOMEM;
> -	}
> -
> -	return 0;
> -}
> -
> -static void guest_release_serr_irq(struct cxl_afu *afu)
> -{
> -	cxl_unmap_irq(afu->serr_virq, afu);
> -	cxl_ops->release_one_irq(afu->adapter, afu->serr_hwirq);
> -	kfree(afu->err_irq_name);
> -}
> -
> -static int guest_ack_irq(struct cxl_context *ctx, u64 tfc, u64 psl_reset_mask)
> -{
> -	return cxl_h_control_faults(ctx->afu->guest->handle, ctx->process_token,
> -				tfc >> 32, (psl_reset_mask != 0));
> -}
> -
> -static void disable_afu_irqs(struct cxl_context *ctx)
> -{
> -	irq_hw_number_t hwirq;
> -	unsigned int virq;
> -	int r, i;
> -
> -	pr_devel("Disabling AFU(%d) interrupts\n", ctx->afu->slice);
> -	for (r = 0; r < CXL_IRQ_RANGES; r++) {
> -		hwirq = ctx->irqs.offset[r];
> -		for (i = 0; i < ctx->irqs.range[r]; hwirq++, i++) {
> -			virq = irq_find_mapping(NULL, hwirq);
> -			disable_irq(virq);
> -		}
> -	}
> -}
> -
> -static void enable_afu_irqs(struct cxl_context *ctx)
> -{
> -	irq_hw_number_t hwirq;
> -	unsigned int virq;
> -	int r, i;
> -
> -	pr_devel("Enabling AFU(%d) interrupts\n", ctx->afu->slice);
> -	for (r = 0; r < CXL_IRQ_RANGES; r++) {
> -		hwirq = ctx->irqs.offset[r];
> -		for (i = 0; i < ctx->irqs.range[r]; hwirq++, i++) {
> -			virq = irq_find_mapping(NULL, hwirq);
> -			enable_irq(virq);
> -		}
> -	}
> -}
> -
> -static int _guest_afu_cr_readXX(int sz, struct cxl_afu *afu, int cr_idx,
> -			u64 offset, u64 *val)
> -{
> -	unsigned long cr;
> -	char c;
> -	int rc = 0;
> -
> -	if (afu->crs_len < sz)
> -		return -ENOENT;
> -
> -	if (unlikely(offset >= afu->crs_len))
> -		return -ERANGE;
> -
> -	cr = get_zeroed_page(GFP_KERNEL);
> -	if (!cr)
> -		return -ENOMEM;
> -
> -	rc = cxl_h_get_config(afu->guest->handle, cr_idx, offset,
> -			virt_to_phys((void *)cr), sz);
> -	if (rc)
> -		goto err;
> -
> -	switch (sz) {
> -	case 1:
> -		c = *((char *) cr);
> -		*val = c;
> -		break;
> -	case 2:
> -		*val = in_le16((u16 *)cr);
> -		break;
> -	case 4:
> -		*val = in_le32((unsigned *)cr);
> -		break;
> -	case 8:
> -		*val = in_le64((u64 *)cr);
> -		break;
> -	default:
> -		WARN_ON(1);
> -	}
> -err:
> -	free_page(cr);
> -	return rc;
> -}
> -
> -static int guest_afu_cr_read32(struct cxl_afu *afu, int cr_idx, u64 offset,
> -			u32 *out)
> -{
> -	int rc;
> -	u64 val;
> -
> -	rc = _guest_afu_cr_readXX(4, afu, cr_idx, offset, &val);
> -	if (!rc)
> -		*out = (u32) val;
> -	return rc;
> -}
> -
> -static int guest_afu_cr_read16(struct cxl_afu *afu, int cr_idx, u64 offset,
> -			u16 *out)
> -{
> -	int rc;
> -	u64 val;
> -
> -	rc = _guest_afu_cr_readXX(2, afu, cr_idx, offset, &val);
> -	if (!rc)
> -		*out = (u16) val;
> -	return rc;
> -}
> -
> -static int guest_afu_cr_read8(struct cxl_afu *afu, int cr_idx, u64 offset,
> -			u8 *out)
> -{
> -	int rc;
> -	u64 val;
> -
> -	rc = _guest_afu_cr_readXX(1, afu, cr_idx, offset, &val);
> -	if (!rc)
> -		*out = (u8) val;
> -	return rc;
> -}
> -
> -static int guest_afu_cr_read64(struct cxl_afu *afu, int cr_idx, u64 offset,
> -			u64 *out)
> -{
> -	return _guest_afu_cr_readXX(8, afu, cr_idx, offset, out);
> -}
> -
> -static int guest_afu_cr_write32(struct cxl_afu *afu, int cr, u64 off, u32 in)
> -{
> -	/* config record is not writable from guest */
> -	return -EPERM;
> -}
> -
> -static int guest_afu_cr_write16(struct cxl_afu *afu, int cr, u64 off, u16 in)
> -{
> -	/* config record is not writable from guest */
> -	return -EPERM;
> -}
> -
> -static int guest_afu_cr_write8(struct cxl_afu *afu, int cr, u64 off, u8 in)
> -{
> -	/* config record is not writable from guest */
> -	return -EPERM;
> -}
> -
> -static int attach_afu_directed(struct cxl_context *ctx, u64 wed, u64 amr)
> -{
> -	struct cxl_process_element_hcall *elem;
> -	struct cxl *adapter = ctx->afu->adapter;
> -	const struct cred *cred;
> -	u32 pid, idx;
> -	int rc, r, i;
> -	u64 mmio_addr, mmio_size;
> -	__be64 flags = 0;
> -
> -	/* Must be 8 byte aligned and cannot cross a 4096 byte boundary */
> -	if (!(elem = (struct cxl_process_element_hcall *)
> -			get_zeroed_page(GFP_KERNEL)))
> -		return -ENOMEM;
> -
> -	elem->version = cpu_to_be64(CXL_PROCESS_ELEMENT_VERSION);
> -	if (ctx->kernel) {
> -		pid = 0;
> -		flags |= CXL_PE_TRANSLATION_ENABLED;
> -		flags |= CXL_PE_PRIVILEGED_PROCESS;
> -		if (mfmsr() & MSR_SF)
> -			flags |= CXL_PE_64_BIT;
> -	} else {
> -		pid = current->pid;
> -		flags |= CXL_PE_PROBLEM_STATE;
> -		flags |= CXL_PE_TRANSLATION_ENABLED;
> -		if (!test_tsk_thread_flag(current, TIF_32BIT))
> -			flags |= CXL_PE_64_BIT;
> -		cred = get_current_cred();
> -		if (uid_eq(cred->euid, GLOBAL_ROOT_UID))
> -			flags |= CXL_PE_PRIVILEGED_PROCESS;
> -		put_cred(cred);
> -	}
> -	elem->flags         = cpu_to_be64(flags);
> -	elem->common.tid    = cpu_to_be32(0); /* Unused */
> -	elem->common.pid    = cpu_to_be32(pid);
> -	elem->common.csrp   = cpu_to_be64(0); /* disable */
> -	elem->common.u.psl8.aurp0  = cpu_to_be64(0); /* disable */
> -	elem->common.u.psl8.aurp1  = cpu_to_be64(0); /* disable */
> -
> -	cxl_prefault(ctx, wed);
> -
> -	elem->common.u.psl8.sstp0  = cpu_to_be64(ctx->sstp0);
> -	elem->common.u.psl8.sstp1  = cpu_to_be64(ctx->sstp1);
> -
> -	/*
> -	 * Ensure we have at least one interrupt allocated to take faults for
> -	 * kernel contexts that may not have allocated any AFU IRQs at all:
> -	 */
> -	if (ctx->irqs.range[0] == 0) {
> -		rc = afu_register_irqs(ctx, 0);
> -		if (rc)
> -			goto out_free;
> -	}
> -
> -	for (r = 0; r < CXL_IRQ_RANGES; r++) {
> -		for (i = 0; i < ctx->irqs.range[r]; i++) {
> -			if (r == 0 && i == 0) {
> -				elem->pslVirtualIsn = cpu_to_be32(ctx->irqs.offset[0]);
> -			} else {
> -				idx = ctx->irqs.offset[r] + i - adapter->guest->irq_base_offset;
> -				elem->applicationVirtualIsnBitmap[idx / 8] |= 0x80 >> (idx % 8);
> -			}
> -		}
> -	}
> -	elem->common.amr = cpu_to_be64(amr);
> -	elem->common.wed = cpu_to_be64(wed);
> -
> -	disable_afu_irqs(ctx);
> -
> -	rc = cxl_h_attach_process(ctx->afu->guest->handle, elem,
> -				&ctx->process_token, &mmio_addr, &mmio_size);
> -	if (rc == H_SUCCESS) {
> -		if (ctx->master || !ctx->afu->pp_psa) {
> -			ctx->psn_phys = ctx->afu->psn_phys;
> -			ctx->psn_size = ctx->afu->adapter->ps_size;
> -		} else {
> -			ctx->psn_phys = mmio_addr;
> -			ctx->psn_size = mmio_size;
> -		}
> -		if (ctx->afu->pp_psa && mmio_size &&
> -			ctx->afu->pp_size == 0) {
> -			/*
> -			 * There's no property in the device tree to read the
> -			 * pp_size. We only find out at the 1st attach.
> -			 * Compared to bare-metal, it is too late and we
> -			 * should really lock here. However, on powerVM,
> -			 * pp_size is really only used to display in /sys.
> -			 * Being discussed with pHyp for their next release.
> -			 */
> -			ctx->afu->pp_size = mmio_size;
> -		}
> -		/* from PAPR: process element is bytes 4-7 of process token */
> -		ctx->external_pe = ctx->process_token & 0xFFFFFFFF;
> -		pr_devel("CXL pe=%i is known as %i for pHyp, mmio_size=%#llx",
> -			ctx->pe, ctx->external_pe, ctx->psn_size);
> -		ctx->pe_inserted = true;
> -		enable_afu_irqs(ctx);
> -	}
> -
> -out_free:
> -	free_page((u64)elem);
> -	return rc;
> -}
> -
> -static int guest_attach_process(struct cxl_context *ctx, bool kernel, u64 wed, u64 amr)
> -{
> -	pr_devel("in %s\n", __func__);
> -
> -	ctx->kernel = kernel;
> -	if (ctx->afu->current_mode == CXL_MODE_DIRECTED)
> -		return attach_afu_directed(ctx, wed, amr);
> -
> -	/* dedicated mode not supported on FW840 */
> -
> -	return -EINVAL;
> -}
> -
> -static int detach_afu_directed(struct cxl_context *ctx)
> -{
> -	if (!ctx->pe_inserted)
> -		return 0;
> -	if (cxl_h_detach_process(ctx->afu->guest->handle, ctx->process_token))
> -		return -1;
> -	return 0;
> -}
> -
> -static int guest_detach_process(struct cxl_context *ctx)
> -{
> -	pr_devel("in %s\n", __func__);
> -	trace_cxl_detach(ctx);
> -
> -	if (!cxl_ops->link_ok(ctx->afu->adapter, ctx->afu))
> -		return -EIO;
> -
> -	if (ctx->afu->current_mode == CXL_MODE_DIRECTED)
> -		return detach_afu_directed(ctx);
> -
> -	return -EINVAL;
> -}
> -
> -static void guest_release_afu(struct device *dev)
> -{
> -	struct cxl_afu *afu = to_cxl_afu(dev);
> -
> -	pr_devel("%s\n", __func__);
> -
> -	idr_destroy(&afu->contexts_idr);
> -
> -	kfree(afu->guest);
> -	kfree(afu);
> -}
> -
> -ssize_t cxl_guest_read_afu_vpd(struct cxl_afu *afu, void *buf, size_t len)
> -{
> -	return guest_collect_vpd(NULL, afu, buf, len);
> -}
> -
> -#define ERR_BUFF_MAX_COPY_SIZE PAGE_SIZE
> -static ssize_t guest_afu_read_err_buffer(struct cxl_afu *afu, char *buf,
> -					loff_t off, size_t count)
> -{
> -	void *tbuf = NULL;
> -	int rc = 0;
> -
> -	tbuf = (void *) get_zeroed_page(GFP_KERNEL);
> -	if (!tbuf)
> -		return -ENOMEM;
> -
> -	rc = cxl_h_get_afu_err(afu->guest->handle,
> -			       off & 0x7,
> -			       virt_to_phys(tbuf),
> -			       count);
> -	if (rc)
> -		goto err;
> -
> -	if (count > ERR_BUFF_MAX_COPY_SIZE)
> -		count = ERR_BUFF_MAX_COPY_SIZE - (off & 0x7);
> -	memcpy(buf, tbuf, count);
> -err:
> -	free_page((u64)tbuf);
> -
> -	return rc;
> -}
> -
> -static int guest_afu_check_and_enable(struct cxl_afu *afu)
> -{
> -	return 0;
> -}
> -
> -static bool guest_support_attributes(const char *attr_name,
> -				     enum cxl_attrs type)
> -{
> -	switch (type) {
> -	case CXL_ADAPTER_ATTRS:
> -		if ((strcmp(attr_name, "base_image") == 0) ||
> -			(strcmp(attr_name, "load_image_on_perst") == 0) ||
> -			(strcmp(attr_name, "perst_reloads_same_image") == 0) ||
> -			(strcmp(attr_name, "image_loaded") == 0))
> -			return false;
> -		break;
> -	case CXL_AFU_MASTER_ATTRS:
> -		if ((strcmp(attr_name, "pp_mmio_off") == 0))
> -			return false;
> -		break;
> -	case CXL_AFU_ATTRS:
> -		break;
> -	default:
> -		break;
> -	}
> -
> -	return true;
> -}
> -
> -static int activate_afu_directed(struct cxl_afu *afu)
> -{
> -	int rc;
> -
> -	dev_info(&afu->dev, "Activating AFU(%d) directed mode\n", afu->slice);
> -
> -	afu->current_mode = CXL_MODE_DIRECTED;
> -
> -	afu->num_procs = afu->max_procs_virtualised;
> -
> -	if ((rc = cxl_chardev_m_afu_add(afu)))
> -		return rc;
> -
> -	if ((rc = cxl_sysfs_afu_m_add(afu)))
> -		goto err;
> -
> -	if ((rc = cxl_chardev_s_afu_add(afu)))
> -		goto err1;
> -
> -	return 0;
> -err1:
> -	cxl_sysfs_afu_m_remove(afu);
> -err:
> -	cxl_chardev_afu_remove(afu);
> -	return rc;
> -}
> -
> -static int guest_afu_activate_mode(struct cxl_afu *afu, int mode)
> -{
> -	if (!mode)
> -		return 0;
> -	if (!(mode & afu->modes_supported))
> -		return -EINVAL;
> -
> -	if (mode == CXL_MODE_DIRECTED)
> -		return activate_afu_directed(afu);
> -
> -	if (mode == CXL_MODE_DEDICATED)
> -		dev_err(&afu->dev, "Dedicated mode not supported\n");
> -
> -	return -EINVAL;
> -}
> -
> -static int deactivate_afu_directed(struct cxl_afu *afu)
> -{
> -	dev_info(&afu->dev, "Deactivating AFU(%d) directed mode\n", afu->slice);
> -
> -	afu->current_mode = 0;
> -	afu->num_procs = 0;
> -
> -	cxl_sysfs_afu_m_remove(afu);
> -	cxl_chardev_afu_remove(afu);
> -
> -	cxl_ops->afu_reset(afu);
> -
> -	return 0;
> -}
> -
> -static int guest_afu_deactivate_mode(struct cxl_afu *afu, int mode)
> -{
> -	if (!mode)
> -		return 0;
> -	if (!(mode & afu->modes_supported))
> -		return -EINVAL;
> -
> -	if (mode == CXL_MODE_DIRECTED)
> -		return deactivate_afu_directed(afu);
> -	return 0;
> -}
> -
> -static int guest_afu_reset(struct cxl_afu *afu)
> -{
> -	pr_devel("AFU(%d) reset request\n", afu->slice);
> -	return cxl_h_reset_afu(afu->guest->handle);
> -}
> -
> -static int guest_map_slice_regs(struct cxl_afu *afu)
> -{
> -	if (!(afu->p2n_mmio = ioremap(afu->guest->p2n_phys, afu->guest->p2n_size))) {
> -		dev_err(&afu->dev, "Error mapping AFU(%d) MMIO regions\n",
> -			afu->slice);
> -		return -ENOMEM;
> -	}
> -	return 0;
> -}
> -
> -static void guest_unmap_slice_regs(struct cxl_afu *afu)
> -{
> -	if (afu->p2n_mmio)
> -		iounmap(afu->p2n_mmio);
> -}
> -
> -static int afu_update_state(struct cxl_afu *afu)
> -{
> -	int rc, cur_state;
> -
> -	rc = afu_read_error_state(afu, &cur_state);
> -	if (rc)
> -		return rc;
> -
> -	if (afu->guest->previous_state == cur_state)
> -		return 0;
> -
> -	pr_devel("AFU(%d) update state to %#x\n", afu->slice, cur_state);
> -
> -	switch (cur_state) {
> -	case H_STATE_NORMAL:
> -		afu->guest->previous_state = cur_state;
> -		break;
> -
> -	case H_STATE_DISABLE:
> -		pci_error_handlers(afu, CXL_ERROR_DETECTED_EVENT,
> -				pci_channel_io_frozen);
> -
> -		cxl_context_detach_all(afu);
> -		if ((rc = cxl_ops->afu_reset(afu)))
> -			pr_devel("reset hcall failed %d\n", rc);
> -
> -		rc = afu_read_error_state(afu, &cur_state);
> -		if (!rc && cur_state == H_STATE_NORMAL) {
> -			pci_error_handlers(afu, CXL_SLOT_RESET_EVENT,
> -					pci_channel_io_normal);
> -			pci_error_handlers(afu, CXL_RESUME_EVENT, 0);
> -		}
> -		afu->guest->previous_state = 0;
> -		break;
> -
> -	case H_STATE_TEMP_UNAVAILABLE:
> -		afu->guest->previous_state = cur_state;
> -		break;
> -
> -	case H_STATE_PERM_UNAVAILABLE:
> -		dev_err(&afu->dev, "AFU is in permanent error state\n");
> -		pci_error_handlers(afu, CXL_ERROR_DETECTED_EVENT,
> -				pci_channel_io_perm_failure);
> -		afu->guest->previous_state = cur_state;
> -		break;
> -
> -	default:
> -		pr_err("Unexpected AFU(%d) error state: %#x\n",
> -		       afu->slice, cur_state);
> -		return -EINVAL;
> -	}
> -
> -	return rc;
> -}
> -
> -static void afu_handle_errstate(struct work_struct *work)
> -{
> -	struct cxl_afu_guest *afu_guest =
> -		container_of(to_delayed_work(work), struct cxl_afu_guest, work_err);
> -
> -	if (!afu_update_state(afu_guest->parent) &&
> -	    afu_guest->previous_state == H_STATE_PERM_UNAVAILABLE)
> -		return;
> -
> -	if (afu_guest->handle_err)
> -		schedule_delayed_work(&afu_guest->work_err,
> -				      msecs_to_jiffies(3000));
> -}
> -
> -static bool guest_link_ok(struct cxl *cxl, struct cxl_afu *afu)
> -{
> -	int state;
> -
> -	if (afu && (!afu_read_error_state(afu, &state))) {
> -		if (state == H_STATE_NORMAL)
> -			return true;
> -	}
> -
> -	return false;
> -}
> -
> -static int afu_properties_look_ok(struct cxl_afu *afu)
> -{
> -	if (afu->pp_irqs < 0) {
> -		dev_err(&afu->dev, "Unexpected per-process minimum interrupt value\n");
> -		return -EINVAL;
> -	}
> -
> -	if (afu->max_procs_virtualised < 1) {
> -		dev_err(&afu->dev, "Unexpected max number of processes virtualised value\n");
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
> -int cxl_guest_init_afu(struct cxl *adapter, int slice, struct device_node *afu_np)
> -{
> -	struct cxl_afu *afu;
> -	bool free = true;
> -	int rc;
> -
> -	pr_devel("in %s - AFU(%d)\n", __func__, slice);
> -	if (!(afu = cxl_alloc_afu(adapter, slice)))
> -		return -ENOMEM;
> -
> -	if (!(afu->guest = kzalloc(sizeof(struct cxl_afu_guest), GFP_KERNEL))) {
> -		kfree(afu);
> -		return -ENOMEM;
> -	}
> -
> -	if ((rc = dev_set_name(&afu->dev, "afu%i.%i",
> -					  adapter->adapter_num,
> -					  slice)))
> -		goto err1;
> -
> -	adapter->slices++;
> -
> -	if ((rc = cxl_of_read_afu_handle(afu, afu_np)))
> -		goto err1;
> -
> -	if ((rc = cxl_ops->afu_reset(afu)))
> -		goto err1;
> -
> -	if ((rc = cxl_of_read_afu_properties(afu, afu_np)))
> -		goto err1;
> -
> -	if ((rc = afu_properties_look_ok(afu)))
> -		goto err1;
> -
> -	if ((rc = guest_map_slice_regs(afu)))
> -		goto err1;
> -
> -	if ((rc = guest_register_serr_irq(afu)))
> -		goto err2;
> -
> -	/*
> -	 * After we call this function we must not free the afu directly, even
> -	 * if it returns an error!
> -	 */
> -	if ((rc = cxl_register_afu(afu)))
> -		goto err_put_dev;
> -
> -	if ((rc = cxl_sysfs_afu_add(afu)))
> -		goto err_del_dev;
> -
> -	/*
> -	 * pHyp doesn't expose the programming models supported by the
> -	 * AFU. pHyp currently only supports directed mode. If it adds
> -	 * dedicated mode later, this version of cxl has no way to
> -	 * detect it. So we'll initialize the driver, but the first
> -	 * attach will fail.
> -	 * Being discussed with pHyp to do better (likely new property)
> -	 */
> -	if (afu->max_procs_virtualised == 1)
> -		afu->modes_supported = CXL_MODE_DEDICATED;
> -	else
> -		afu->modes_supported = CXL_MODE_DIRECTED;
> -
> -	if ((rc = cxl_afu_select_best_mode(afu)))
> -		goto err_remove_sysfs;
> -
> -	adapter->afu[afu->slice] = afu;
> -
> -	afu->enabled = true;
> -
> -	/*
> -	 * wake up the cpu periodically to check the state
> -	 * of the AFU using "afu" stored in the guest structure.
> -	 */
> -	afu->guest->parent = afu;
> -	afu->guest->handle_err = true;
> -	INIT_DELAYED_WORK(&afu->guest->work_err, afu_handle_errstate);
> -	schedule_delayed_work(&afu->guest->work_err, msecs_to_jiffies(1000));
> -
> -	if ((rc = cxl_pci_vphb_add(afu)))
> -		dev_info(&afu->dev, "Can't register vPHB\n");
> -
> -	return 0;
> -
> -err_remove_sysfs:
> -	cxl_sysfs_afu_remove(afu);
> -err_del_dev:
> -	device_del(&afu->dev);
> -err_put_dev:
> -	put_device(&afu->dev);
> -	free = false;
> -	guest_release_serr_irq(afu);
> -err2:
> -	guest_unmap_slice_regs(afu);
> -err1:
> -	if (free) {
> -		kfree(afu->guest);
> -		kfree(afu);
> -	}
> -	return rc;
> -}
> -
> -void cxl_guest_remove_afu(struct cxl_afu *afu)
> -{
> -	if (!afu)
> -		return;
> -
> -	/* flush and stop pending job */
> -	afu->guest->handle_err = false;
> -	flush_delayed_work(&afu->guest->work_err);
> -
> -	cxl_pci_vphb_remove(afu);
> -	cxl_sysfs_afu_remove(afu);
> -
> -	spin_lock(&afu->adapter->afu_list_lock);
> -	afu->adapter->afu[afu->slice] = NULL;
> -	spin_unlock(&afu->adapter->afu_list_lock);
> -
> -	cxl_context_detach_all(afu);
> -	cxl_ops->afu_deactivate_mode(afu, afu->current_mode);
> -	guest_release_serr_irq(afu);
> -	guest_unmap_slice_regs(afu);
> -
> -	device_unregister(&afu->dev);
> -}
> -
> -static void free_adapter(struct cxl *adapter)
> -{
> -	struct irq_avail *cur;
> -	int i;
> -
> -	if (adapter->guest) {
> -		if (adapter->guest->irq_avail) {
> -			for (i = 0; i < adapter->guest->irq_nranges; i++) {
> -				cur = &adapter->guest->irq_avail[i];
> -				bitmap_free(cur->bitmap);
> -			}
> -			kfree(adapter->guest->irq_avail);
> -		}
> -		kfree(adapter->guest->status);
> -		kfree(adapter->guest);
> -	}
> -	cxl_remove_adapter_nr(adapter);
> -	kfree(adapter);
> -}
> -
> -static int properties_look_ok(struct cxl *adapter)
> -{
> -	/* The absence of this property means that the operational
> -	 * status is unknown or okay
> -	 */
> -	if (strlen(adapter->guest->status) &&
> -	    strcmp(adapter->guest->status, "okay")) {
> -		pr_err("ABORTING:Bad operational status of the device\n");
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
> -ssize_t cxl_guest_read_adapter_vpd(struct cxl *adapter, void *buf, size_t len)
> -{
> -	return guest_collect_vpd(adapter, NULL, buf, len);
> -}
> -
> -void cxl_guest_remove_adapter(struct cxl *adapter)
> -{
> -	pr_devel("in %s\n", __func__);
> -
> -	cxl_sysfs_adapter_remove(adapter);
> -
> -	cxl_guest_remove_chardev(adapter);
> -	device_unregister(&adapter->dev);
> -}
> -
> -static void release_adapter(struct device *dev)
> -{
> -	free_adapter(to_cxl_adapter(dev));
> -}
> -
> -struct cxl *cxl_guest_init_adapter(struct device_node *np, struct platform_device *pdev)
> -{
> -	struct cxl *adapter;
> -	bool free = true;
> -	int rc;
> -
> -	if (!(adapter = cxl_alloc_adapter()))
> -		return ERR_PTR(-ENOMEM);
> -
> -	if (!(adapter->guest = kzalloc(sizeof(struct cxl_guest), GFP_KERNEL))) {
> -		free_adapter(adapter);
> -		return ERR_PTR(-ENOMEM);
> -	}
> -
> -	adapter->slices = 0;
> -	adapter->guest->pdev = pdev;
> -	adapter->dev.parent = &pdev->dev;
> -	adapter->dev.release = release_adapter;
> -	dev_set_drvdata(&pdev->dev, adapter);
> -
> -	/*
> -	 * Hypervisor controls PSL timebase initialization (p1 register).
> -	 * On FW840, PSL is initialized.
> -	 */
> -	adapter->psl_timebase_synced = true;
> -
> -	if ((rc = cxl_of_read_adapter_handle(adapter, np)))
> -		goto err1;
> -
> -	if ((rc = cxl_of_read_adapter_properties(adapter, np)))
> -		goto err1;
> -
> -	if ((rc = properties_look_ok(adapter)))
> -		goto err1;
> -
> -	if ((rc = cxl_guest_add_chardev(adapter)))
> -		goto err1;
> -
> -	/*
> -	 * After we call this function we must not free the adapter directly,
> -	 * even if it returns an error!
> -	 */
> -	if ((rc = cxl_register_adapter(adapter)))
> -		goto err_put_dev;
> -
> -	if ((rc = cxl_sysfs_adapter_add(adapter)))
> -		goto err_del_dev;
> -
> -	/* release the context lock as the adapter is configured */
> -	cxl_adapter_context_unlock(adapter);
> -
> -	return adapter;
> -
> -err_del_dev:
> -	device_del(&adapter->dev);
> -err_put_dev:
> -	put_device(&adapter->dev);
> -	free = false;
> -	cxl_guest_remove_chardev(adapter);
> -err1:
> -	if (free)
> -		free_adapter(adapter);
> -	return ERR_PTR(rc);
> -}
> -
> -void cxl_guest_reload_module(struct cxl *adapter)
> -{
> -	struct platform_device *pdev;
> -
> -	pdev = adapter->guest->pdev;
> -	cxl_guest_remove_adapter(adapter);
> -
> -	cxl_of_probe(pdev);
> -}
> -
> -const struct cxl_backend_ops cxl_guest_ops = {
> -	.module = THIS_MODULE,
> -	.adapter_reset = guest_reset,
> -	.alloc_one_irq = guest_alloc_one_irq,
> -	.release_one_irq = guest_release_one_irq,
> -	.alloc_irq_ranges = guest_alloc_irq_ranges,
> -	.release_irq_ranges = guest_release_irq_ranges,
> -	.setup_irq = NULL,
> -	.handle_psl_slice_error = guest_handle_psl_slice_error,
> -	.psl_interrupt = guest_psl_irq,
> -	.ack_irq = guest_ack_irq,
> -	.attach_process = guest_attach_process,
> -	.detach_process = guest_detach_process,
> -	.update_ivtes = NULL,
> -	.support_attributes = guest_support_attributes,
> -	.link_ok = guest_link_ok,
> -	.release_afu = guest_release_afu,
> -	.afu_read_err_buffer = guest_afu_read_err_buffer,
> -	.afu_check_and_enable = guest_afu_check_and_enable,
> -	.afu_activate_mode = guest_afu_activate_mode,
> -	.afu_deactivate_mode = guest_afu_deactivate_mode,
> -	.afu_reset = guest_afu_reset,
> -	.afu_cr_read8 = guest_afu_cr_read8,
> -	.afu_cr_read16 = guest_afu_cr_read16,
> -	.afu_cr_read32 = guest_afu_cr_read32,
> -	.afu_cr_read64 = guest_afu_cr_read64,
> -	.afu_cr_write8 = guest_afu_cr_write8,
> -	.afu_cr_write16 = guest_afu_cr_write16,
> -	.afu_cr_write32 = guest_afu_cr_write32,
> -	.read_adapter_vpd = cxl_guest_read_adapter_vpd,
> -};
> diff --git a/drivers/misc/cxl/hcalls.c b/drivers/misc/cxl/hcalls.c
> deleted file mode 100644
> index aba5e20eeb1f..000000000000
> --- a/drivers/misc/cxl/hcalls.c
> +++ /dev/null
> @@ -1,643 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * Copyright 2015 IBM Corp.
> - */
> -
> -
> -#include <linux/compiler.h>
> -#include <linux/types.h>
> -#include <linux/delay.h>
> -#include <asm/byteorder.h>
> -#include "hcalls.h"
> -#include "trace.h"
> -
> -#define CXL_HCALL_TIMEOUT 60000
> -#define CXL_HCALL_TIMEOUT_DOWNLOAD 120000
> -
> -#define H_ATTACH_CA_PROCESS    0x344
> -#define H_CONTROL_CA_FUNCTION  0x348
> -#define H_DETACH_CA_PROCESS    0x34C
> -#define H_COLLECT_CA_INT_INFO  0x350
> -#define H_CONTROL_CA_FAULTS    0x354
> -#define H_DOWNLOAD_CA_FUNCTION 0x35C
> -#define H_DOWNLOAD_CA_FACILITY 0x364
> -#define H_CONTROL_CA_FACILITY  0x368
> -
> -#define H_CONTROL_CA_FUNCTION_RESET                   1 /* perform a reset */
> -#define H_CONTROL_CA_FUNCTION_SUSPEND_PROCESS         2 /* suspend a process from being executed */
> -#define H_CONTROL_CA_FUNCTION_RESUME_PROCESS          3 /* resume a process to be executed */
> -#define H_CONTROL_CA_FUNCTION_READ_ERR_STATE          4 /* read the error state */
> -#define H_CONTROL_CA_FUNCTION_GET_AFU_ERR             5 /* collect the AFU error buffer */
> -#define H_CONTROL_CA_FUNCTION_GET_CONFIG              6 /* collect configuration record */
> -#define H_CONTROL_CA_FUNCTION_GET_DOWNLOAD_STATE      7 /* query to return download status */
> -#define H_CONTROL_CA_FUNCTION_TERMINATE_PROCESS       8 /* terminate the process before completion */
> -#define H_CONTROL_CA_FUNCTION_COLLECT_VPD             9 /* collect VPD */
> -#define H_CONTROL_CA_FUNCTION_GET_FUNCTION_ERR_INT   11 /* read the function-wide error data based on an interrupt */
> -#define H_CONTROL_CA_FUNCTION_ACK_FUNCTION_ERR_INT   12 /* acknowledge function-wide error data based on an interrupt */
> -#define H_CONTROL_CA_FUNCTION_GET_ERROR_LOG          13 /* retrieve the Platform Log ID (PLID) of an error log */
> -
> -#define H_CONTROL_CA_FAULTS_RESPOND_PSL         1
> -#define H_CONTROL_CA_FAULTS_RESPOND_AFU         2
> -
> -#define H_CONTROL_CA_FACILITY_RESET             1 /* perform a reset */
> -#define H_CONTROL_CA_FACILITY_COLLECT_VPD       2 /* collect VPD */
> -
> -#define H_DOWNLOAD_CA_FACILITY_DOWNLOAD         1 /* download adapter image */
> -#define H_DOWNLOAD_CA_FACILITY_VALIDATE         2 /* validate adapter image */
> -
> -
> -#define _CXL_LOOP_HCALL(call, rc, retbuf, fn, ...)			\
> -	{								\
> -		unsigned int delay, total_delay = 0;			\
> -		u64 token = 0;						\
> -									\
> -		memset(retbuf, 0, sizeof(retbuf));			\
> -		while (1) {						\
> -			rc = call(fn, retbuf, __VA_ARGS__, token);	\
> -			token = retbuf[0];				\
> -			if (rc != H_BUSY && !H_IS_LONG_BUSY(rc))	\
> -				break;					\
> -									\
> -			if (rc == H_BUSY)				\
> -				delay = 10;				\
> -			else						\
> -				delay = get_longbusy_msecs(rc);		\
> -									\
> -			total_delay += delay;				\
> -			if (total_delay > CXL_HCALL_TIMEOUT) {		\
> -				WARN(1, "Warning: Giving up waiting for CXL hcall " \
> -					"%#x after %u msec\n", fn, total_delay); \
> -				rc = H_BUSY;				\
> -				break;					\
> -			}						\
> -			msleep(delay);					\
> -		}							\
> -	}
> -#define CXL_H_WAIT_UNTIL_DONE(...)  _CXL_LOOP_HCALL(plpar_hcall, __VA_ARGS__)
> -#define CXL_H9_WAIT_UNTIL_DONE(...) _CXL_LOOP_HCALL(plpar_hcall9, __VA_ARGS__)
> -
> -#define _PRINT_MSG(rc, format, ...)					\
> -	{								\
> -		if ((rc != H_SUCCESS) && (rc != H_CONTINUE))		\
> -			pr_err(format, __VA_ARGS__);			\
> -		else							\
> -			pr_devel(format, __VA_ARGS__);			\
> -	}								\
> -
> -
> -static char *afu_op_names[] = {
> -	"UNKNOWN_OP",		/* 0 undefined */
> -	"RESET",		/* 1 */
> -	"SUSPEND_PROCESS",	/* 2 */
> -	"RESUME_PROCESS",	/* 3 */
> -	"READ_ERR_STATE",	/* 4 */
> -	"GET_AFU_ERR",		/* 5 */
> -	"GET_CONFIG",		/* 6 */
> -	"GET_DOWNLOAD_STATE",	/* 7 */
> -	"TERMINATE_PROCESS",	/* 8 */
> -	"COLLECT_VPD",		/* 9 */
> -	"UNKNOWN_OP",		/* 10 undefined */
> -	"GET_FUNCTION_ERR_INT",	/* 11 */
> -	"ACK_FUNCTION_ERR_INT",	/* 12 */
> -	"GET_ERROR_LOG",	/* 13 */
> -};
> -
> -static char *control_adapter_op_names[] = {
> -	"UNKNOWN_OP",		/* 0 undefined */
> -	"RESET",		/* 1 */
> -	"COLLECT_VPD",		/* 2 */
> -};
> -
> -static char *download_op_names[] = {
> -	"UNKNOWN_OP",		/* 0 undefined */
> -	"DOWNLOAD",		/* 1 */
> -	"VALIDATE",		/* 2 */
> -};
> -
> -static char *op_str(unsigned int op, char *name_array[], int array_len)
> -{
> -	if (op >= array_len)
> -		return "UNKNOWN_OP";
> -	return name_array[op];
> -}
> -
> -#define OP_STR(op, name_array)      op_str(op, name_array, ARRAY_SIZE(name_array))
> -
> -#define OP_STR_AFU(op)              OP_STR(op, afu_op_names)
> -#define OP_STR_CONTROL_ADAPTER(op)  OP_STR(op, control_adapter_op_names)
> -#define OP_STR_DOWNLOAD_ADAPTER(op) OP_STR(op, download_op_names)
> -
> -
> -long cxl_h_attach_process(u64 unit_address,
> -			struct cxl_process_element_hcall *element,
> -			u64 *process_token, u64 *mmio_addr, u64 *mmio_size)
> -{
> -	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
> -	long rc;
> -
> -	CXL_H_WAIT_UNTIL_DONE(rc, retbuf, H_ATTACH_CA_PROCESS, unit_address, virt_to_phys(element));
> -	_PRINT_MSG(rc, "cxl_h_attach_process(%#.16llx, %#.16lx): %li\n",
> -		unit_address, virt_to_phys(element), rc);
> -	trace_cxl_hcall_attach(unit_address, virt_to_phys(element), retbuf[0], retbuf[1], retbuf[2], rc);
> -
> -	pr_devel("token: 0x%.8lx mmio_addr: 0x%lx mmio_size: 0x%lx\nProcess Element Structure:\n",
> -		retbuf[0], retbuf[1], retbuf[2]);
> -	cxl_dump_debug_buffer(element, sizeof(*element));
> -
> -	switch (rc) {
> -	case H_SUCCESS:       /* The process info is attached to the coherent platform function */
> -		*process_token = retbuf[0];
> -		if (mmio_addr)
> -			*mmio_addr = retbuf[1];
> -		if (mmio_size)
> -			*mmio_size = retbuf[2];
> -		return 0;
> -	case H_PARAMETER:     /* An incorrect parameter was supplied. */
> -	case H_FUNCTION:      /* The function is not supported. */
> -		return -EINVAL;
> -	case H_AUTHORITY:     /* The partition does not have authority to perform this hcall */
> -	case H_RESOURCE:      /* The coherent platform function does not have enough additional resource to attach the process */
> -	case H_HARDWARE:      /* A hardware event prevented the attach operation */
> -	case H_STATE:         /* The coherent platform function is not in a valid state */
> -	case H_BUSY:
> -		return -EBUSY;
> -	default:
> -		WARN(1, "Unexpected return code: %lx", rc);
> -		return -EINVAL;
> -	}
> -}
> -
> -/*
> - * cxl_h_detach_process - Detach a process element from a coherent
> - *                        platform function.
> - */
> -long cxl_h_detach_process(u64 unit_address, u64 process_token)
> -{
> -	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
> -	long rc;
> -
> -	CXL_H_WAIT_UNTIL_DONE(rc, retbuf, H_DETACH_CA_PROCESS, unit_address, process_token);
> -	_PRINT_MSG(rc, "cxl_h_detach_process(%#.16llx, 0x%.8llx): %li\n", unit_address, process_token, rc);
> -	trace_cxl_hcall_detach(unit_address, process_token, rc);
> -
> -	switch (rc) {
> -	case H_SUCCESS:       /* The process was detached from the coherent platform function */
> -		return 0;
> -	case H_PARAMETER:     /* An incorrect parameter was supplied. */
> -		return -EINVAL;
> -	case H_AUTHORITY:     /* The partition does not have authority to perform this hcall */
> -	case H_RESOURCE:      /* The function has page table mappings for MMIO */
> -	case H_HARDWARE:      /* A hardware event prevented the detach operation */
> -	case H_STATE:         /* The coherent platform function is not in a valid state */
> -	case H_BUSY:
> -		return -EBUSY;
> -	default:
> -		WARN(1, "Unexpected return code: %lx", rc);
> -		return -EINVAL;
> -	}
> -}
> -
> -/*
> - * cxl_h_control_function - This H_CONTROL_CA_FUNCTION hypervisor call allows
> - *                          the partition to manipulate or query
> - *                          certain coherent platform function behaviors.
> - */
> -static long cxl_h_control_function(u64 unit_address, u64 op,
> -				   u64 p1, u64 p2, u64 p3, u64 p4, u64 *out)
> -{
> -	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE];
> -	long rc;
> -
> -	CXL_H9_WAIT_UNTIL_DONE(rc, retbuf, H_CONTROL_CA_FUNCTION, unit_address, op, p1, p2, p3, p4);
> -	_PRINT_MSG(rc, "cxl_h_control_function(%#.16llx, %s(%#llx, %#llx, %#llx, %#llx, R4: %#lx)): %li\n",
> -		unit_address, OP_STR_AFU(op), p1, p2, p3, p4, retbuf[0], rc);
> -	trace_cxl_hcall_control_function(unit_address, OP_STR_AFU(op), p1, p2, p3, p4, retbuf[0], rc);
> -
> -	switch (rc) {
> -	case H_SUCCESS:       /* The operation is completed for the coherent platform function */
> -		if ((op == H_CONTROL_CA_FUNCTION_GET_FUNCTION_ERR_INT ||
> -		     op == H_CONTROL_CA_FUNCTION_READ_ERR_STATE ||
> -		     op == H_CONTROL_CA_FUNCTION_COLLECT_VPD))
> -			*out = retbuf[0];
> -		return 0;
> -	case H_PARAMETER:     /* An incorrect parameter was supplied. */
> -	case H_FUNCTION:      /* The function is not supported. */
> -	case H_NOT_FOUND:     /* The operation supplied was not valid */
> -	case H_NOT_AVAILABLE: /* The operation cannot be performed because the AFU has not been downloaded */
> -	case H_SG_LIST:       /* An block list entry was invalid */
> -		return -EINVAL;
> -	case H_AUTHORITY:     /* The partition does not have authority to perform this hcall */
> -	case H_RESOURCE:      /* The function has page table mappings for MMIO */
> -	case H_HARDWARE:      /* A hardware event prevented the attach operation */
> -	case H_STATE:         /* The coherent platform function is not in a valid state */
> -	case H_BUSY:
> -		return -EBUSY;
> -	default:
> -		WARN(1, "Unexpected return code: %lx", rc);
> -		return -EINVAL;
> -	}
> -}
> -
> -/*
> - * cxl_h_reset_afu - Perform a reset to the coherent platform function.
> - */
> -long cxl_h_reset_afu(u64 unit_address)
> -{
> -	return cxl_h_control_function(unit_address,
> -				H_CONTROL_CA_FUNCTION_RESET,
> -				0, 0, 0, 0,
> -				NULL);
> -}
> -
> -/*
> - * cxl_h_suspend_process - Suspend a process from being executed
> - * Parameter1 = process-token as returned from H_ATTACH_CA_PROCESS when
> - *              process was attached.
> - */
> -long cxl_h_suspend_process(u64 unit_address, u64 process_token)
> -{
> -	return cxl_h_control_function(unit_address,
> -				H_CONTROL_CA_FUNCTION_SUSPEND_PROCESS,
> -				process_token, 0, 0, 0,
> -				NULL);
> -}
> -
> -/*
> - * cxl_h_resume_process - Resume a process to be executed
> - * Parameter1 = process-token as returned from H_ATTACH_CA_PROCESS when
> - *              process was attached.
> - */
> -long cxl_h_resume_process(u64 unit_address, u64 process_token)
> -{
> -	return cxl_h_control_function(unit_address,
> -				H_CONTROL_CA_FUNCTION_RESUME_PROCESS,
> -				process_token, 0, 0, 0,
> -				NULL);
> -}
> -
> -/*
> - * cxl_h_read_error_state - Checks the error state of the coherent
> - *                          platform function.
> - * R4 contains the error state
> - */
> -long cxl_h_read_error_state(u64 unit_address, u64 *state)
> -{
> -	return cxl_h_control_function(unit_address,
> -				H_CONTROL_CA_FUNCTION_READ_ERR_STATE,
> -				0, 0, 0, 0,
> -				state);
> -}
> -
> -/*
> - * cxl_h_get_afu_err - collect the AFU error buffer
> - * Parameter1 = byte offset into error buffer to retrieve, valid values
> - *              are between 0 and (ibm,error-buffer-size - 1)
> - * Parameter2 = 4K aligned real address of error buffer, to be filled in
> - * Parameter3 = length of error buffer, valid values are 4K or less
> - */
> -long cxl_h_get_afu_err(u64 unit_address, u64 offset,
> -		u64 buf_address, u64 len)
> -{
> -	return cxl_h_control_function(unit_address,
> -				H_CONTROL_CA_FUNCTION_GET_AFU_ERR,
> -				offset, buf_address, len, 0,
> -				NULL);
> -}
> -
> -/*
> - * cxl_h_get_config - collect configuration record for the
> - *                    coherent platform function
> - * Parameter1 = # of configuration record to retrieve, valid values are
> - *              between 0 and (ibm,#config-records - 1)
> - * Parameter2 = byte offset into configuration record to retrieve,
> - *              valid values are between 0 and (ibm,config-record-size - 1)
> - * Parameter3 = 4K aligned real address of configuration record buffer,
> - *              to be filled in
> - * Parameter4 = length of configuration buffer, valid values are 4K or less
> - */
> -long cxl_h_get_config(u64 unit_address, u64 cr_num, u64 offset,
> -		u64 buf_address, u64 len)
> -{
> -	return cxl_h_control_function(unit_address,
> -				H_CONTROL_CA_FUNCTION_GET_CONFIG,
> -				cr_num, offset, buf_address, len,
> -				NULL);
> -}
> -
> -/*
> - * cxl_h_terminate_process - Terminate the process before completion
> - * Parameter1 = process-token as returned from H_ATTACH_CA_PROCESS when
> - *              process was attached.
> - */
> -long cxl_h_terminate_process(u64 unit_address, u64 process_token)
> -{
> -	return cxl_h_control_function(unit_address,
> -				H_CONTROL_CA_FUNCTION_TERMINATE_PROCESS,
> -				process_token, 0, 0, 0,
> -				NULL);
> -}
> -
> -/*
> - * cxl_h_collect_vpd - Collect VPD for the coherent platform function.
> - * Parameter1 = # of VPD record to retrieve, valid values are between 0
> - *              and (ibm,#config-records - 1).
> - * Parameter2 = 4K naturally aligned real buffer containing block
> - *              list entries
> - * Parameter3 = number of block list entries in the block list, valid
> - *              values are between 0 and 256
> - */
> -long cxl_h_collect_vpd(u64 unit_address, u64 record, u64 list_address,
> -		       u64 num, u64 *out)
> -{
> -	return cxl_h_control_function(unit_address,
> -				H_CONTROL_CA_FUNCTION_COLLECT_VPD,
> -				record, list_address, num, 0,
> -				out);
> -}
> -
> -/*
> - * cxl_h_get_fn_error_interrupt - Read the function-wide error data based on an interrupt
> - */
> -long cxl_h_get_fn_error_interrupt(u64 unit_address, u64 *reg)
> -{
> -	return cxl_h_control_function(unit_address,
> -				H_CONTROL_CA_FUNCTION_GET_FUNCTION_ERR_INT,
> -				0, 0, 0, 0, reg);
> -}
> -
> -/*
> - * cxl_h_ack_fn_error_interrupt - Acknowledge function-wide error data
> - *                                based on an interrupt
> - * Parameter1 = value to write to the function-wide error interrupt register
> - */
> -long cxl_h_ack_fn_error_interrupt(u64 unit_address, u64 value)
> -{
> -	return cxl_h_control_function(unit_address,
> -				H_CONTROL_CA_FUNCTION_ACK_FUNCTION_ERR_INT,
> -				value, 0, 0, 0,
> -				NULL);
> -}
> -
> -/*
> - * cxl_h_get_error_log - Retrieve the Platform Log ID (PLID) of
> - *                       an error log
> - */
> -long cxl_h_get_error_log(u64 unit_address, u64 value)
> -{
> -	return cxl_h_control_function(unit_address,
> -				H_CONTROL_CA_FUNCTION_GET_ERROR_LOG,
> -				0, 0, 0, 0,
> -				NULL);
> -}
> -
> -/*
> - * cxl_h_collect_int_info - Collect interrupt info about a coherent
> - *                          platform function after an interrupt occurred.
> - */
> -long cxl_h_collect_int_info(u64 unit_address, u64 process_token,
> -			    struct cxl_irq_info *info)
> -{
> -	long rc;
> -
> -	BUG_ON(sizeof(*info) != sizeof(unsigned long[PLPAR_HCALL9_BUFSIZE]));
> -
> -	rc = plpar_hcall9(H_COLLECT_CA_INT_INFO, (unsigned long *) info,
> -			unit_address, process_token);
> -	_PRINT_MSG(rc, "cxl_h_collect_int_info(%#.16llx, 0x%llx): %li\n",
> -		unit_address, process_token, rc);
> -	trace_cxl_hcall_collect_int_info(unit_address, process_token, rc);
> -
> -	switch (rc) {
> -	case H_SUCCESS:     /* The interrupt info is returned in return registers. */
> -		pr_devel("dsisr:%#llx, dar:%#llx, dsr:%#llx, pid_tid:%#llx, afu_err:%#llx, errstat:%#llx\n",
> -			info->dsisr, info->dar, info->dsr, info->reserved,
> -			info->afu_err, info->errstat);
> -		return 0;
> -	case H_PARAMETER:   /* An incorrect parameter was supplied. */
> -		return -EINVAL;
> -	case H_AUTHORITY:   /* The partition does not have authority to perform this hcall. */
> -	case H_HARDWARE:    /* A hardware event prevented the collection of the interrupt info.*/
> -	case H_STATE:       /* The coherent platform function is not in a valid state to collect interrupt info. */
> -		return -EBUSY;
> -	default:
> -		WARN(1, "Unexpected return code: %lx", rc);
> -		return -EINVAL;
> -	}
> -}
> -
> -/*
> - * cxl_h_control_faults - Control the operation of a coherent platform
> - *                        function after a fault occurs.
> - *
> - * Parameters
> - *    control-mask: value to control the faults
> - *                  looks like PSL_TFC_An shifted >> 32
> - *    reset-mask: mask to control reset of function faults
> - *                Set reset_mask = 1 to reset PSL errors
> - */
> -long cxl_h_control_faults(u64 unit_address, u64 process_token,
> -			  u64 control_mask, u64 reset_mask)
> -{
> -	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
> -	long rc;
> -
> -	memset(retbuf, 0, sizeof(retbuf));
> -
> -	rc = plpar_hcall(H_CONTROL_CA_FAULTS, retbuf, unit_address,
> -			H_CONTROL_CA_FAULTS_RESPOND_PSL, process_token,
> -			control_mask, reset_mask);
> -	_PRINT_MSG(rc, "cxl_h_control_faults(%#.16llx, 0x%llx, %#llx, %#llx): %li (%#lx)\n",
> -		unit_address, process_token, control_mask, reset_mask,
> -		rc, retbuf[0]);
> -	trace_cxl_hcall_control_faults(unit_address, process_token,
> -				control_mask, reset_mask, retbuf[0], rc);
> -
> -	switch (rc) {
> -	case H_SUCCESS:    /* Faults were successfully controlled for the function. */
> -		return 0;
> -	case H_PARAMETER:  /* An incorrect parameter was supplied. */
> -		return -EINVAL;
> -	case H_HARDWARE:   /* A hardware event prevented the control of faults. */
> -	case H_STATE:      /* The function was in an invalid state. */
> -	case H_AUTHORITY:  /* The partition does not have authority to perform this hcall; the coherent platform facilities may need to be licensed. */
> -		return -EBUSY;
> -	case H_FUNCTION:   /* The function is not supported */
> -	case H_NOT_FOUND:  /* The operation supplied was not valid */
> -		return -EINVAL;
> -	default:
> -		WARN(1, "Unexpected return code: %lx", rc);
> -		return -EINVAL;
> -	}
> -}
> -
> -/*
> - * cxl_h_control_facility - This H_CONTROL_CA_FACILITY hypervisor call
> - *                          allows the partition to manipulate or query
> - *                          certain coherent platform facility behaviors.
> - */
> -static long cxl_h_control_facility(u64 unit_address, u64 op,
> -				   u64 p1, u64 p2, u64 p3, u64 p4, u64 *out)
> -{
> -	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE];
> -	long rc;
> -
> -	CXL_H9_WAIT_UNTIL_DONE(rc, retbuf, H_CONTROL_CA_FACILITY, unit_address, op, p1, p2, p3, p4);
> -	_PRINT_MSG(rc, "cxl_h_control_facility(%#.16llx, %s(%#llx, %#llx, %#llx, %#llx, R4: %#lx)): %li\n",
> -		unit_address, OP_STR_CONTROL_ADAPTER(op), p1, p2, p3, p4, retbuf[0], rc);
> -	trace_cxl_hcall_control_facility(unit_address, OP_STR_CONTROL_ADAPTER(op), p1, p2, p3, p4, retbuf[0], rc);
> -
> -	switch (rc) {
> -	case H_SUCCESS:       /* The operation is completed for the coherent platform facility */
> -		if (op == H_CONTROL_CA_FACILITY_COLLECT_VPD)
> -			*out = retbuf[0];
> -		return 0;
> -	case H_PARAMETER:     /* An incorrect parameter was supplied. */
> -	case H_FUNCTION:      /* The function is not supported. */
> -	case H_NOT_FOUND:     /* The operation supplied was not valid */
> -	case H_NOT_AVAILABLE: /* The operation cannot be performed because the AFU has not been downloaded */
> -	case H_SG_LIST:       /* An block list entry was invalid */
> -		return -EINVAL;
> -	case H_AUTHORITY:     /* The partition does not have authority to perform this hcall */
> -	case H_RESOURCE:      /* The function has page table mappings for MMIO */
> -	case H_HARDWARE:      /* A hardware event prevented the attach operation */
> -	case H_STATE:         /* The coherent platform facility is not in a valid state */
> -	case H_BUSY:
> -		return -EBUSY;
> -	default:
> -		WARN(1, "Unexpected return code: %lx", rc);
> -		return -EINVAL;
> -	}
> -}
> -
> -/*
> - * cxl_h_reset_adapter - Perform a reset to the coherent platform facility.
> - */
> -long cxl_h_reset_adapter(u64 unit_address)
> -{
> -	return cxl_h_control_facility(unit_address,
> -				H_CONTROL_CA_FACILITY_RESET,
> -				0, 0, 0, 0,
> -				NULL);
> -}
> -
> -/*
> - * cxl_h_collect_vpd - Collect VPD for the coherent platform function.
> - * Parameter1 = 4K naturally aligned real buffer containing block
> - *              list entries
> - * Parameter2 = number of block list entries in the block list, valid
> - *              values are between 0 and 256
> - */
> -long cxl_h_collect_vpd_adapter(u64 unit_address, u64 list_address,
> -			       u64 num, u64 *out)
> -{
> -	return cxl_h_control_facility(unit_address,
> -				H_CONTROL_CA_FACILITY_COLLECT_VPD,
> -				list_address, num, 0, 0,
> -				out);
> -}
> -
> -/*
> - * cxl_h_download_facility - This H_DOWNLOAD_CA_FACILITY
> - *                    hypervisor call provide platform support for
> - *                    downloading a base adapter image to the coherent
> - *                    platform facility, and for validating the entire
> - *                    image after the download.
> - * Parameters
> - *    op: operation to perform to the coherent platform function
> - *      Download: operation = 1, the base image in the coherent platform
> - *                               facility is first erased, and then
> - *                               programmed using the image supplied
> - *                               in the scatter/gather list.
> - *      Validate: operation = 2, the base image in the coherent platform
> - *                               facility is compared with the image
> - *                               supplied in the scatter/gather list.
> - *    list_address: 4K naturally aligned real buffer containing
> - *                  scatter/gather list entries.
> - *    num: number of block list entries in the scatter/gather list.
> - */
> -static long cxl_h_download_facility(u64 unit_address, u64 op,
> -				    u64 list_address, u64 num,
> -				    u64 *out)
> -{
> -	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
> -	unsigned int delay, total_delay = 0;
> -	u64 token = 0;
> -	long rc;
> -
> -	if (*out != 0)
> -		token = *out;
> -
> -	memset(retbuf, 0, sizeof(retbuf));
> -	while (1) {
> -		rc = plpar_hcall(H_DOWNLOAD_CA_FACILITY, retbuf,
> -				 unit_address, op, list_address, num,
> -				 token);
> -		token = retbuf[0];
> -		if (rc != H_BUSY && !H_IS_LONG_BUSY(rc))
> -			break;
> -
> -		if (rc != H_BUSY) {
> -			delay = get_longbusy_msecs(rc);
> -			total_delay += delay;
> -			if (total_delay > CXL_HCALL_TIMEOUT_DOWNLOAD) {
> -				WARN(1, "Warning: Giving up waiting for CXL hcall "
> -					"%#x after %u msec\n",
> -					H_DOWNLOAD_CA_FACILITY, total_delay);
> -				rc = H_BUSY;
> -				break;
> -			}
> -			msleep(delay);
> -		}
> -	}
> -	_PRINT_MSG(rc, "cxl_h_download_facility(%#.16llx, %s(%#llx, %#llx), %#lx): %li\n",
> -		 unit_address, OP_STR_DOWNLOAD_ADAPTER(op), list_address, num, retbuf[0], rc);
> -	trace_cxl_hcall_download_facility(unit_address, OP_STR_DOWNLOAD_ADAPTER(op), list_address, num, retbuf[0], rc);
> -
> -	switch (rc) {
> -	case H_SUCCESS:       /* The operation is completed for the coherent platform facility */
> -		return 0;
> -	case H_PARAMETER:     /* An incorrect parameter was supplied */
> -	case H_FUNCTION:      /* The function is not supported. */
> -	case H_SG_LIST:       /* An block list entry was invalid */
> -	case H_BAD_DATA:      /* Image verification failed */
> -		return -EINVAL;
> -	case H_AUTHORITY:     /* The partition does not have authority to perform this hcall */
> -	case H_RESOURCE:      /* The function has page table mappings for MMIO */
> -	case H_HARDWARE:      /* A hardware event prevented the attach operation */
> -	case H_STATE:         /* The coherent platform facility is not in a valid state */
> -	case H_BUSY:
> -		return -EBUSY;
> -	case H_CONTINUE:
> -		*out = retbuf[0];
> -		return 1;  /* More data is needed for the complete image */
> -	default:
> -		WARN(1, "Unexpected return code: %lx", rc);
> -		return -EINVAL;
> -	}
> -}
> -
> -/*
> - * cxl_h_download_adapter_image - Download the base image to the coherent
> - *                                platform facility.
> - */
> -long cxl_h_download_adapter_image(u64 unit_address,
> -				  u64 list_address, u64 num,
> -				  u64 *out)
> -{
> -	return cxl_h_download_facility(unit_address,
> -				       H_DOWNLOAD_CA_FACILITY_DOWNLOAD,
> -				       list_address, num, out);
> -}
> -
> -/*
> - * cxl_h_validate_adapter_image - Validate the base image in the coherent
> - *                                platform facility.
> - */
> -long cxl_h_validate_adapter_image(u64 unit_address,
> -				  u64 list_address, u64 num,
> -				  u64 *out)
> -{
> -	return cxl_h_download_facility(unit_address,
> -				       H_DOWNLOAD_CA_FACILITY_VALIDATE,
> -				       list_address, num, out);
> -}
> diff --git a/drivers/misc/cxl/hcalls.h b/drivers/misc/cxl/hcalls.h
> deleted file mode 100644
> index d200465dc6ac..000000000000
> --- a/drivers/misc/cxl/hcalls.h
> +++ /dev/null
> @@ -1,200 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * Copyright 2015 IBM Corp.
> - */
> -
> -#ifndef _HCALLS_H
> -#define _HCALLS_H
> -
> -#include <linux/types.h>
> -#include <asm/byteorder.h>
> -#include <asm/hvcall.h>
> -#include "cxl.h"
> -
> -#define SG_BUFFER_SIZE 4096
> -#define SG_MAX_ENTRIES 256
> -
> -struct sg_list {
> -	u64 phys_addr;
> -	u64 len;
> -};
> -
> -/*
> - * This is straight out of PAPR, but replacing some of the compound fields with
> - * a single field, where they were identical to the register layout.
> - *
> - * The 'flags' parameter regroups the various bit-fields
> - */
> -#define CXL_PE_CSRP_VALID			(1ULL << 63)
> -#define CXL_PE_PROBLEM_STATE			(1ULL << 62)
> -#define CXL_PE_SECONDARY_SEGMENT_TBL_SRCH	(1ULL << 61)
> -#define CXL_PE_TAGS_ACTIVE			(1ULL << 60)
> -#define CXL_PE_USER_STATE			(1ULL << 59)
> -#define CXL_PE_TRANSLATION_ENABLED		(1ULL << 58)
> -#define CXL_PE_64_BIT				(1ULL << 57)
> -#define CXL_PE_PRIVILEGED_PROCESS		(1ULL << 56)
> -
> -#define CXL_PROCESS_ELEMENT_VERSION 1
> -struct cxl_process_element_hcall {
> -	__be64 version;
> -	__be64 flags;
> -	u8     reserved0[12];
> -	__be32 pslVirtualIsn;
> -	u8     applicationVirtualIsnBitmap[256];
> -	u8     reserved1[144];
> -	struct cxl_process_element_common common;
> -	u8     reserved4[12];
> -} __packed;
> -
> -#define H_STATE_NORMAL              1
> -#define H_STATE_DISABLE             2
> -#define H_STATE_TEMP_UNAVAILABLE    3
> -#define H_STATE_PERM_UNAVAILABLE    4
> -
> -/* NOTE: element must be a logical real address, and must be pinned */
> -long cxl_h_attach_process(u64 unit_address, struct cxl_process_element_hcall *element,
> -			u64 *process_token, u64 *mmio_addr, u64 *mmio_size);
> -
> -/**
> - * cxl_h_detach_process - Detach a process element from a coherent
> - *                        platform function.
> - */
> -long cxl_h_detach_process(u64 unit_address, u64 process_token);
> -
> -/**
> - * cxl_h_reset_afu - Perform a reset to the coherent platform function.
> - */
> -long cxl_h_reset_afu(u64 unit_address);
> -
> -/**
> - * cxl_h_suspend_process - Suspend a process from being executed
> - * Parameter1 = process-token as returned from H_ATTACH_CA_PROCESS when
> - *              process was attached.
> - */
> -long cxl_h_suspend_process(u64 unit_address, u64 process_token);
> -
> -/**
> - * cxl_h_resume_process - Resume a process to be executed
> - * Parameter1 = process-token as returned from H_ATTACH_CA_PROCESS when
> - *              process was attached.
> - */
> -long cxl_h_resume_process(u64 unit_address, u64 process_token);
> -
> -/**
> - * cxl_h_read_error_state - Reads the error state of the coherent
> - *                          platform function.
> - * R4 contains the error state
> - */
> -long cxl_h_read_error_state(u64 unit_address, u64 *state);
> -
> -/**
> - * cxl_h_get_afu_err - collect the AFU error buffer
> - * Parameter1 = byte offset into error buffer to retrieve, valid values
> - *              are between 0 and (ibm,error-buffer-size - 1)
> - * Parameter2 = 4K aligned real address of error buffer, to be filled in
> - * Parameter3 = length of error buffer, valid values are 4K or less
> - */
> -long cxl_h_get_afu_err(u64 unit_address, u64 offset, u64 buf_address, u64 len);
> -
> -/**
> - * cxl_h_get_config - collect configuration record for the
> - *                    coherent platform function
> - * Parameter1 = # of configuration record to retrieve, valid values are
> - *              between 0 and (ibm,#config-records - 1)
> - * Parameter2 = byte offset into configuration record to retrieve,
> - *              valid values are between 0 and (ibm,config-record-size - 1)
> - * Parameter3 = 4K aligned real address of configuration record buffer,
> - *              to be filled in
> - * Parameter4 = length of configuration buffer, valid values are 4K or less
> - */
> -long cxl_h_get_config(u64 unit_address, u64 cr_num, u64 offset,
> -		u64 buf_address, u64 len);
> -
> -/**
> - * cxl_h_terminate_process - Terminate the process before completion
> - * Parameter1 = process-token as returned from H_ATTACH_CA_PROCESS when
> - *              process was attached.
> - */
> -long cxl_h_terminate_process(u64 unit_address, u64 process_token);
> -
> -/**
> - * cxl_h_collect_vpd - Collect VPD for the coherent platform function.
> - * Parameter1 = # of VPD record to retrieve, valid values are between 0
> - *              and (ibm,#config-records - 1).
> - * Parameter2 = 4K naturally aligned real buffer containing block
> - *              list entries
> - * Parameter3 = number of block list entries in the block list, valid
> - *              values are between 0 and 256
> - */
> -long cxl_h_collect_vpd(u64 unit_address, u64 record, u64 list_address,
> -		       u64 num, u64 *out);
> -
> -/**
> - * cxl_h_get_fn_error_interrupt - Read the function-wide error data based on an interrupt
> - */
> -long cxl_h_get_fn_error_interrupt(u64 unit_address, u64 *reg);
> -
> -/**
> - * cxl_h_ack_fn_error_interrupt - Acknowledge function-wide error data
> - *                                based on an interrupt
> - * Parameter1 = value to write to the function-wide error interrupt register
> - */
> -long cxl_h_ack_fn_error_interrupt(u64 unit_address, u64 value);
> -
> -/**
> - * cxl_h_get_error_log - Retrieve the Platform Log ID (PLID) of
> - *                       an error log
> - */
> -long cxl_h_get_error_log(u64 unit_address, u64 value);
> -
> -/**
> - * cxl_h_collect_int_info - Collect interrupt info about a coherent
> - *                          platform function after an interrupt occurred.
> - */
> -long cxl_h_collect_int_info(u64 unit_address, u64 process_token,
> -			struct cxl_irq_info *info);
> -
> -/**
> - * cxl_h_control_faults - Control the operation of a coherent platform
> - *                        function after a fault occurs.
> - *
> - * Parameters
> - *    control-mask: value to control the faults
> - *                  looks like PSL_TFC_An shifted >> 32
> - *    reset-mask: mask to control reset of function faults
> - *                Set reset_mask = 1 to reset PSL errors
> - */
> -long cxl_h_control_faults(u64 unit_address, u64 process_token,
> -			u64 control_mask, u64 reset_mask);
> -
> -/**
> - * cxl_h_reset_adapter - Perform a reset to the coherent platform facility.
> - */
> -long cxl_h_reset_adapter(u64 unit_address);
> -
> -/**
> - * cxl_h_collect_vpd - Collect VPD for the coherent platform function.
> - * Parameter1 = 4K naturally aligned real buffer containing block
> - *              list entries
> - * Parameter2 = number of block list entries in the block list, valid
> - *              values are between 0 and 256
> - */
> -long cxl_h_collect_vpd_adapter(u64 unit_address, u64 list_address,
> -			       u64 num, u64 *out);
> -
> -/**
> - * cxl_h_download_adapter_image - Download the base image to the coherent
> - *                                platform facility.
> - */
> -long cxl_h_download_adapter_image(u64 unit_address,
> -				  u64 list_address, u64 num,
> -				  u64 *out);
> -
> -/**
> - * cxl_h_validate_adapter_image - Validate the base image in the coherent
> - *                                platform facility.
> - */
> -long cxl_h_validate_adapter_image(u64 unit_address,
> -				  u64 list_address, u64 num,
> -				  u64 *out);
> -#endif /* _HCALLS_H */
> diff --git a/drivers/misc/cxl/irq.c b/drivers/misc/cxl/irq.c
> deleted file mode 100644
> index b730e022a48e..000000000000
> --- a/drivers/misc/cxl/irq.c
> +++ /dev/null
> @@ -1,450 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * Copyright 2014 IBM Corp.
> - */
> -
> -#include <linux/interrupt.h>
> -#include <linux/irqdomain.h>
> -#include <linux/workqueue.h>
> -#include <linux/sched.h>
> -#include <linux/wait.h>
> -#include <linux/slab.h>
> -#include <linux/pid.h>
> -#include <asm/cputable.h>
> -#include <misc/cxl-base.h>
> -
> -#include "cxl.h"
> -#include "trace.h"
> -
> -static int afu_irq_range_start(void)
> -{
> -	if (cpu_has_feature(CPU_FTR_HVMODE))
> -		return 1;
> -	return 0;
> -}
> -
> -static irqreturn_t schedule_cxl_fault(struct cxl_context *ctx, u64 dsisr, u64 dar)
> -{
> -	ctx->dsisr = dsisr;
> -	ctx->dar = dar;
> -	schedule_work(&ctx->fault_work);
> -	return IRQ_HANDLED;
> -}
> -
> -irqreturn_t cxl_irq_psl9(int irq, struct cxl_context *ctx, struct cxl_irq_info *irq_info)
> -{
> -	u64 dsisr, dar;
> -
> -	dsisr = irq_info->dsisr;
> -	dar = irq_info->dar;
> -
> -	trace_cxl_psl9_irq(ctx, irq, dsisr, dar);
> -
> -	pr_devel("CXL interrupt %i for afu pe: %i DSISR: %#llx DAR: %#llx\n", irq, ctx->pe, dsisr, dar);
> -
> -	if (dsisr & CXL_PSL9_DSISR_An_TF) {
> -		pr_devel("CXL interrupt: Scheduling translation fault handling for later (pe: %i)\n", ctx->pe);
> -		return schedule_cxl_fault(ctx, dsisr, dar);
> -	}
> -
> -	if (dsisr & CXL_PSL9_DSISR_An_PE)
> -		return cxl_ops->handle_psl_slice_error(ctx, dsisr,
> -						irq_info->errstat);
> -	if (dsisr & CXL_PSL9_DSISR_An_AE) {
> -		pr_devel("CXL interrupt: AFU Error 0x%016llx\n", irq_info->afu_err);
> -
> -		if (ctx->pending_afu_err) {
> -			/*
> -			 * This shouldn't happen - the PSL treats these errors
> -			 * as fatal and will have reset the AFU, so there's not
> -			 * much point buffering multiple AFU errors.
> -			 * OTOH if we DO ever see a storm of these come in it's
> -			 * probably best that we log them somewhere:
> -			 */
> -			dev_err_ratelimited(&ctx->afu->dev, "CXL AFU Error undelivered to pe %i: 0x%016llx\n",
> -					    ctx->pe, irq_info->afu_err);
> -		} else {
> -			spin_lock(&ctx->lock);
> -			ctx->afu_err = irq_info->afu_err;
> -			ctx->pending_afu_err = 1;
> -			spin_unlock(&ctx->lock);
> -
> -			wake_up_all(&ctx->wq);
> -		}
> -
> -		cxl_ops->ack_irq(ctx, CXL_PSL_TFC_An_A, 0);
> -		return IRQ_HANDLED;
> -	}
> -	if (dsisr & CXL_PSL9_DSISR_An_OC)
> -		pr_devel("CXL interrupt: OS Context Warning\n");
> -
> -	WARN(1, "Unhandled CXL PSL IRQ\n");
> -	return IRQ_HANDLED;
> -}
> -
> -irqreturn_t cxl_irq_psl8(int irq, struct cxl_context *ctx, struct cxl_irq_info *irq_info)
> -{
> -	u64 dsisr, dar;
> -
> -	dsisr = irq_info->dsisr;
> -	dar = irq_info->dar;
> -
> -	trace_cxl_psl_irq(ctx, irq, dsisr, dar);
> -
> -	pr_devel("CXL interrupt %i for afu pe: %i DSISR: %#llx DAR: %#llx\n", irq, ctx->pe, dsisr, dar);
> -
> -	if (dsisr & CXL_PSL_DSISR_An_DS) {
> -		/*
> -		 * We don't inherently need to sleep to handle this, but we do
> -		 * need to get a ref to the task's mm, which we can't do from
> -		 * irq context without the potential for a deadlock since it
> -		 * takes the task_lock. An alternate option would be to keep a
> -		 * reference to the task's mm the entire time it has cxl open,
> -		 * but to do that we need to solve the issue where we hold a
> -		 * ref to the mm, but the mm can hold a ref to the fd after an
> -		 * mmap preventing anything from being cleaned up.
> -		 */
> -		pr_devel("Scheduling segment miss handling for later pe: %i\n", ctx->pe);
> -		return schedule_cxl_fault(ctx, dsisr, dar);
> -	}
> -
> -	if (dsisr & CXL_PSL_DSISR_An_M)
> -		pr_devel("CXL interrupt: PTE not found\n");
> -	if (dsisr & CXL_PSL_DSISR_An_P)
> -		pr_devel("CXL interrupt: Storage protection violation\n");
> -	if (dsisr & CXL_PSL_DSISR_An_A)
> -		pr_devel("CXL interrupt: AFU lock access to write through or cache inhibited storage\n");
> -	if (dsisr & CXL_PSL_DSISR_An_S)
> -		pr_devel("CXL interrupt: Access was afu_wr or afu_zero\n");
> -	if (dsisr & CXL_PSL_DSISR_An_K)
> -		pr_devel("CXL interrupt: Access not permitted by virtual page class key protection\n");
> -
> -	if (dsisr & CXL_PSL_DSISR_An_DM) {
> -		/*
> -		 * In some cases we might be able to handle the fault
> -		 * immediately if hash_page would succeed, but we still need
> -		 * the task's mm, which as above we can't get without a lock
> -		 */
> -		pr_devel("Scheduling page fault handling for later pe: %i\n", ctx->pe);
> -		return schedule_cxl_fault(ctx, dsisr, dar);
> -	}
> -	if (dsisr & CXL_PSL_DSISR_An_ST)
> -		WARN(1, "CXL interrupt: Segment Table PTE not found\n");
> -	if (dsisr & CXL_PSL_DSISR_An_UR)
> -		pr_devel("CXL interrupt: AURP PTE not found\n");
> -	if (dsisr & CXL_PSL_DSISR_An_PE)
> -		return cxl_ops->handle_psl_slice_error(ctx, dsisr,
> -						irq_info->errstat);
> -	if (dsisr & CXL_PSL_DSISR_An_AE) {
> -		pr_devel("CXL interrupt: AFU Error 0x%016llx\n", irq_info->afu_err);
> -
> -		if (ctx->pending_afu_err) {
> -			/*
> -			 * This shouldn't happen - the PSL treats these errors
> -			 * as fatal and will have reset the AFU, so there's not
> -			 * much point buffering multiple AFU errors.
> -			 * OTOH if we DO ever see a storm of these come in it's
> -			 * probably best that we log them somewhere:
> -			 */
> -			dev_err_ratelimited(&ctx->afu->dev, "CXL AFU Error "
> -					    "undelivered to pe %i: 0x%016llx\n",
> -					    ctx->pe, irq_info->afu_err);
> -		} else {
> -			spin_lock(&ctx->lock);
> -			ctx->afu_err = irq_info->afu_err;
> -			ctx->pending_afu_err = true;
> -			spin_unlock(&ctx->lock);
> -
> -			wake_up_all(&ctx->wq);
> -		}
> -
> -		cxl_ops->ack_irq(ctx, CXL_PSL_TFC_An_A, 0);
> -		return IRQ_HANDLED;
> -	}
> -	if (dsisr & CXL_PSL_DSISR_An_OC)
> -		pr_devel("CXL interrupt: OS Context Warning\n");
> -
> -	WARN(1, "Unhandled CXL PSL IRQ\n");
> -	return IRQ_HANDLED;
> -}
> -
> -static irqreturn_t cxl_irq_afu(int irq, void *data)
> -{
> -	struct cxl_context *ctx = data;
> -	irq_hw_number_t hwirq = irqd_to_hwirq(irq_get_irq_data(irq));
> -	int irq_off, afu_irq = 0;
> -	__u16 range;
> -	int r;
> -
> -	/*
> -	 * Look for the interrupt number.
> -	 * On bare-metal, we know range 0 only contains the PSL
> -	 * interrupt so we could start counting at range 1 and initialize
> -	 * afu_irq at 1.
> -	 * In a guest, range 0 also contains AFU interrupts, so it must
> -	 * be counted for. Therefore we initialize afu_irq at 0 to take into
> -	 * account the PSL interrupt.
> -	 *
> -	 * For code-readability, it just seems easier to go over all
> -	 * the ranges on bare-metal and guest. The end result is the same.
> -	 */
> -	for (r = 0; r < CXL_IRQ_RANGES; r++) {
> -		irq_off = hwirq - ctx->irqs.offset[r];
> -		range = ctx->irqs.range[r];
> -		if (irq_off >= 0 && irq_off < range) {
> -			afu_irq += irq_off;
> -			break;
> -		}
> -		afu_irq += range;
> -	}
> -	if (unlikely(r >= CXL_IRQ_RANGES)) {
> -		WARN(1, "Received AFU IRQ out of range for pe %i (virq %i hwirq %lx)\n",
> -		     ctx->pe, irq, hwirq);
> -		return IRQ_HANDLED;
> -	}
> -
> -	trace_cxl_afu_irq(ctx, afu_irq, irq, hwirq);
> -	pr_devel("Received AFU interrupt %i for pe: %i (virq %i hwirq %lx)\n",
> -	       afu_irq, ctx->pe, irq, hwirq);
> -
> -	if (unlikely(!ctx->irq_bitmap)) {
> -		WARN(1, "Received AFU IRQ for context with no IRQ bitmap\n");
> -		return IRQ_HANDLED;
> -	}
> -	spin_lock(&ctx->lock);
> -	set_bit(afu_irq - 1, ctx->irq_bitmap);
> -	ctx->pending_irq = true;
> -	spin_unlock(&ctx->lock);
> -
> -	wake_up_all(&ctx->wq);
> -
> -	return IRQ_HANDLED;
> -}
> -
> -unsigned int cxl_map_irq(struct cxl *adapter, irq_hw_number_t hwirq,
> -			 irq_handler_t handler, void *cookie, const char *name)
> -{
> -	unsigned int virq;
> -	int result;
> -
> -	/* IRQ Domain? */
> -	virq = irq_create_mapping(NULL, hwirq);
> -	if (!virq) {
> -		dev_warn(&adapter->dev, "cxl_map_irq: irq_create_mapping failed\n");
> -		return 0;
> -	}
> -
> -	if (cxl_ops->setup_irq)
> -		cxl_ops->setup_irq(adapter, hwirq, virq);
> -
> -	pr_devel("hwirq %#lx mapped to virq %u\n", hwirq, virq);
> -
> -	result = request_irq(virq, handler, 0, name, cookie);
> -	if (result) {
> -		dev_warn(&adapter->dev, "cxl_map_irq: request_irq failed: %i\n", result);
> -		return 0;
> -	}
> -
> -	return virq;
> -}
> -
> -void cxl_unmap_irq(unsigned int virq, void *cookie)
> -{
> -	free_irq(virq, cookie);
> -}
> -
> -int cxl_register_one_irq(struct cxl *adapter,
> -			irq_handler_t handler,
> -			void *cookie,
> -			irq_hw_number_t *dest_hwirq,
> -			unsigned int *dest_virq,
> -			const char *name)
> -{
> -	int hwirq, virq;
> -
> -	if ((hwirq = cxl_ops->alloc_one_irq(adapter)) < 0)
> -		return hwirq;
> -
> -	if (!(virq = cxl_map_irq(adapter, hwirq, handler, cookie, name)))
> -		goto err;
> -
> -	*dest_hwirq = hwirq;
> -	*dest_virq = virq;
> -
> -	return 0;
> -
> -err:
> -	cxl_ops->release_one_irq(adapter, hwirq);
> -	return -ENOMEM;
> -}
> -
> -void afu_irq_name_free(struct cxl_context *ctx)
> -{
> -	struct cxl_irq_name *irq_name, *tmp;
> -
> -	list_for_each_entry_safe(irq_name, tmp, &ctx->irq_names, list) {
> -		kfree(irq_name->name);
> -		list_del(&irq_name->list);
> -		kfree(irq_name);
> -	}
> -}
> -
> -int afu_allocate_irqs(struct cxl_context *ctx, u32 count)
> -{
> -	int rc, r, i, j = 1;
> -	struct cxl_irq_name *irq_name;
> -	int alloc_count;
> -
> -	/*
> -	 * In native mode, range 0 is reserved for the multiplexed
> -	 * PSL interrupt. It has been allocated when the AFU was initialized.
> -	 *
> -	 * In a guest, the PSL interrupt is not mutliplexed, but per-context,
> -	 * and is the first interrupt from range 0. It still needs to be
> -	 * allocated, so bump the count by one.
> -	 */
> -	if (cpu_has_feature(CPU_FTR_HVMODE))
> -		alloc_count = count;
> -	else
> -		alloc_count = count + 1;
> -
> -	if ((rc = cxl_ops->alloc_irq_ranges(&ctx->irqs, ctx->afu->adapter,
> -							alloc_count)))
> -		return rc;
> -
> -	if (cpu_has_feature(CPU_FTR_HVMODE)) {
> -		/* Multiplexed PSL Interrupt */
> -		ctx->irqs.offset[0] = ctx->afu->native->psl_hwirq;
> -		ctx->irqs.range[0] = 1;
> -	}
> -
> -	ctx->irq_count = count;
> -	ctx->irq_bitmap = bitmap_zalloc(count, GFP_KERNEL);
> -	if (!ctx->irq_bitmap)
> -		goto out;
> -
> -	/*
> -	 * Allocate names first.  If any fail, bail out before allocating
> -	 * actual hardware IRQs.
> -	 */
> -	for (r = afu_irq_range_start(); r < CXL_IRQ_RANGES; r++) {
> -		for (i = 0; i < ctx->irqs.range[r]; i++) {
> -			irq_name = kmalloc(sizeof(struct cxl_irq_name),
> -					   GFP_KERNEL);
> -			if (!irq_name)
> -				goto out;
> -			irq_name->name = kasprintf(GFP_KERNEL, "cxl-%s-pe%i-%i",
> -						   dev_name(&ctx->afu->dev),
> -						   ctx->pe, j);
> -			if (!irq_name->name) {
> -				kfree(irq_name);
> -				goto out;
> -			}
> -			/* Add to tail so next look get the correct order */
> -			list_add_tail(&irq_name->list, &ctx->irq_names);
> -			j++;
> -		}
> -	}
> -	return 0;
> -
> -out:
> -	cxl_ops->release_irq_ranges(&ctx->irqs, ctx->afu->adapter);
> -	bitmap_free(ctx->irq_bitmap);
> -	afu_irq_name_free(ctx);
> -	return -ENOMEM;
> -}
> -
> -static void afu_register_hwirqs(struct cxl_context *ctx)
> -{
> -	irq_hw_number_t hwirq;
> -	struct cxl_irq_name *irq_name;
> -	int r, i;
> -	irqreturn_t (*handler)(int irq, void *data);
> -
> -	/* We've allocated all memory now, so let's do the irq allocations */
> -	irq_name = list_first_entry(&ctx->irq_names, struct cxl_irq_name, list);
> -	for (r = afu_irq_range_start(); r < CXL_IRQ_RANGES; r++) {
> -		hwirq = ctx->irqs.offset[r];
> -		for (i = 0; i < ctx->irqs.range[r]; hwirq++, i++) {
> -			if (r == 0 && i == 0)
> -				/*
> -				 * The very first interrupt of range 0 is
> -				 * always the PSL interrupt, but we only
> -				 * need to connect a handler for guests,
> -				 * because there's one PSL interrupt per
> -				 * context.
> -				 * On bare-metal, the PSL interrupt is
> -				 * multiplexed and was setup when the AFU
> -				 * was configured.
> -				 */
> -				handler = cxl_ops->psl_interrupt;
> -			else
> -				handler = cxl_irq_afu;
> -			cxl_map_irq(ctx->afu->adapter, hwirq, handler, ctx,
> -				irq_name->name);
> -			irq_name = list_next_entry(irq_name, list);
> -		}
> -	}
> -}
> -
> -int afu_register_irqs(struct cxl_context *ctx, u32 count)
> -{
> -	int rc;
> -
> -	rc = afu_allocate_irqs(ctx, count);
> -	if (rc)
> -		return rc;
> -
> -	afu_register_hwirqs(ctx);
> -	return 0;
> -}
> -
> -void afu_release_irqs(struct cxl_context *ctx, void *cookie)
> -{
> -	irq_hw_number_t hwirq;
> -	unsigned int virq;
> -	int r, i;
> -
> -	for (r = afu_irq_range_start(); r < CXL_IRQ_RANGES; r++) {
> -		hwirq = ctx->irqs.offset[r];
> -		for (i = 0; i < ctx->irqs.range[r]; hwirq++, i++) {
> -			virq = irq_find_mapping(NULL, hwirq);
> -			if (virq)
> -				cxl_unmap_irq(virq, cookie);
> -		}
> -	}
> -
> -	afu_irq_name_free(ctx);
> -	cxl_ops->release_irq_ranges(&ctx->irqs, ctx->afu->adapter);
> -
> -	ctx->irq_count = 0;
> -}
> -
> -void cxl_afu_decode_psl_serr(struct cxl_afu *afu, u64 serr)
> -{
> -	dev_crit(&afu->dev,
> -		 "PSL Slice error received. Check AFU for root cause.\n");
> -	dev_crit(&afu->dev, "PSL_SERR_An: 0x%016llx\n", serr);
> -	if (serr & CXL_PSL_SERR_An_afuto)
> -		dev_crit(&afu->dev, "AFU MMIO Timeout\n");
> -	if (serr & CXL_PSL_SERR_An_afudis)
> -		dev_crit(&afu->dev,
> -			 "MMIO targeted Accelerator that was not enabled\n");
> -	if (serr & CXL_PSL_SERR_An_afuov)
> -		dev_crit(&afu->dev, "AFU CTAG Overflow\n");
> -	if (serr & CXL_PSL_SERR_An_badsrc)
> -		dev_crit(&afu->dev, "Bad Interrupt Source\n");
> -	if (serr & CXL_PSL_SERR_An_badctx)
> -		dev_crit(&afu->dev, "Bad Context Handle\n");
> -	if (serr & CXL_PSL_SERR_An_llcmdis)
> -		dev_crit(&afu->dev, "LLCMD to Disabled AFU\n");
> -	if (serr & CXL_PSL_SERR_An_llcmdto)
> -		dev_crit(&afu->dev, "LLCMD Timeout to AFU\n");
> -	if (serr & CXL_PSL_SERR_An_afupar)
> -		dev_crit(&afu->dev, "AFU MMIO Parity Error\n");
> -	if (serr & CXL_PSL_SERR_An_afudup)
> -		dev_crit(&afu->dev, "AFU MMIO Duplicate CTAG Error\n");
> -	if (serr & CXL_PSL_SERR_An_AE)
> -		dev_crit(&afu->dev,
> -			 "AFU asserted JDONE with JERROR in AFU Directed Mode\n");
> -}
> diff --git a/drivers/misc/cxl/main.c b/drivers/misc/cxl/main.c
> deleted file mode 100644
> index c1fbf6f588f7..000000000000
> --- a/drivers/misc/cxl/main.c
> +++ /dev/null
> @@ -1,383 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * Copyright 2014 IBM Corp.
> - */
> -
> -#include <linux/spinlock.h>
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/device.h>
> -#include <linux/mutex.h>
> -#include <linux/init.h>
> -#include <linux/list.h>
> -#include <linux/mm.h>
> -#include <linux/of.h>
> -#include <linux/slab.h>
> -#include <linux/idr.h>
> -#include <linux/pci.h>
> -#include <linux/platform_device.h>
> -#include <linux/sched/task.h>
> -
> -#include <asm/cputable.h>
> -#include <asm/mmu.h>
> -#include <misc/cxl-base.h>
> -
> -#include "cxl.h"
> -#include "trace.h"
> -
> -static DEFINE_SPINLOCK(adapter_idr_lock);
> -static DEFINE_IDR(cxl_adapter_idr);
> -
> -uint cxl_verbose;
> -module_param_named(verbose, cxl_verbose, uint, 0600);
> -MODULE_PARM_DESC(verbose, "Enable verbose dmesg output");
> -
> -const struct cxl_backend_ops *cxl_ops;
> -
> -int cxl_afu_slbia(struct cxl_afu *afu)
> -{
> -	unsigned long timeout = jiffies + (HZ * CXL_TIMEOUT);
> -
> -	pr_devel("cxl_afu_slbia issuing SLBIA command\n");
> -	cxl_p2n_write(afu, CXL_SLBIA_An, CXL_TLB_SLB_IQ_ALL);
> -	while (cxl_p2n_read(afu, CXL_SLBIA_An) & CXL_TLB_SLB_P) {
> -		if (time_after_eq(jiffies, timeout)) {
> -			dev_warn(&afu->dev, "WARNING: CXL AFU SLBIA timed out!\n");
> -			return -EBUSY;
> -		}
> -		/* If the adapter has gone down, we can assume that we
> -		 * will PERST it and that will invalidate everything.
> -		 */
> -		if (!cxl_ops->link_ok(afu->adapter, afu))
> -			return -EIO;
> -		cpu_relax();
> -	}
> -	return 0;
> -}
> -
> -static inline void _cxl_slbia(struct cxl_context *ctx, struct mm_struct *mm)
> -{
> -	unsigned long flags;
> -
> -	if (ctx->mm != mm)
> -		return;
> -
> -	pr_devel("%s matched mm - card: %i afu: %i pe: %i\n", __func__,
> -		 ctx->afu->adapter->adapter_num, ctx->afu->slice, ctx->pe);
> -
> -	spin_lock_irqsave(&ctx->sste_lock, flags);
> -	trace_cxl_slbia(ctx);
> -	memset(ctx->sstp, 0, ctx->sst_size);
> -	spin_unlock_irqrestore(&ctx->sste_lock, flags);
> -	mb();
> -	cxl_afu_slbia(ctx->afu);
> -}
> -
> -static inline void cxl_slbia_core(struct mm_struct *mm)
> -{
> -	struct cxl *adapter;
> -	struct cxl_afu *afu;
> -	struct cxl_context *ctx;
> -	int card, slice, id;
> -
> -	pr_devel("%s called\n", __func__);
> -
> -	spin_lock(&adapter_idr_lock);
> -	idr_for_each_entry(&cxl_adapter_idr, adapter, card) {
> -		/* XXX: Make this lookup faster with link from mm to ctx */
> -		spin_lock(&adapter->afu_list_lock);
> -		for (slice = 0; slice < adapter->slices; slice++) {
> -			afu = adapter->afu[slice];
> -			if (!afu || !afu->enabled)
> -				continue;
> -			rcu_read_lock();
> -			idr_for_each_entry(&afu->contexts_idr, ctx, id)
> -				_cxl_slbia(ctx, mm);
> -			rcu_read_unlock();
> -		}
> -		spin_unlock(&adapter->afu_list_lock);
> -	}
> -	spin_unlock(&adapter_idr_lock);
> -}
> -
> -static struct cxl_calls cxl_calls = {
> -	.cxl_slbia = cxl_slbia_core,
> -	.owner = THIS_MODULE,
> -};
> -
> -int cxl_alloc_sst(struct cxl_context *ctx)
> -{
> -	unsigned long vsid;
> -	u64 ea_mask, size, sstp0, sstp1;
> -
> -	sstp0 = 0;
> -	sstp1 = 0;
> -
> -	ctx->sst_size = PAGE_SIZE;
> -	ctx->sst_lru = 0;
> -	ctx->sstp = (struct cxl_sste *)get_zeroed_page(GFP_KERNEL);
> -	if (!ctx->sstp) {
> -		pr_err("cxl_alloc_sst: Unable to allocate segment table\n");
> -		return -ENOMEM;
> -	}
> -	pr_devel("SSTP allocated at 0x%p\n", ctx->sstp);
> -
> -	vsid  = get_kernel_vsid((u64)ctx->sstp, mmu_kernel_ssize) << 12;
> -
> -	sstp0 |= (u64)mmu_kernel_ssize << CXL_SSTP0_An_B_SHIFT;
> -	sstp0 |= (SLB_VSID_KERNEL | mmu_psize_defs[mmu_linear_psize].sllp) << 50;
> -
> -	size = (((u64)ctx->sst_size >> 8) - 1) << CXL_SSTP0_An_SegTableSize_SHIFT;
> -	if (unlikely(size & ~CXL_SSTP0_An_SegTableSize_MASK)) {
> -		WARN(1, "Impossible segment table size\n");
> -		return -EINVAL;
> -	}
> -	sstp0 |= size;
> -
> -	if (mmu_kernel_ssize == MMU_SEGSIZE_256M)
> -		ea_mask = 0xfffff00ULL;
> -	else
> -		ea_mask = 0xffffffff00ULL;
> -
> -	sstp0 |=  vsid >>     (50-14);  /*   Top 14 bits of VSID */
> -	sstp1 |= (vsid << (64-(50-14))) & ~ea_mask;
> -	sstp1 |= (u64)ctx->sstp & ea_mask;
> -	sstp1 |= CXL_SSTP1_An_V;
> -
> -	pr_devel("Looked up %#llx: slbfee. %#llx (ssize: %x, vsid: %#lx), copied to SSTP0: %#llx, SSTP1: %#llx\n",
> -			(u64)ctx->sstp, (u64)ctx->sstp & ESID_MASK, mmu_kernel_ssize, vsid, sstp0, sstp1);
> -
> -	/* Store calculated sstp hardware points for use later */
> -	ctx->sstp0 = sstp0;
> -	ctx->sstp1 = sstp1;
> -
> -	return 0;
> -}
> -
> -/* print buffer content as integers when debugging */
> -void cxl_dump_debug_buffer(void *buf, size_t buf_len)
> -{
> -#ifdef DEBUG
> -	int i, *ptr;
> -
> -	/*
> -	 * We want to regroup up to 4 integers per line, which means they
> -	 * need to be in the same pr_devel() statement
> -	 */
> -	ptr = (int *) buf;
> -	for (i = 0; i * 4 < buf_len; i += 4) {
> -		if ((i + 3) * 4 < buf_len)
> -			pr_devel("%.8x %.8x %.8x %.8x\n", ptr[i], ptr[i + 1],
> -				ptr[i + 2], ptr[i + 3]);
> -		else if ((i + 2) * 4 < buf_len)
> -			pr_devel("%.8x %.8x %.8x\n", ptr[i], ptr[i + 1],
> -				ptr[i + 2]);
> -		else if ((i + 1) * 4 < buf_len)
> -			pr_devel("%.8x %.8x\n", ptr[i], ptr[i + 1]);
> -		else
> -			pr_devel("%.8x\n", ptr[i]);
> -	}
> -#endif /* DEBUG */
> -}
> -
> -/* Find a CXL adapter by it's number and increase it's refcount */
> -struct cxl *get_cxl_adapter(int num)
> -{
> -	struct cxl *adapter;
> -
> -	spin_lock(&adapter_idr_lock);
> -	if ((adapter = idr_find(&cxl_adapter_idr, num)))
> -		get_device(&adapter->dev);
> -	spin_unlock(&adapter_idr_lock);
> -
> -	return adapter;
> -}
> -
> -static int cxl_alloc_adapter_nr(struct cxl *adapter)
> -{
> -	int i;
> -
> -	idr_preload(GFP_KERNEL);
> -	spin_lock(&adapter_idr_lock);
> -	i = idr_alloc(&cxl_adapter_idr, adapter, 0, 0, GFP_NOWAIT);
> -	spin_unlock(&adapter_idr_lock);
> -	idr_preload_end();
> -	if (i < 0)
> -		return i;
> -
> -	adapter->adapter_num = i;
> -
> -	return 0;
> -}
> -
> -void cxl_remove_adapter_nr(struct cxl *adapter)
> -{
> -	idr_remove(&cxl_adapter_idr, adapter->adapter_num);
> -}
> -
> -struct cxl *cxl_alloc_adapter(void)
> -{
> -	struct cxl *adapter;
> -
> -	if (!(adapter = kzalloc(sizeof(struct cxl), GFP_KERNEL)))
> -		return NULL;
> -
> -	spin_lock_init(&adapter->afu_list_lock);
> -
> -	if (cxl_alloc_adapter_nr(adapter))
> -		goto err1;
> -
> -	if (dev_set_name(&adapter->dev, "card%i", adapter->adapter_num))
> -		goto err2;
> -
> -	/* start with context lock taken */
> -	atomic_set(&adapter->contexts_num, -1);
> -
> -	return adapter;
> -err2:
> -	cxl_remove_adapter_nr(adapter);
> -err1:
> -	kfree(adapter);
> -	return NULL;
> -}
> -
> -struct cxl_afu *cxl_alloc_afu(struct cxl *adapter, int slice)
> -{
> -	struct cxl_afu *afu;
> -
> -	if (!(afu = kzalloc(sizeof(struct cxl_afu), GFP_KERNEL)))
> -		return NULL;
> -
> -	afu->adapter = adapter;
> -	afu->dev.parent = &adapter->dev;
> -	afu->dev.release = cxl_ops->release_afu;
> -	afu->slice = slice;
> -	idr_init(&afu->contexts_idr);
> -	mutex_init(&afu->contexts_lock);
> -	spin_lock_init(&afu->afu_cntl_lock);
> -	atomic_set(&afu->configured_state, -1);
> -	afu->prefault_mode = CXL_PREFAULT_NONE;
> -	afu->irqs_max = afu->adapter->user_irqs;
> -
> -	return afu;
> -}
> -
> -int cxl_afu_select_best_mode(struct cxl_afu *afu)
> -{
> -	if (afu->modes_supported & CXL_MODE_DIRECTED)
> -		return cxl_ops->afu_activate_mode(afu, CXL_MODE_DIRECTED);
> -
> -	if (afu->modes_supported & CXL_MODE_DEDICATED)
> -		return cxl_ops->afu_activate_mode(afu, CXL_MODE_DEDICATED);
> -
> -	dev_warn(&afu->dev, "No supported programming modes available\n");
> -	/* We don't fail this so the user can inspect sysfs */
> -	return 0;
> -}
> -
> -int cxl_adapter_context_get(struct cxl *adapter)
> -{
> -	int rc;
> -
> -	rc = atomic_inc_unless_negative(&adapter->contexts_num);
> -	return rc ? 0 : -EBUSY;
> -}
> -
> -void cxl_adapter_context_put(struct cxl *adapter)
> -{
> -	atomic_dec_if_positive(&adapter->contexts_num);
> -}
> -
> -int cxl_adapter_context_lock(struct cxl *adapter)
> -{
> -	int rc;
> -	/* no active contexts -> contexts_num == 0 */
> -	rc = atomic_cmpxchg(&adapter->contexts_num, 0, -1);
> -	return rc ? -EBUSY : 0;
> -}
> -
> -void cxl_adapter_context_unlock(struct cxl *adapter)
> -{
> -	int val = atomic_cmpxchg(&adapter->contexts_num, -1, 0);
> -
> -	/*
> -	 * contexts lock taken -> contexts_num == -1
> -	 * If not true then show a warning and force reset the lock.
> -	 * This will happen when context_unlock was requested without
> -	 * doing a context_lock.
> -	 */
> -	if (val != -1) {
> -		atomic_set(&adapter->contexts_num, 0);
> -		WARN(1, "Adapter context unlocked with %d active contexts",
> -		     val);
> -	}
> -}
> -
> -static int __init init_cxl(void)
> -{
> -	int rc = 0;
> -
> -	if (!tlbie_capable)
> -		return -EINVAL;
> -
> -	if ((rc = cxl_file_init()))
> -		return rc;
> -
> -	cxl_debugfs_init();
> -
> -	/*
> -	 * we don't register the callback on P9. slb callack is only
> -	 * used for the PSL8 MMU and CX4.
> -	 */
> -	if (cxl_is_power8()) {
> -		rc = register_cxl_calls(&cxl_calls);
> -		if (rc)
> -			goto err;
> -	}
> -
> -	if (cpu_has_feature(CPU_FTR_HVMODE)) {
> -		cxl_ops = &cxl_native_ops;
> -		rc = pci_register_driver(&cxl_pci_driver);
> -	}
> -#ifdef CONFIG_PPC_PSERIES
> -	else {
> -		cxl_ops = &cxl_guest_ops;
> -		rc = platform_driver_register(&cxl_of_driver);
> -	}
> -#endif
> -	if (rc)
> -		goto err1;
> -
> -	return 0;
> -err1:
> -	if (cxl_is_power8())
> -		unregister_cxl_calls(&cxl_calls);
> -err:
> -	cxl_debugfs_exit();
> -	cxl_file_exit();
> -
> -	return rc;
> -}
> -
> -static void exit_cxl(void)
> -{
> -	if (cpu_has_feature(CPU_FTR_HVMODE))
> -		pci_unregister_driver(&cxl_pci_driver);
> -#ifdef CONFIG_PPC_PSERIES
> -	else
> -		platform_driver_unregister(&cxl_of_driver);
> -#endif
> -
> -	cxl_debugfs_exit();
> -	cxl_file_exit();
> -	if (cxl_is_power8())
> -		unregister_cxl_calls(&cxl_calls);
> -	idr_destroy(&cxl_adapter_idr);
> -}
> -
> -module_init(init_cxl);
> -module_exit(exit_cxl);
> -
> -MODULE_DESCRIPTION("IBM Coherent Accelerator");
> -MODULE_AUTHOR("Ian Munsie <imunsie@au1.ibm.com>");
> -MODULE_LICENSE("GPL");
> diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
> deleted file mode 100644
> index fbe16a6ab7ad..000000000000
> --- a/drivers/misc/cxl/native.c
> +++ /dev/null
> @@ -1,1592 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * Copyright 2014 IBM Corp.
> - */
> -
> -#include <linux/spinlock.h>
> -#include <linux/sched.h>
> -#include <linux/sched/clock.h>
> -#include <linux/slab.h>
> -#include <linux/mutex.h>
> -#include <linux/mm.h>
> -#include <linux/uaccess.h>
> -#include <linux/delay.h>
> -#include <linux/irqdomain.h>
> -#include <asm/synch.h>
> -#include <asm/switch_to.h>
> -#include <misc/cxl-base.h>
> -
> -#include "cxl.h"
> -#include "trace.h"
> -
> -static int afu_control(struct cxl_afu *afu, u64 command, u64 clear,
> -		       u64 result, u64 mask, bool enabled)
> -{
> -	u64 AFU_Cntl;
> -	unsigned long timeout = jiffies + (HZ * CXL_TIMEOUT);
> -	int rc = 0;
> -
> -	spin_lock(&afu->afu_cntl_lock);
> -	pr_devel("AFU command starting: %llx\n", command);
> -
> -	trace_cxl_afu_ctrl(afu, command);
> -
> -	AFU_Cntl = cxl_p2n_read(afu, CXL_AFU_Cntl_An);
> -	cxl_p2n_write(afu, CXL_AFU_Cntl_An, (AFU_Cntl & ~clear) | command);
> -
> -	AFU_Cntl = cxl_p2n_read(afu, CXL_AFU_Cntl_An);
> -	while ((AFU_Cntl & mask) != result) {
> -		if (time_after_eq(jiffies, timeout)) {
> -			dev_warn(&afu->dev, "WARNING: AFU control timed out!\n");
> -			rc = -EBUSY;
> -			goto out;
> -		}
> -
> -		if (!cxl_ops->link_ok(afu->adapter, afu)) {
> -			afu->enabled = enabled;
> -			rc = -EIO;
> -			goto out;
> -		}
> -
> -		pr_devel_ratelimited("AFU control... (0x%016llx)\n",
> -				     AFU_Cntl | command);
> -		cpu_relax();
> -		AFU_Cntl = cxl_p2n_read(afu, CXL_AFU_Cntl_An);
> -	}
> -
> -	if (AFU_Cntl & CXL_AFU_Cntl_An_RA) {
> -		/*
> -		 * Workaround for a bug in the XSL used in the Mellanox CX4
> -		 * that fails to clear the RA bit after an AFU reset,
> -		 * preventing subsequent AFU resets from working.
> -		 */
> -		cxl_p2n_write(afu, CXL_AFU_Cntl_An, AFU_Cntl & ~CXL_AFU_Cntl_An_RA);
> -	}
> -
> -	pr_devel("AFU command complete: %llx\n", command);
> -	afu->enabled = enabled;
> -out:
> -	trace_cxl_afu_ctrl_done(afu, command, rc);
> -	spin_unlock(&afu->afu_cntl_lock);
> -
> -	return rc;
> -}
> -
> -static int afu_enable(struct cxl_afu *afu)
> -{
> -	pr_devel("AFU enable request\n");
> -
> -	return afu_control(afu, CXL_AFU_Cntl_An_E, 0,
> -			   CXL_AFU_Cntl_An_ES_Enabled,
> -			   CXL_AFU_Cntl_An_ES_MASK, true);
> -}
> -
> -int cxl_afu_disable(struct cxl_afu *afu)
> -{
> -	pr_devel("AFU disable request\n");
> -
> -	return afu_control(afu, 0, CXL_AFU_Cntl_An_E,
> -			   CXL_AFU_Cntl_An_ES_Disabled,
> -			   CXL_AFU_Cntl_An_ES_MASK, false);
> -}
> -
> -/* This will disable as well as reset */
> -static int native_afu_reset(struct cxl_afu *afu)
> -{
> -	int rc;
> -	u64 serr;
> -
> -	pr_devel("AFU reset request\n");
> -
> -	rc = afu_control(afu, CXL_AFU_Cntl_An_RA, 0,
> -			   CXL_AFU_Cntl_An_RS_Complete | CXL_AFU_Cntl_An_ES_Disabled,
> -			   CXL_AFU_Cntl_An_RS_MASK | CXL_AFU_Cntl_An_ES_MASK,
> -			   false);
> -
> -	/*
> -	 * Re-enable any masked interrupts when the AFU is not
> -	 * activated to avoid side effects after attaching a process
> -	 * in dedicated mode.
> -	 */
> -	if (afu->current_mode == 0) {
> -		serr = cxl_p1n_read(afu, CXL_PSL_SERR_An);
> -		serr &= ~CXL_PSL_SERR_An_IRQ_MASKS;
> -		cxl_p1n_write(afu, CXL_PSL_SERR_An, serr);
> -	}
> -
> -	return rc;
> -}
> -
> -static int native_afu_check_and_enable(struct cxl_afu *afu)
> -{
> -	if (!cxl_ops->link_ok(afu->adapter, afu)) {
> -		WARN(1, "Refusing to enable afu while link down!\n");
> -		return -EIO;
> -	}
> -	if (afu->enabled)
> -		return 0;
> -	return afu_enable(afu);
> -}
> -
> -int cxl_psl_purge(struct cxl_afu *afu)
> -{
> -	u64 PSL_CNTL = cxl_p1n_read(afu, CXL_PSL_SCNTL_An);
> -	u64 AFU_Cntl = cxl_p2n_read(afu, CXL_AFU_Cntl_An);
> -	u64 dsisr, dar;
> -	u64 start, end;
> -	u64 trans_fault = 0x0ULL;
> -	unsigned long timeout = jiffies + (HZ * CXL_TIMEOUT);
> -	int rc = 0;
> -
> -	trace_cxl_psl_ctrl(afu, CXL_PSL_SCNTL_An_Pc);
> -
> -	pr_devel("PSL purge request\n");
> -
> -	if (cxl_is_power8())
> -		trans_fault = CXL_PSL_DSISR_TRANS;
> -	if (cxl_is_power9())
> -		trans_fault = CXL_PSL9_DSISR_An_TF;
> -
> -	if (!cxl_ops->link_ok(afu->adapter, afu)) {
> -		dev_warn(&afu->dev, "PSL Purge called with link down, ignoring\n");
> -		rc = -EIO;
> -		goto out;
> -	}
> -
> -	if ((AFU_Cntl & CXL_AFU_Cntl_An_ES_MASK) != CXL_AFU_Cntl_An_ES_Disabled) {
> -		WARN(1, "psl_purge request while AFU not disabled!\n");
> -		cxl_afu_disable(afu);
> -	}
> -
> -	cxl_p1n_write(afu, CXL_PSL_SCNTL_An,
> -		       PSL_CNTL | CXL_PSL_SCNTL_An_Pc);
> -	start = local_clock();
> -	PSL_CNTL = cxl_p1n_read(afu, CXL_PSL_SCNTL_An);
> -	while ((PSL_CNTL &  CXL_PSL_SCNTL_An_Ps_MASK)
> -			== CXL_PSL_SCNTL_An_Ps_Pending) {
> -		if (time_after_eq(jiffies, timeout)) {
> -			dev_warn(&afu->dev, "WARNING: PSL Purge timed out!\n");
> -			rc = -EBUSY;
> -			goto out;
> -		}
> -		if (!cxl_ops->link_ok(afu->adapter, afu)) {
> -			rc = -EIO;
> -			goto out;
> -		}
> -
> -		dsisr = cxl_p2n_read(afu, CXL_PSL_DSISR_An);
> -		pr_devel_ratelimited("PSL purging... PSL_CNTL: 0x%016llx  PSL_DSISR: 0x%016llx\n",
> -				     PSL_CNTL, dsisr);
> -
> -		if (dsisr & trans_fault) {
> -			dar = cxl_p2n_read(afu, CXL_PSL_DAR_An);
> -			dev_notice(&afu->dev, "PSL purge terminating pending translation, DSISR: 0x%016llx, DAR: 0x%016llx\n",
> -				   dsisr, dar);
> -			cxl_p2n_write(afu, CXL_PSL_TFC_An, CXL_PSL_TFC_An_AE);
> -		} else if (dsisr) {
> -			dev_notice(&afu->dev, "PSL purge acknowledging pending non-translation fault, DSISR: 0x%016llx\n",
> -				   dsisr);
> -			cxl_p2n_write(afu, CXL_PSL_TFC_An, CXL_PSL_TFC_An_A);
> -		} else {
> -			cpu_relax();
> -		}
> -		PSL_CNTL = cxl_p1n_read(afu, CXL_PSL_SCNTL_An);
> -	}
> -	end = local_clock();
> -	pr_devel("PSL purged in %lld ns\n", end - start);
> -
> -	cxl_p1n_write(afu, CXL_PSL_SCNTL_An,
> -		       PSL_CNTL & ~CXL_PSL_SCNTL_An_Pc);
> -out:
> -	trace_cxl_psl_ctrl_done(afu, CXL_PSL_SCNTL_An_Pc, rc);
> -	return rc;
> -}
> -
> -static int spa_max_procs(int spa_size)
> -{
> -	/*
> -	 * From the CAIA:
> -	 *    end_of_SPA_area = SPA_Base + ((n+4) * 128) + (( ((n*8) + 127) >> 7) * 128) + 255
> -	 * Most of that junk is really just an overly-complicated way of saying
> -	 * the last 256 bytes are __aligned(128), so it's really:
> -	 *    end_of_SPA_area = end_of_PSL_queue_area + __aligned(128) 255
> -	 * and
> -	 *    end_of_PSL_queue_area = SPA_Base + ((n+4) * 128) + (n*8) - 1
> -	 * so
> -	 *    sizeof(SPA) = ((n+4) * 128) + (n*8) + __aligned(128) 256
> -	 * Ignore the alignment (which is safe in this case as long as we are
> -	 * careful with our rounding) and solve for n:
> -	 */
> -	return ((spa_size / 8) - 96) / 17;
> -}
> -
> -static int cxl_alloc_spa(struct cxl_afu *afu, int mode)
> -{
> -	unsigned spa_size;
> -
> -	/* Work out how many pages to allocate */
> -	afu->native->spa_order = -1;
> -	do {
> -		afu->native->spa_order++;
> -		spa_size = (1 << afu->native->spa_order) * PAGE_SIZE;
> -
> -		if (spa_size > 0x100000) {
> -			dev_warn(&afu->dev, "num_of_processes too large for the SPA, limiting to %i (0x%x)\n",
> -					afu->native->spa_max_procs, afu->native->spa_size);
> -			if (mode != CXL_MODE_DEDICATED)
> -				afu->num_procs = afu->native->spa_max_procs;
> -			break;
> -		}
> -
> -		afu->native->spa_size = spa_size;
> -		afu->native->spa_max_procs = spa_max_procs(afu->native->spa_size);
> -	} while (afu->native->spa_max_procs < afu->num_procs);
> -
> -	if (!(afu->native->spa = (struct cxl_process_element *)
> -	      __get_free_pages(GFP_KERNEL | __GFP_ZERO, afu->native->spa_order))) {
> -		pr_err("cxl_alloc_spa: Unable to allocate scheduled process area\n");
> -		return -ENOMEM;
> -	}
> -	pr_devel("spa pages: %i afu->spa_max_procs: %i   afu->num_procs: %i\n",
> -		 1<<afu->native->spa_order, afu->native->spa_max_procs, afu->num_procs);
> -
> -	return 0;
> -}
> -
> -static void attach_spa(struct cxl_afu *afu)
> -{
> -	u64 spap;
> -
> -	afu->native->sw_command_status = (__be64 *)((char *)afu->native->spa +
> -					    ((afu->native->spa_max_procs + 3) * 128));
> -
> -	spap = virt_to_phys(afu->native->spa) & CXL_PSL_SPAP_Addr;
> -	spap |= ((afu->native->spa_size >> (12 - CXL_PSL_SPAP_Size_Shift)) - 1) & CXL_PSL_SPAP_Size;
> -	spap |= CXL_PSL_SPAP_V;
> -	pr_devel("cxl: SPA allocated at 0x%p. Max processes: %i, sw_command_status: 0x%p CXL_PSL_SPAP_An=0x%016llx\n",
> -		afu->native->spa, afu->native->spa_max_procs,
> -		afu->native->sw_command_status, spap);
> -	cxl_p1n_write(afu, CXL_PSL_SPAP_An, spap);
> -}
> -
> -void cxl_release_spa(struct cxl_afu *afu)
> -{
> -	if (afu->native->spa) {
> -		free_pages((unsigned long) afu->native->spa,
> -			afu->native->spa_order);
> -		afu->native->spa = NULL;
> -	}
> -}
> -
> -/*
> - * Invalidation of all ERAT entries is no longer required by CAIA2. Use
> - * only for debug.
> - */
> -int cxl_invalidate_all_psl9(struct cxl *adapter)
> -{
> -	unsigned long timeout = jiffies + (HZ * CXL_TIMEOUT);
> -	u64 ierat;
> -
> -	pr_devel("CXL adapter - invalidation of all ERAT entries\n");
> -
> -	/* Invalidates all ERAT entries for Radix or HPT */
> -	ierat = CXL_XSL9_IERAT_IALL;
> -	if (radix_enabled())
> -		ierat |= CXL_XSL9_IERAT_INVR;
> -	cxl_p1_write(adapter, CXL_XSL9_IERAT, ierat);
> -
> -	while (cxl_p1_read(adapter, CXL_XSL9_IERAT) & CXL_XSL9_IERAT_IINPROG) {
> -		if (time_after_eq(jiffies, timeout)) {
> -			dev_warn(&adapter->dev,
> -			"WARNING: CXL adapter invalidation of all ERAT entries timed out!\n");
> -			return -EBUSY;
> -		}
> -		if (!cxl_ops->link_ok(adapter, NULL))
> -			return -EIO;
> -		cpu_relax();
> -	}
> -	return 0;
> -}
> -
> -int cxl_invalidate_all_psl8(struct cxl *adapter)
> -{
> -	unsigned long timeout = jiffies + (HZ * CXL_TIMEOUT);
> -
> -	pr_devel("CXL adapter wide TLBIA & SLBIA\n");
> -
> -	cxl_p1_write(adapter, CXL_PSL_AFUSEL, CXL_PSL_AFUSEL_A);
> -
> -	cxl_p1_write(adapter, CXL_PSL_TLBIA, CXL_TLB_SLB_IQ_ALL);
> -	while (cxl_p1_read(adapter, CXL_PSL_TLBIA) & CXL_TLB_SLB_P) {
> -		if (time_after_eq(jiffies, timeout)) {
> -			dev_warn(&adapter->dev, "WARNING: CXL adapter wide TLBIA timed out!\n");
> -			return -EBUSY;
> -		}
> -		if (!cxl_ops->link_ok(adapter, NULL))
> -			return -EIO;
> -		cpu_relax();
> -	}
> -
> -	cxl_p1_write(adapter, CXL_PSL_SLBIA, CXL_TLB_SLB_IQ_ALL);
> -	while (cxl_p1_read(adapter, CXL_PSL_SLBIA) & CXL_TLB_SLB_P) {
> -		if (time_after_eq(jiffies, timeout)) {
> -			dev_warn(&adapter->dev, "WARNING: CXL adapter wide SLBIA timed out!\n");
> -			return -EBUSY;
> -		}
> -		if (!cxl_ops->link_ok(adapter, NULL))
> -			return -EIO;
> -		cpu_relax();
> -	}
> -	return 0;
> -}
> -
> -int cxl_data_cache_flush(struct cxl *adapter)
> -{
> -	u64 reg;
> -	unsigned long timeout = jiffies + (HZ * CXL_TIMEOUT);
> -
> -	/*
> -	 * Do a datacache flush only if datacache is available.
> -	 * In case of PSL9D datacache absent hence flush operation.
> -	 * would timeout.
> -	 */
> -	if (adapter->native->no_data_cache) {
> -		pr_devel("No PSL data cache. Ignoring cache flush req.\n");
> -		return 0;
> -	}
> -
> -	pr_devel("Flushing data cache\n");
> -	reg = cxl_p1_read(adapter, CXL_PSL_Control);
> -	reg |= CXL_PSL_Control_Fr;
> -	cxl_p1_write(adapter, CXL_PSL_Control, reg);
> -
> -	reg = cxl_p1_read(adapter, CXL_PSL_Control);
> -	while ((reg & CXL_PSL_Control_Fs_MASK) != CXL_PSL_Control_Fs_Complete) {
> -		if (time_after_eq(jiffies, timeout)) {
> -			dev_warn(&adapter->dev, "WARNING: cache flush timed out!\n");
> -			return -EBUSY;
> -		}
> -
> -		if (!cxl_ops->link_ok(adapter, NULL)) {
> -			dev_warn(&adapter->dev, "WARNING: link down when flushing cache\n");
> -			return -EIO;
> -		}
> -		cpu_relax();
> -		reg = cxl_p1_read(adapter, CXL_PSL_Control);
> -	}
> -
> -	reg &= ~CXL_PSL_Control_Fr;
> -	cxl_p1_write(adapter, CXL_PSL_Control, reg);
> -	return 0;
> -}
> -
> -static int cxl_write_sstp(struct cxl_afu *afu, u64 sstp0, u64 sstp1)
> -{
> -	int rc;
> -
> -	/* 1. Disable SSTP by writing 0 to SSTP1[V] */
> -	cxl_p2n_write(afu, CXL_SSTP1_An, 0);
> -
> -	/* 2. Invalidate all SLB entries */
> -	if ((rc = cxl_afu_slbia(afu)))
> -		return rc;
> -
> -	/* 3. Set SSTP0_An */
> -	cxl_p2n_write(afu, CXL_SSTP0_An, sstp0);
> -
> -	/* 4. Set SSTP1_An */
> -	cxl_p2n_write(afu, CXL_SSTP1_An, sstp1);
> -
> -	return 0;
> -}
> -
> -/* Using per slice version may improve performance here. (ie. SLBIA_An) */
> -static void slb_invalid(struct cxl_context *ctx)
> -{
> -	struct cxl *adapter = ctx->afu->adapter;
> -	u64 slbia;
> -
> -	WARN_ON(!mutex_is_locked(&ctx->afu->native->spa_mutex));
> -
> -	cxl_p1_write(adapter, CXL_PSL_LBISEL,
> -			((u64)be32_to_cpu(ctx->elem->common.pid) << 32) |
> -			be32_to_cpu(ctx->elem->lpid));
> -	cxl_p1_write(adapter, CXL_PSL_SLBIA, CXL_TLB_SLB_IQ_LPIDPID);
> -
> -	while (1) {
> -		if (!cxl_ops->link_ok(adapter, NULL))
> -			break;
> -		slbia = cxl_p1_read(adapter, CXL_PSL_SLBIA);
> -		if (!(slbia & CXL_TLB_SLB_P))
> -			break;
> -		cpu_relax();
> -	}
> -}
> -
> -static int do_process_element_cmd(struct cxl_context *ctx,
> -				  u64 cmd, u64 pe_state)
> -{
> -	u64 state;
> -	unsigned long timeout = jiffies + (HZ * CXL_TIMEOUT);
> -	int rc = 0;
> -
> -	trace_cxl_llcmd(ctx, cmd);
> -
> -	WARN_ON(!ctx->afu->enabled);
> -
> -	ctx->elem->software_state = cpu_to_be32(pe_state);
> -	smp_wmb();
> -	*(ctx->afu->native->sw_command_status) = cpu_to_be64(cmd | 0 | ctx->pe);
> -	smp_mb();
> -	cxl_p1n_write(ctx->afu, CXL_PSL_LLCMD_An, cmd | ctx->pe);
> -	while (1) {
> -		if (time_after_eq(jiffies, timeout)) {
> -			dev_warn(&ctx->afu->dev, "WARNING: Process Element Command timed out!\n");
> -			rc = -EBUSY;
> -			goto out;
> -		}
> -		if (!cxl_ops->link_ok(ctx->afu->adapter, ctx->afu)) {
> -			dev_warn(&ctx->afu->dev, "WARNING: Device link down, aborting Process Element Command!\n");
> -			rc = -EIO;
> -			goto out;
> -		}
> -		state = be64_to_cpup(ctx->afu->native->sw_command_status);
> -		if (state == ~0ULL) {
> -			pr_err("cxl: Error adding process element to AFU\n");
> -			rc = -1;
> -			goto out;
> -		}
> -		if ((state & (CXL_SPA_SW_CMD_MASK | CXL_SPA_SW_STATE_MASK  | CXL_SPA_SW_LINK_MASK)) ==
> -		    (cmd | (cmd >> 16) | ctx->pe))
> -			break;
> -		/*
> -		 * The command won't finish in the PSL if there are
> -		 * outstanding DSIs.  Hence we need to yield here in
> -		 * case there are outstanding DSIs that we need to
> -		 * service.  Tuning possiblity: we could wait for a
> -		 * while before sched
> -		 */
> -		schedule();
> -
> -	}
> -out:
> -	trace_cxl_llcmd_done(ctx, cmd, rc);
> -	return rc;
> -}
> -
> -static int add_process_element(struct cxl_context *ctx)
> -{
> -	int rc = 0;
> -
> -	mutex_lock(&ctx->afu->native->spa_mutex);
> -	pr_devel("%s Adding pe: %i started\n", __func__, ctx->pe);
> -	if (!(rc = do_process_element_cmd(ctx, CXL_SPA_SW_CMD_ADD, CXL_PE_SOFTWARE_STATE_V)))
> -		ctx->pe_inserted = true;
> -	pr_devel("%s Adding pe: %i finished\n", __func__, ctx->pe);
> -	mutex_unlock(&ctx->afu->native->spa_mutex);
> -	return rc;
> -}
> -
> -static int terminate_process_element(struct cxl_context *ctx)
> -{
> -	int rc = 0;
> -
> -	/* fast path terminate if it's already invalid */
> -	if (!(ctx->elem->software_state & cpu_to_be32(CXL_PE_SOFTWARE_STATE_V)))
> -		return rc;
> -
> -	mutex_lock(&ctx->afu->native->spa_mutex);
> -	pr_devel("%s Terminate pe: %i started\n", __func__, ctx->pe);
> -	/* We could be asked to terminate when the hw is down. That
> -	 * should always succeed: it's not running if the hw has gone
> -	 * away and is being reset.
> -	 */
> -	if (cxl_ops->link_ok(ctx->afu->adapter, ctx->afu))
> -		rc = do_process_element_cmd(ctx, CXL_SPA_SW_CMD_TERMINATE,
> -					    CXL_PE_SOFTWARE_STATE_V | CXL_PE_SOFTWARE_STATE_T);
> -	ctx->elem->software_state = 0;	/* Remove Valid bit */
> -	pr_devel("%s Terminate pe: %i finished\n", __func__, ctx->pe);
> -	mutex_unlock(&ctx->afu->native->spa_mutex);
> -	return rc;
> -}
> -
> -static int remove_process_element(struct cxl_context *ctx)
> -{
> -	int rc = 0;
> -
> -	mutex_lock(&ctx->afu->native->spa_mutex);
> -	pr_devel("%s Remove pe: %i started\n", __func__, ctx->pe);
> -
> -	/* We could be asked to remove when the hw is down. Again, if
> -	 * the hw is down, the PE is gone, so we succeed.
> -	 */
> -	if (cxl_ops->link_ok(ctx->afu->adapter, ctx->afu))
> -		rc = do_process_element_cmd(ctx, CXL_SPA_SW_CMD_REMOVE, 0);
> -
> -	if (!rc)
> -		ctx->pe_inserted = false;
> -	if (cxl_is_power8())
> -		slb_invalid(ctx);
> -	pr_devel("%s Remove pe: %i finished\n", __func__, ctx->pe);
> -	mutex_unlock(&ctx->afu->native->spa_mutex);
> -
> -	return rc;
> -}
> -
> -void cxl_assign_psn_space(struct cxl_context *ctx)
> -{
> -	if (!ctx->afu->pp_size || ctx->master) {
> -		ctx->psn_phys = ctx->afu->psn_phys;
> -		ctx->psn_size = ctx->afu->adapter->ps_size;
> -	} else {
> -		ctx->psn_phys = ctx->afu->psn_phys +
> -			(ctx->afu->native->pp_offset + ctx->afu->pp_size * ctx->pe);
> -		ctx->psn_size = ctx->afu->pp_size;
> -	}
> -}
> -
> -static int activate_afu_directed(struct cxl_afu *afu)
> -{
> -	int rc;
> -
> -	dev_info(&afu->dev, "Activating AFU directed mode\n");
> -
> -	afu->num_procs = afu->max_procs_virtualised;
> -	if (afu->native->spa == NULL) {
> -		if (cxl_alloc_spa(afu, CXL_MODE_DIRECTED))
> -			return -ENOMEM;
> -	}
> -	attach_spa(afu);
> -
> -	cxl_p1n_write(afu, CXL_PSL_SCNTL_An, CXL_PSL_SCNTL_An_PM_AFU);
> -	if (cxl_is_power8())
> -		cxl_p1n_write(afu, CXL_PSL_AMOR_An, 0xFFFFFFFFFFFFFFFFULL);
> -	cxl_p1n_write(afu, CXL_PSL_ID_An, CXL_PSL_ID_An_F | CXL_PSL_ID_An_L);
> -
> -	afu->current_mode = CXL_MODE_DIRECTED;
> -
> -	if ((rc = cxl_chardev_m_afu_add(afu)))
> -		return rc;
> -
> -	if ((rc = cxl_sysfs_afu_m_add(afu)))
> -		goto err;
> -
> -	if ((rc = cxl_chardev_s_afu_add(afu)))
> -		goto err1;
> -
> -	return 0;
> -err1:
> -	cxl_sysfs_afu_m_remove(afu);
> -err:
> -	cxl_chardev_afu_remove(afu);
> -	return rc;
> -}
> -
> -#ifdef CONFIG_CPU_LITTLE_ENDIAN
> -#define set_endian(sr) ((sr) |= CXL_PSL_SR_An_LE)
> -#else
> -#define set_endian(sr) ((sr) &= ~(CXL_PSL_SR_An_LE))
> -#endif
> -
> -u64 cxl_calculate_sr(bool master, bool kernel, bool real_mode, bool p9)
> -{
> -	u64 sr = 0;
> -
> -	set_endian(sr);
> -	if (master)
> -		sr |= CXL_PSL_SR_An_MP;
> -	if (mfspr(SPRN_LPCR) & LPCR_TC)
> -		sr |= CXL_PSL_SR_An_TC;
> -
> -	if (kernel) {
> -		if (!real_mode)
> -			sr |= CXL_PSL_SR_An_R;
> -		sr |= (mfmsr() & MSR_SF) | CXL_PSL_SR_An_HV;
> -	} else {
> -		sr |= CXL_PSL_SR_An_PR | CXL_PSL_SR_An_R;
> -		if (radix_enabled())
> -			sr |= CXL_PSL_SR_An_HV;
> -		else
> -			sr &= ~(CXL_PSL_SR_An_HV);
> -		if (!test_tsk_thread_flag(current, TIF_32BIT))
> -			sr |= CXL_PSL_SR_An_SF;
> -	}
> -	if (p9) {
> -		if (radix_enabled())
> -			sr |= CXL_PSL_SR_An_XLAT_ror;
> -		else
> -			sr |= CXL_PSL_SR_An_XLAT_hpt;
> -	}
> -	return sr;
> -}
> -
> -static u64 calculate_sr(struct cxl_context *ctx)
> -{
> -	return cxl_calculate_sr(ctx->master, ctx->kernel, false,
> -				cxl_is_power9());
> -}
> -
> -static void update_ivtes_directed(struct cxl_context *ctx)
> -{
> -	bool need_update = (ctx->status == STARTED);
> -	int r;
> -
> -	if (need_update) {
> -		WARN_ON(terminate_process_element(ctx));
> -		WARN_ON(remove_process_element(ctx));
> -	}
> -
> -	for (r = 0; r < CXL_IRQ_RANGES; r++) {
> -		ctx->elem->ivte_offsets[r] = cpu_to_be16(ctx->irqs.offset[r]);
> -		ctx->elem->ivte_ranges[r] = cpu_to_be16(ctx->irqs.range[r]);
> -	}
> -
> -	/*
> -	 * Theoretically we could use the update llcmd, instead of a
> -	 * terminate/remove/add (or if an atomic update was required we could
> -	 * do a suspend/update/resume), however it seems there might be issues
> -	 * with the update llcmd on some cards (including those using an XSL on
> -	 * an ASIC) so for now it's safest to go with the commands that are
> -	 * known to work. In the future if we come across a situation where the
> -	 * card may be performing transactions using the same PE while we are
> -	 * doing this update we might need to revisit this.
> -	 */
> -	if (need_update)
> -		WARN_ON(add_process_element(ctx));
> -}
> -
> -static int process_element_entry_psl9(struct cxl_context *ctx, u64 wed, u64 amr)
> -{
> -	u32 pid;
> -	int rc;
> -
> -	cxl_assign_psn_space(ctx);
> -
> -	ctx->elem->ctxtime = 0; /* disable */
> -	ctx->elem->lpid = cpu_to_be32(mfspr(SPRN_LPID));
> -	ctx->elem->haurp = 0; /* disable */
> -
> -	if (ctx->kernel)
> -		pid = 0;
> -	else {
> -		if (ctx->mm == NULL) {
> -			pr_devel("%s: unable to get mm for pe=%d pid=%i\n",
> -				__func__, ctx->pe, pid_nr(ctx->pid));
> -			return -EINVAL;
> -		}
> -		pid = ctx->mm->context.id;
> -	}
> -
> -	/* Assign a unique TIDR (thread id) for the current thread */
> -	if (!(ctx->tidr) && (ctx->assign_tidr)) {
> -		rc = set_thread_tidr(current);
> -		if (rc)
> -			return -ENODEV;
> -		ctx->tidr = current->thread.tidr;
> -		pr_devel("%s: current tidr: %d\n", __func__, ctx->tidr);
> -	}
> -
> -	ctx->elem->common.tid = cpu_to_be32(ctx->tidr);
> -	ctx->elem->common.pid = cpu_to_be32(pid);
> -
> -	ctx->elem->sr = cpu_to_be64(calculate_sr(ctx));
> -
> -	ctx->elem->common.csrp = 0; /* disable */
> -
> -	cxl_prefault(ctx, wed);
> -
> -	/*
> -	 * Ensure we have the multiplexed PSL interrupt set up to take faults
> -	 * for kernel contexts that may not have allocated any AFU IRQs at all:
> -	 */
> -	if (ctx->irqs.range[0] == 0) {
> -		ctx->irqs.offset[0] = ctx->afu->native->psl_hwirq;
> -		ctx->irqs.range[0] = 1;
> -	}
> -
> -	ctx->elem->common.amr = cpu_to_be64(amr);
> -	ctx->elem->common.wed = cpu_to_be64(wed);
> -
> -	return 0;
> -}
> -
> -int cxl_attach_afu_directed_psl9(struct cxl_context *ctx, u64 wed, u64 amr)
> -{
> -	int result;
> -
> -	/* fill the process element entry */
> -	result = process_element_entry_psl9(ctx, wed, amr);
> -	if (result)
> -		return result;
> -
> -	update_ivtes_directed(ctx);
> -
> -	/* first guy needs to enable */
> -	result = cxl_ops->afu_check_and_enable(ctx->afu);
> -	if (result)
> -		return result;
> -
> -	return add_process_element(ctx);
> -}
> -
> -int cxl_attach_afu_directed_psl8(struct cxl_context *ctx, u64 wed, u64 amr)
> -{
> -	u32 pid;
> -	int result;
> -
> -	cxl_assign_psn_space(ctx);
> -
> -	ctx->elem->ctxtime = 0; /* disable */
> -	ctx->elem->lpid = cpu_to_be32(mfspr(SPRN_LPID));
> -	ctx->elem->haurp = 0; /* disable */
> -	ctx->elem->u.sdr = cpu_to_be64(mfspr(SPRN_SDR1));
> -
> -	pid = current->pid;
> -	if (ctx->kernel)
> -		pid = 0;
> -	ctx->elem->common.tid = 0;
> -	ctx->elem->common.pid = cpu_to_be32(pid);
> -
> -	ctx->elem->sr = cpu_to_be64(calculate_sr(ctx));
> -
> -	ctx->elem->common.csrp = 0; /* disable */
> -	ctx->elem->common.u.psl8.aurp0 = 0; /* disable */
> -	ctx->elem->common.u.psl8.aurp1 = 0; /* disable */
> -
> -	cxl_prefault(ctx, wed);
> -
> -	ctx->elem->common.u.psl8.sstp0 = cpu_to_be64(ctx->sstp0);
> -	ctx->elem->common.u.psl8.sstp1 = cpu_to_be64(ctx->sstp1);
> -
> -	/*
> -	 * Ensure we have the multiplexed PSL interrupt set up to take faults
> -	 * for kernel contexts that may not have allocated any AFU IRQs at all:
> -	 */
> -	if (ctx->irqs.range[0] == 0) {
> -		ctx->irqs.offset[0] = ctx->afu->native->psl_hwirq;
> -		ctx->irqs.range[0] = 1;
> -	}
> -
> -	update_ivtes_directed(ctx);
> -
> -	ctx->elem->common.amr = cpu_to_be64(amr);
> -	ctx->elem->common.wed = cpu_to_be64(wed);
> -
> -	/* first guy needs to enable */
> -	if ((result = cxl_ops->afu_check_and_enable(ctx->afu)))
> -		return result;
> -
> -	return add_process_element(ctx);
> -}
> -
> -static int deactivate_afu_directed(struct cxl_afu *afu)
> -{
> -	dev_info(&afu->dev, "Deactivating AFU directed mode\n");
> -
> -	afu->current_mode = 0;
> -	afu->num_procs = 0;
> -
> -	cxl_sysfs_afu_m_remove(afu);
> -	cxl_chardev_afu_remove(afu);
> -
> -	/*
> -	 * The CAIA section 2.2.1 indicates that the procedure for starting and
> -	 * stopping an AFU in AFU directed mode is AFU specific, which is not
> -	 * ideal since this code is generic and with one exception has no
> -	 * knowledge of the AFU. This is in contrast to the procedure for
> -	 * disabling a dedicated process AFU, which is documented to just
> -	 * require a reset. The architecture does indicate that both an AFU
> -	 * reset and an AFU disable should result in the AFU being disabled and
> -	 * we do both followed by a PSL purge for safety.
> -	 *
> -	 * Notably we used to have some issues with the disable sequence on PSL
> -	 * cards, which is why we ended up using this heavy weight procedure in
> -	 * the first place, however a bug was discovered that had rendered the
> -	 * disable operation ineffective, so it is conceivable that was the
> -	 * sole explanation for those difficulties. Careful regression testing
> -	 * is recommended if anyone attempts to remove or reorder these
> -	 * operations.
> -	 *
> -	 * The XSL on the Mellanox CX4 behaves a little differently from the
> -	 * PSL based cards and will time out an AFU reset if the AFU is still
> -	 * enabled. That card is special in that we do have a means to identify
> -	 * it from this code, so in that case we skip the reset and just use a
> -	 * disable/purge to avoid the timeout and corresponding noise in the
> -	 * kernel log.
> -	 */
> -	if (afu->adapter->native->sl_ops->needs_reset_before_disable)
> -		cxl_ops->afu_reset(afu);
> -	cxl_afu_disable(afu);
> -	cxl_psl_purge(afu);
> -
> -	return 0;
> -}
> -
> -int cxl_activate_dedicated_process_psl9(struct cxl_afu *afu)
> -{
> -	dev_info(&afu->dev, "Activating dedicated process mode\n");
> -
> -	/*
> -	 * If XSL is set to dedicated mode (Set in PSL_SCNTL reg), the
> -	 * XSL and AFU are programmed to work with a single context.
> -	 * The context information should be configured in the SPA area
> -	 * index 0 (so PSL_SPAP must be configured before enabling the
> -	 * AFU).
> -	 */
> -	afu->num_procs = 1;
> -	if (afu->native->spa == NULL) {
> -		if (cxl_alloc_spa(afu, CXL_MODE_DEDICATED))
> -			return -ENOMEM;
> -	}
> -	attach_spa(afu);
> -
> -	cxl_p1n_write(afu, CXL_PSL_SCNTL_An, CXL_PSL_SCNTL_An_PM_Process);
> -	cxl_p1n_write(afu, CXL_PSL_ID_An, CXL_PSL_ID_An_F | CXL_PSL_ID_An_L);
> -
> -	afu->current_mode = CXL_MODE_DEDICATED;
> -
> -	return cxl_chardev_d_afu_add(afu);
> -}
> -
> -int cxl_activate_dedicated_process_psl8(struct cxl_afu *afu)
> -{
> -	dev_info(&afu->dev, "Activating dedicated process mode\n");
> -
> -	cxl_p1n_write(afu, CXL_PSL_SCNTL_An, CXL_PSL_SCNTL_An_PM_Process);
> -
> -	cxl_p1n_write(afu, CXL_PSL_CtxTime_An, 0); /* disable */
> -	cxl_p1n_write(afu, CXL_PSL_SPAP_An, 0);    /* disable */
> -	cxl_p1n_write(afu, CXL_PSL_AMOR_An, 0xFFFFFFFFFFFFFFFFULL);
> -	cxl_p1n_write(afu, CXL_PSL_LPID_An, mfspr(SPRN_LPID));
> -	cxl_p1n_write(afu, CXL_HAURP_An, 0);       /* disable */
> -	cxl_p1n_write(afu, CXL_PSL_SDR_An, mfspr(SPRN_SDR1));
> -
> -	cxl_p2n_write(afu, CXL_CSRP_An, 0);        /* disable */
> -	cxl_p2n_write(afu, CXL_AURP0_An, 0);       /* disable */
> -	cxl_p2n_write(afu, CXL_AURP1_An, 0);       /* disable */
> -
> -	afu->current_mode = CXL_MODE_DEDICATED;
> -	afu->num_procs = 1;
> -
> -	return cxl_chardev_d_afu_add(afu);
> -}
> -
> -void cxl_update_dedicated_ivtes_psl9(struct cxl_context *ctx)
> -{
> -	int r;
> -
> -	for (r = 0; r < CXL_IRQ_RANGES; r++) {
> -		ctx->elem->ivte_offsets[r] = cpu_to_be16(ctx->irqs.offset[r]);
> -		ctx->elem->ivte_ranges[r] = cpu_to_be16(ctx->irqs.range[r]);
> -	}
> -}
> -
> -void cxl_update_dedicated_ivtes_psl8(struct cxl_context *ctx)
> -{
> -	struct cxl_afu *afu = ctx->afu;
> -
> -	cxl_p1n_write(afu, CXL_PSL_IVTE_Offset_An,
> -		       (((u64)ctx->irqs.offset[0] & 0xffff) << 48) |
> -		       (((u64)ctx->irqs.offset[1] & 0xffff) << 32) |
> -		       (((u64)ctx->irqs.offset[2] & 0xffff) << 16) |
> -			((u64)ctx->irqs.offset[3] & 0xffff));
> -	cxl_p1n_write(afu, CXL_PSL_IVTE_Limit_An, (u64)
> -		       (((u64)ctx->irqs.range[0] & 0xffff) << 48) |
> -		       (((u64)ctx->irqs.range[1] & 0xffff) << 32) |
> -		       (((u64)ctx->irqs.range[2] & 0xffff) << 16) |
> -			((u64)ctx->irqs.range[3] & 0xffff));
> -}
> -
> -int cxl_attach_dedicated_process_psl9(struct cxl_context *ctx, u64 wed, u64 amr)
> -{
> -	struct cxl_afu *afu = ctx->afu;
> -	int result;
> -
> -	/* fill the process element entry */
> -	result = process_element_entry_psl9(ctx, wed, amr);
> -	if (result)
> -		return result;
> -
> -	if (ctx->afu->adapter->native->sl_ops->update_dedicated_ivtes)
> -		afu->adapter->native->sl_ops->update_dedicated_ivtes(ctx);
> -
> -	ctx->elem->software_state = cpu_to_be32(CXL_PE_SOFTWARE_STATE_V);
> -	/*
> -	 * Ideally we should do a wmb() here to make sure the changes to the
> -	 * PE are visible to the card before we call afu_enable.
> -	 * On ppc64 though all mmios are preceded by a 'sync' instruction hence
> -	 * we dont dont need one here.
> -	 */
> -
> -	result = cxl_ops->afu_reset(afu);
> -	if (result)
> -		return result;
> -
> -	return afu_enable(afu);
> -}
> -
> -int cxl_attach_dedicated_process_psl8(struct cxl_context *ctx, u64 wed, u64 amr)
> -{
> -	struct cxl_afu *afu = ctx->afu;
> -	u64 pid;
> -	int rc;
> -
> -	pid = (u64)current->pid << 32;
> -	if (ctx->kernel)
> -		pid = 0;
> -	cxl_p2n_write(afu, CXL_PSL_PID_TID_An, pid);
> -
> -	cxl_p1n_write(afu, CXL_PSL_SR_An, calculate_sr(ctx));
> -
> -	if ((rc = cxl_write_sstp(afu, ctx->sstp0, ctx->sstp1)))
> -		return rc;
> -
> -	cxl_prefault(ctx, wed);
> -
> -	if (ctx->afu->adapter->native->sl_ops->update_dedicated_ivtes)
> -		afu->adapter->native->sl_ops->update_dedicated_ivtes(ctx);
> -
> -	cxl_p2n_write(afu, CXL_PSL_AMR_An, amr);
> -
> -	/* master only context for dedicated */
> -	cxl_assign_psn_space(ctx);
> -
> -	if ((rc = cxl_ops->afu_reset(afu)))
> -		return rc;
> -
> -	cxl_p2n_write(afu, CXL_PSL_WED_An, wed);
> -
> -	return afu_enable(afu);
> -}
> -
> -static int deactivate_dedicated_process(struct cxl_afu *afu)
> -{
> -	dev_info(&afu->dev, "Deactivating dedicated process mode\n");
> -
> -	afu->current_mode = 0;
> -	afu->num_procs = 0;
> -
> -	cxl_chardev_afu_remove(afu);
> -
> -	return 0;
> -}
> -
> -static int native_afu_deactivate_mode(struct cxl_afu *afu, int mode)
> -{
> -	if (mode == CXL_MODE_DIRECTED)
> -		return deactivate_afu_directed(afu);
> -	if (mode == CXL_MODE_DEDICATED)
> -		return deactivate_dedicated_process(afu);
> -	return 0;
> -}
> -
> -static int native_afu_activate_mode(struct cxl_afu *afu, int mode)
> -{
> -	if (!mode)
> -		return 0;
> -	if (!(mode & afu->modes_supported))
> -		return -EINVAL;
> -
> -	if (!cxl_ops->link_ok(afu->adapter, afu)) {
> -		WARN(1, "Device link is down, refusing to activate!\n");
> -		return -EIO;
> -	}
> -
> -	if (mode == CXL_MODE_DIRECTED)
> -		return activate_afu_directed(afu);
> -	if ((mode == CXL_MODE_DEDICATED) &&
> -	    (afu->adapter->native->sl_ops->activate_dedicated_process))
> -		return afu->adapter->native->sl_ops->activate_dedicated_process(afu);
> -
> -	return -EINVAL;
> -}
> -
> -static int native_attach_process(struct cxl_context *ctx, bool kernel,
> -				u64 wed, u64 amr)
> -{
> -	if (!cxl_ops->link_ok(ctx->afu->adapter, ctx->afu)) {
> -		WARN(1, "Device link is down, refusing to attach process!\n");
> -		return -EIO;
> -	}
> -
> -	ctx->kernel = kernel;
> -	if ((ctx->afu->current_mode == CXL_MODE_DIRECTED) &&
> -	    (ctx->afu->adapter->native->sl_ops->attach_afu_directed))
> -		return ctx->afu->adapter->native->sl_ops->attach_afu_directed(ctx, wed, amr);
> -
> -	if ((ctx->afu->current_mode == CXL_MODE_DEDICATED) &&
> -	    (ctx->afu->adapter->native->sl_ops->attach_dedicated_process))
> -		return ctx->afu->adapter->native->sl_ops->attach_dedicated_process(ctx, wed, amr);
> -
> -	return -EINVAL;
> -}
> -
> -static inline int detach_process_native_dedicated(struct cxl_context *ctx)
> -{
> -	/*
> -	 * The CAIA section 2.1.1 indicates that we need to do an AFU reset to
> -	 * stop the AFU in dedicated mode (we therefore do not make that
> -	 * optional like we do in the afu directed path). It does not indicate
> -	 * that we need to do an explicit disable (which should occur
> -	 * implicitly as part of the reset) or purge, but we do these as well
> -	 * to be on the safe side.
> -	 *
> -	 * Notably we used to have some issues with the disable sequence
> -	 * (before the sequence was spelled out in the architecture) which is
> -	 * why we were so heavy weight in the first place, however a bug was
> -	 * discovered that had rendered the disable operation ineffective, so
> -	 * it is conceivable that was the sole explanation for those
> -	 * difficulties. Point is, we should be careful and do some regression
> -	 * testing if we ever attempt to remove any part of this procedure.
> -	 */
> -	cxl_ops->afu_reset(ctx->afu);
> -	cxl_afu_disable(ctx->afu);
> -	cxl_psl_purge(ctx->afu);
> -	return 0;
> -}
> -
> -static void native_update_ivtes(struct cxl_context *ctx)
> -{
> -	if (ctx->afu->current_mode == CXL_MODE_DIRECTED)
> -		return update_ivtes_directed(ctx);
> -	if ((ctx->afu->current_mode == CXL_MODE_DEDICATED) &&
> -	    (ctx->afu->adapter->native->sl_ops->update_dedicated_ivtes))
> -		return ctx->afu->adapter->native->sl_ops->update_dedicated_ivtes(ctx);
> -	WARN(1, "native_update_ivtes: Bad mode\n");
> -}
> -
> -static inline int detach_process_native_afu_directed(struct cxl_context *ctx)
> -{
> -	if (!ctx->pe_inserted)
> -		return 0;
> -	if (terminate_process_element(ctx))
> -		return -1;
> -	if (remove_process_element(ctx))
> -		return -1;
> -
> -	return 0;
> -}
> -
> -static int native_detach_process(struct cxl_context *ctx)
> -{
> -	trace_cxl_detach(ctx);
> -
> -	if (ctx->afu->current_mode == CXL_MODE_DEDICATED)
> -		return detach_process_native_dedicated(ctx);
> -
> -	return detach_process_native_afu_directed(ctx);
> -}
> -
> -static int native_get_irq_info(struct cxl_afu *afu, struct cxl_irq_info *info)
> -{
> -	/* If the adapter has gone away, we can't get any meaningful
> -	 * information.
> -	 */
> -	if (!cxl_ops->link_ok(afu->adapter, afu))
> -		return -EIO;
> -
> -	info->dsisr = cxl_p2n_read(afu, CXL_PSL_DSISR_An);
> -	info->dar = cxl_p2n_read(afu, CXL_PSL_DAR_An);
> -	if (cxl_is_power8())
> -		info->dsr = cxl_p2n_read(afu, CXL_PSL_DSR_An);
> -	info->afu_err = cxl_p2n_read(afu, CXL_AFU_ERR_An);
> -	info->errstat = cxl_p2n_read(afu, CXL_PSL_ErrStat_An);
> -	info->proc_handle = 0;
> -
> -	return 0;
> -}
> -
> -void cxl_native_irq_dump_regs_psl9(struct cxl_context *ctx)
> -{
> -	u64 fir1, serr;
> -
> -	fir1 = cxl_p1_read(ctx->afu->adapter, CXL_PSL9_FIR1);
> -
> -	dev_crit(&ctx->afu->dev, "PSL_FIR1: 0x%016llx\n", fir1);
> -	if (ctx->afu->adapter->native->sl_ops->register_serr_irq) {
> -		serr = cxl_p1n_read(ctx->afu, CXL_PSL_SERR_An);
> -		cxl_afu_decode_psl_serr(ctx->afu, serr);
> -	}
> -}
> -
> -void cxl_native_irq_dump_regs_psl8(struct cxl_context *ctx)
> -{
> -	u64 fir1, fir2, fir_slice, serr, afu_debug;
> -
> -	fir1 = cxl_p1_read(ctx->afu->adapter, CXL_PSL_FIR1);
> -	fir2 = cxl_p1_read(ctx->afu->adapter, CXL_PSL_FIR2);
> -	fir_slice = cxl_p1n_read(ctx->afu, CXL_PSL_FIR_SLICE_An);
> -	afu_debug = cxl_p1n_read(ctx->afu, CXL_AFU_DEBUG_An);
> -
> -	dev_crit(&ctx->afu->dev, "PSL_FIR1: 0x%016llx\n", fir1);
> -	dev_crit(&ctx->afu->dev, "PSL_FIR2: 0x%016llx\n", fir2);
> -	if (ctx->afu->adapter->native->sl_ops->register_serr_irq) {
> -		serr = cxl_p1n_read(ctx->afu, CXL_PSL_SERR_An);
> -		cxl_afu_decode_psl_serr(ctx->afu, serr);
> -	}
> -	dev_crit(&ctx->afu->dev, "PSL_FIR_SLICE_An: 0x%016llx\n", fir_slice);
> -	dev_crit(&ctx->afu->dev, "CXL_PSL_AFU_DEBUG_An: 0x%016llx\n", afu_debug);
> -}
> -
> -static irqreturn_t native_handle_psl_slice_error(struct cxl_context *ctx,
> -						u64 dsisr, u64 errstat)
> -{
> -
> -	dev_crit(&ctx->afu->dev, "PSL ERROR STATUS: 0x%016llx\n", errstat);
> -
> -	if (ctx->afu->adapter->native->sl_ops->psl_irq_dump_registers)
> -		ctx->afu->adapter->native->sl_ops->psl_irq_dump_registers(ctx);
> -
> -	if (ctx->afu->adapter->native->sl_ops->debugfs_stop_trace) {
> -		dev_crit(&ctx->afu->dev, "STOPPING CXL TRACE\n");
> -		ctx->afu->adapter->native->sl_ops->debugfs_stop_trace(ctx->afu->adapter);
> -	}
> -
> -	return cxl_ops->ack_irq(ctx, 0, errstat);
> -}
> -
> -static bool cxl_is_translation_fault(struct cxl_afu *afu, u64 dsisr)
> -{
> -	if ((cxl_is_power8()) && (dsisr & CXL_PSL_DSISR_TRANS))
> -		return true;
> -
> -	if ((cxl_is_power9()) && (dsisr & CXL_PSL9_DSISR_An_TF))
> -		return true;
> -
> -	return false;
> -}
> -
> -irqreturn_t cxl_fail_irq_psl(struct cxl_afu *afu, struct cxl_irq_info *irq_info)
> -{
> -	if (cxl_is_translation_fault(afu, irq_info->dsisr))
> -		cxl_p2n_write(afu, CXL_PSL_TFC_An, CXL_PSL_TFC_An_AE);
> -	else
> -		cxl_p2n_write(afu, CXL_PSL_TFC_An, CXL_PSL_TFC_An_A);
> -
> -	return IRQ_HANDLED;
> -}
> -
> -static irqreturn_t native_irq_multiplexed(int irq, void *data)
> -{
> -	struct cxl_afu *afu = data;
> -	struct cxl_context *ctx;
> -	struct cxl_irq_info irq_info;
> -	u64 phreg = cxl_p2n_read(afu, CXL_PSL_PEHandle_An);
> -	int ph, ret = IRQ_HANDLED, res;
> -
> -	/* check if eeh kicked in while the interrupt was in flight */
> -	if (unlikely(phreg == ~0ULL)) {
> -		dev_warn(&afu->dev,
> -			 "Ignoring slice interrupt(%d) due to fenced card",
> -			 irq);
> -		return IRQ_HANDLED;
> -	}
> -	/* Mask the pe-handle from register value */
> -	ph = phreg & 0xffff;
> -	if ((res = native_get_irq_info(afu, &irq_info))) {
> -		WARN(1, "Unable to get CXL IRQ Info: %i\n", res);
> -		if (afu->adapter->native->sl_ops->fail_irq)
> -			return afu->adapter->native->sl_ops->fail_irq(afu, &irq_info);
> -		return ret;
> -	}
> -
> -	rcu_read_lock();
> -	ctx = idr_find(&afu->contexts_idr, ph);
> -	if (ctx) {
> -		if (afu->adapter->native->sl_ops->handle_interrupt)
> -			ret = afu->adapter->native->sl_ops->handle_interrupt(irq, ctx, &irq_info);
> -		rcu_read_unlock();
> -		return ret;
> -	}
> -	rcu_read_unlock();
> -
> -	WARN(1, "Unable to demultiplex CXL PSL IRQ for PE %i DSISR %016llx DAR"
> -		" %016llx\n(Possible AFU HW issue - was a term/remove acked"
> -		" with outstanding transactions?)\n", ph, irq_info.dsisr,
> -		irq_info.dar);
> -	if (afu->adapter->native->sl_ops->fail_irq)
> -		ret = afu->adapter->native->sl_ops->fail_irq(afu, &irq_info);
> -	return ret;
> -}
> -
> -static void native_irq_wait(struct cxl_context *ctx)
> -{
> -	u64 dsisr;
> -	int timeout = 1000;
> -	int ph;
> -
> -	/*
> -	 * Wait until no further interrupts are presented by the PSL
> -	 * for this context.
> -	 */
> -	while (timeout--) {
> -		ph = cxl_p2n_read(ctx->afu, CXL_PSL_PEHandle_An) & 0xffff;
> -		if (ph != ctx->pe)
> -			return;
> -		dsisr = cxl_p2n_read(ctx->afu, CXL_PSL_DSISR_An);
> -		if (cxl_is_power8() &&
> -		   ((dsisr & CXL_PSL_DSISR_PENDING) == 0))
> -			return;
> -		if (cxl_is_power9() &&
> -		   ((dsisr & CXL_PSL9_DSISR_PENDING) == 0))
> -			return;
> -		/*
> -		 * We are waiting for the workqueue to process our
> -		 * irq, so need to let that run here.
> -		 */
> -		msleep(1);
> -	}
> -
> -	dev_warn(&ctx->afu->dev, "WARNING: waiting on DSI for PE %i"
> -		 " DSISR %016llx!\n", ph, dsisr);
> -	return;
> -}
> -
> -static irqreturn_t native_slice_irq_err(int irq, void *data)
> -{
> -	struct cxl_afu *afu = data;
> -	u64 errstat, serr, afu_error, dsisr;
> -	u64 fir_slice, afu_debug, irq_mask;
> -
> -	/*
> -	 * slice err interrupt is only used with full PSL (no XSL)
> -	 */
> -	serr = cxl_p1n_read(afu, CXL_PSL_SERR_An);
> -	errstat = cxl_p2n_read(afu, CXL_PSL_ErrStat_An);
> -	afu_error = cxl_p2n_read(afu, CXL_AFU_ERR_An);
> -	dsisr = cxl_p2n_read(afu, CXL_PSL_DSISR_An);
> -	cxl_afu_decode_psl_serr(afu, serr);
> -
> -	if (cxl_is_power8()) {
> -		fir_slice = cxl_p1n_read(afu, CXL_PSL_FIR_SLICE_An);
> -		afu_debug = cxl_p1n_read(afu, CXL_AFU_DEBUG_An);
> -		dev_crit(&afu->dev, "PSL_FIR_SLICE_An: 0x%016llx\n", fir_slice);
> -		dev_crit(&afu->dev, "CXL_PSL_AFU_DEBUG_An: 0x%016llx\n", afu_debug);
> -	}
> -	dev_crit(&afu->dev, "CXL_PSL_ErrStat_An: 0x%016llx\n", errstat);
> -	dev_crit(&afu->dev, "AFU_ERR_An: 0x%.16llx\n", afu_error);
> -	dev_crit(&afu->dev, "PSL_DSISR_An: 0x%.16llx\n", dsisr);
> -
> -	/* mask off the IRQ so it won't retrigger until the AFU is reset */
> -	irq_mask = (serr & CXL_PSL_SERR_An_IRQS) >> 32;
> -	serr |= irq_mask;
> -	cxl_p1n_write(afu, CXL_PSL_SERR_An, serr);
> -	dev_info(&afu->dev, "Further such interrupts will be masked until the AFU is reset\n");
> -
> -	return IRQ_HANDLED;
> -}
> -
> -void cxl_native_err_irq_dump_regs_psl9(struct cxl *adapter)
> -{
> -	u64 fir1;
> -
> -	fir1 = cxl_p1_read(adapter, CXL_PSL9_FIR1);
> -	dev_crit(&adapter->dev, "PSL_FIR: 0x%016llx\n", fir1);
> -}
> -
> -void cxl_native_err_irq_dump_regs_psl8(struct cxl *adapter)
> -{
> -	u64 fir1, fir2;
> -
> -	fir1 = cxl_p1_read(adapter, CXL_PSL_FIR1);
> -	fir2 = cxl_p1_read(adapter, CXL_PSL_FIR2);
> -	dev_crit(&adapter->dev,
> -		 "PSL_FIR1: 0x%016llx\nPSL_FIR2: 0x%016llx\n",
> -		 fir1, fir2);
> -}
> -
> -static irqreturn_t native_irq_err(int irq, void *data)
> -{
> -	struct cxl *adapter = data;
> -	u64 err_ivte;
> -
> -	WARN(1, "CXL ERROR interrupt %i\n", irq);
> -
> -	err_ivte = cxl_p1_read(adapter, CXL_PSL_ErrIVTE);
> -	dev_crit(&adapter->dev, "PSL_ErrIVTE: 0x%016llx\n", err_ivte);
> -
> -	if (adapter->native->sl_ops->debugfs_stop_trace) {
> -		dev_crit(&adapter->dev, "STOPPING CXL TRACE\n");
> -		adapter->native->sl_ops->debugfs_stop_trace(adapter);
> -	}
> -
> -	if (adapter->native->sl_ops->err_irq_dump_registers)
> -		adapter->native->sl_ops->err_irq_dump_registers(adapter);
> -
> -	return IRQ_HANDLED;
> -}
> -
> -int cxl_native_register_psl_err_irq(struct cxl *adapter)
> -{
> -	int rc;
> -
> -	adapter->irq_name = kasprintf(GFP_KERNEL, "cxl-%s-err",
> -				      dev_name(&adapter->dev));
> -	if (!adapter->irq_name)
> -		return -ENOMEM;
> -
> -	if ((rc = cxl_register_one_irq(adapter, native_irq_err, adapter,
> -				       &adapter->native->err_hwirq,
> -				       &adapter->native->err_virq,
> -				       adapter->irq_name))) {
> -		kfree(adapter->irq_name);
> -		adapter->irq_name = NULL;
> -		return rc;
> -	}
> -
> -	cxl_p1_write(adapter, CXL_PSL_ErrIVTE, adapter->native->err_hwirq & 0xffff);
> -
> -	return 0;
> -}
> -
> -void cxl_native_release_psl_err_irq(struct cxl *adapter)
> -{
> -	if (adapter->native->err_virq == 0 ||
> -	    adapter->native->err_virq !=
> -	    irq_find_mapping(NULL, adapter->native->err_hwirq))
> -		return;
> -
> -	cxl_p1_write(adapter, CXL_PSL_ErrIVTE, 0x0000000000000000);
> -	cxl_unmap_irq(adapter->native->err_virq, adapter);
> -	cxl_ops->release_one_irq(adapter, adapter->native->err_hwirq);
> -	kfree(adapter->irq_name);
> -	adapter->native->err_virq = 0;
> -}
> -
> -int cxl_native_register_serr_irq(struct cxl_afu *afu)
> -{
> -	u64 serr;
> -	int rc;
> -
> -	afu->err_irq_name = kasprintf(GFP_KERNEL, "cxl-%s-err",
> -				      dev_name(&afu->dev));
> -	if (!afu->err_irq_name)
> -		return -ENOMEM;
> -
> -	if ((rc = cxl_register_one_irq(afu->adapter, native_slice_irq_err, afu,
> -				       &afu->serr_hwirq,
> -				       &afu->serr_virq, afu->err_irq_name))) {
> -		kfree(afu->err_irq_name);
> -		afu->err_irq_name = NULL;
> -		return rc;
> -	}
> -
> -	serr = cxl_p1n_read(afu, CXL_PSL_SERR_An);
> -	if (cxl_is_power8())
> -		serr = (serr & 0x00ffffffffff0000ULL) | (afu->serr_hwirq & 0xffff);
> -	if (cxl_is_power9()) {
> -		/*
> -		 * By default, all errors are masked. So don't set all masks.
> -		 * Slice errors will be transfered.
> -		 */
> -		serr = (serr & ~0xff0000007fffffffULL) | (afu->serr_hwirq & 0xffff);
> -	}
> -	cxl_p1n_write(afu, CXL_PSL_SERR_An, serr);
> -
> -	return 0;
> -}
> -
> -void cxl_native_release_serr_irq(struct cxl_afu *afu)
> -{
> -	if (afu->serr_virq == 0 ||
> -	    afu->serr_virq != irq_find_mapping(NULL, afu->serr_hwirq))
> -		return;
> -
> -	cxl_p1n_write(afu, CXL_PSL_SERR_An, 0x0000000000000000);
> -	cxl_unmap_irq(afu->serr_virq, afu);
> -	cxl_ops->release_one_irq(afu->adapter, afu->serr_hwirq);
> -	kfree(afu->err_irq_name);
> -	afu->serr_virq = 0;
> -}
> -
> -int cxl_native_register_psl_irq(struct cxl_afu *afu)
> -{
> -	int rc;
> -
> -	afu->psl_irq_name = kasprintf(GFP_KERNEL, "cxl-%s",
> -				      dev_name(&afu->dev));
> -	if (!afu->psl_irq_name)
> -		return -ENOMEM;
> -
> -	if ((rc = cxl_register_one_irq(afu->adapter, native_irq_multiplexed,
> -				    afu, &afu->native->psl_hwirq, &afu->native->psl_virq,
> -				    afu->psl_irq_name))) {
> -		kfree(afu->psl_irq_name);
> -		afu->psl_irq_name = NULL;
> -	}
> -	return rc;
> -}
> -
> -void cxl_native_release_psl_irq(struct cxl_afu *afu)
> -{
> -	if (afu->native->psl_virq == 0 ||
> -	    afu->native->psl_virq !=
> -	    irq_find_mapping(NULL, afu->native->psl_hwirq))
> -		return;
> -
> -	cxl_unmap_irq(afu->native->psl_virq, afu);
> -	cxl_ops->release_one_irq(afu->adapter, afu->native->psl_hwirq);
> -	kfree(afu->psl_irq_name);
> -	afu->native->psl_virq = 0;
> -}
> -
> -static void recover_psl_err(struct cxl_afu *afu, u64 errstat)
> -{
> -	u64 dsisr;
> -
> -	pr_devel("RECOVERING FROM PSL ERROR... (0x%016llx)\n", errstat);
> -
> -	/* Clear PSL_DSISR[PE] */
> -	dsisr = cxl_p2n_read(afu, CXL_PSL_DSISR_An);
> -	cxl_p2n_write(afu, CXL_PSL_DSISR_An, dsisr & ~CXL_PSL_DSISR_An_PE);
> -
> -	/* Write 1s to clear error status bits */
> -	cxl_p2n_write(afu, CXL_PSL_ErrStat_An, errstat);
> -}
> -
> -static int native_ack_irq(struct cxl_context *ctx, u64 tfc, u64 psl_reset_mask)
> -{
> -	trace_cxl_psl_irq_ack(ctx, tfc);
> -	if (tfc)
> -		cxl_p2n_write(ctx->afu, CXL_PSL_TFC_An, tfc);
> -	if (psl_reset_mask)
> -		recover_psl_err(ctx->afu, psl_reset_mask);
> -
> -	return 0;
> -}
> -
> -int cxl_check_error(struct cxl_afu *afu)
> -{
> -	return (cxl_p1n_read(afu, CXL_PSL_SCNTL_An) == ~0ULL);
> -}
> -
> -static bool native_support_attributes(const char *attr_name,
> -				      enum cxl_attrs type)
> -{
> -	return true;
> -}
> -
> -static int native_afu_cr_read64(struct cxl_afu *afu, int cr, u64 off, u64 *out)
> -{
> -	if (unlikely(!cxl_ops->link_ok(afu->adapter, afu)))
> -		return -EIO;
> -	if (unlikely(off >= afu->crs_len))
> -		return -ERANGE;
> -	*out = in_le64(afu->native->afu_desc_mmio + afu->crs_offset +
> -		(cr * afu->crs_len) + off);
> -	return 0;
> -}
> -
> -static int native_afu_cr_read32(struct cxl_afu *afu, int cr, u64 off, u32 *out)
> -{
> -	if (unlikely(!cxl_ops->link_ok(afu->adapter, afu)))
> -		return -EIO;
> -	if (unlikely(off >= afu->crs_len))
> -		return -ERANGE;
> -	*out = in_le32(afu->native->afu_desc_mmio + afu->crs_offset +
> -		(cr * afu->crs_len) + off);
> -	return 0;
> -}
> -
> -static int native_afu_cr_read16(struct cxl_afu *afu, int cr, u64 off, u16 *out)
> -{
> -	u64 aligned_off = off & ~0x3L;
> -	u32 val;
> -	int rc;
> -
> -	rc = native_afu_cr_read32(afu, cr, aligned_off, &val);
> -	if (!rc)
> -		*out = (val >> ((off & 0x3) * 8)) & 0xffff;
> -	return rc;
> -}
> -
> -static int native_afu_cr_read8(struct cxl_afu *afu, int cr, u64 off, u8 *out)
> -{
> -	u64 aligned_off = off & ~0x3L;
> -	u32 val;
> -	int rc;
> -
> -	rc = native_afu_cr_read32(afu, cr, aligned_off, &val);
> -	if (!rc)
> -		*out = (val >> ((off & 0x3) * 8)) & 0xff;
> -	return rc;
> -}
> -
> -static int native_afu_cr_write32(struct cxl_afu *afu, int cr, u64 off, u32 in)
> -{
> -	if (unlikely(!cxl_ops->link_ok(afu->adapter, afu)))
> -		return -EIO;
> -	if (unlikely(off >= afu->crs_len))
> -		return -ERANGE;
> -	out_le32(afu->native->afu_desc_mmio + afu->crs_offset +
> -		(cr * afu->crs_len) + off, in);
> -	return 0;
> -}
> -
> -static int native_afu_cr_write16(struct cxl_afu *afu, int cr, u64 off, u16 in)
> -{
> -	u64 aligned_off = off & ~0x3L;
> -	u32 val32, mask, shift;
> -	int rc;
> -
> -	rc = native_afu_cr_read32(afu, cr, aligned_off, &val32);
> -	if (rc)
> -		return rc;
> -	shift = (off & 0x3) * 8;
> -	WARN_ON(shift == 24);
> -	mask = 0xffff << shift;
> -	val32 = (val32 & ~mask) | (in << shift);
> -
> -	rc = native_afu_cr_write32(afu, cr, aligned_off, val32);
> -	return rc;
> -}
> -
> -static int native_afu_cr_write8(struct cxl_afu *afu, int cr, u64 off, u8 in)
> -{
> -	u64 aligned_off = off & ~0x3L;
> -	u32 val32, mask, shift;
> -	int rc;
> -
> -	rc = native_afu_cr_read32(afu, cr, aligned_off, &val32);
> -	if (rc)
> -		return rc;
> -	shift = (off & 0x3) * 8;
> -	mask = 0xff << shift;
> -	val32 = (val32 & ~mask) | (in << shift);
> -
> -	rc = native_afu_cr_write32(afu, cr, aligned_off, val32);
> -	return rc;
> -}
> -
> -const struct cxl_backend_ops cxl_native_ops = {
> -	.module = THIS_MODULE,
> -	.adapter_reset = cxl_pci_reset,
> -	.alloc_one_irq = cxl_pci_alloc_one_irq,
> -	.release_one_irq = cxl_pci_release_one_irq,
> -	.alloc_irq_ranges = cxl_pci_alloc_irq_ranges,
> -	.release_irq_ranges = cxl_pci_release_irq_ranges,
> -	.setup_irq = cxl_pci_setup_irq,
> -	.handle_psl_slice_error = native_handle_psl_slice_error,
> -	.psl_interrupt = NULL,
> -	.ack_irq = native_ack_irq,
> -	.irq_wait = native_irq_wait,
> -	.attach_process = native_attach_process,
> -	.detach_process = native_detach_process,
> -	.update_ivtes = native_update_ivtes,
> -	.support_attributes = native_support_attributes,
> -	.link_ok = cxl_adapter_link_ok,
> -	.release_afu = cxl_pci_release_afu,
> -	.afu_read_err_buffer = cxl_pci_afu_read_err_buffer,
> -	.afu_check_and_enable = native_afu_check_and_enable,
> -	.afu_activate_mode = native_afu_activate_mode,
> -	.afu_deactivate_mode = native_afu_deactivate_mode,
> -	.afu_reset = native_afu_reset,
> -	.afu_cr_read8 = native_afu_cr_read8,
> -	.afu_cr_read16 = native_afu_cr_read16,
> -	.afu_cr_read32 = native_afu_cr_read32,
> -	.afu_cr_read64 = native_afu_cr_read64,
> -	.afu_cr_write8 = native_afu_cr_write8,
> -	.afu_cr_write16 = native_afu_cr_write16,
> -	.afu_cr_write32 = native_afu_cr_write32,
> -	.read_adapter_vpd = cxl_pci_read_adapter_vpd,
> -};
> diff --git a/drivers/misc/cxl/of.c b/drivers/misc/cxl/of.c
> deleted file mode 100644
> index e26ee85279fa..000000000000
> --- a/drivers/misc/cxl/of.c
> +++ /dev/null
> @@ -1,346 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * Copyright 2015 IBM Corp.
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/platform_device.h>
> -#include <linux/slab.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_platform.h>
> -
> -#include "cxl.h"
> -
> -static int read_phys_addr(struct device_node *np, char *prop_name,
> -			struct cxl_afu *afu)
> -{
> -	int i, len, entry_size, naddr, nsize, type;
> -	u64 addr, size;
> -	const __be32 *prop;
> -
> -	naddr = of_n_addr_cells(np);
> -	nsize = of_n_size_cells(np);
> -
> -	prop = of_get_property(np, prop_name, &len);
> -	if (prop) {
> -		entry_size = naddr + nsize;
> -		for (i = 0; i < (len / 4); i += entry_size, prop += entry_size) {
> -			type = be32_to_cpu(prop[0]);
> -			addr = of_read_number(prop, naddr);
> -			size = of_read_number(&prop[naddr], nsize);
> -			switch (type) {
> -			case 0: /* unit address */
> -				afu->guest->handle = addr;
> -				break;
> -			case 1: /* p2 area */
> -				afu->guest->p2n_phys += addr;
> -				afu->guest->p2n_size = size;
> -				break;
> -			case 2: /* problem state area */
> -				afu->psn_phys += addr;
> -				afu->adapter->ps_size = size;
> -				break;
> -			default:
> -				pr_err("Invalid address type %d found in %s property of AFU\n",
> -					type, prop_name);
> -				return -EINVAL;
> -			}
> -		}
> -	}
> -	return 0;
> -}
> -
> -static int read_vpd(struct cxl *adapter, struct cxl_afu *afu)
> -{
> -	char vpd[256];
> -	int rc;
> -	size_t len = sizeof(vpd);
> -
> -	memset(vpd, 0, len);
> -
> -	if (adapter)
> -		rc = cxl_guest_read_adapter_vpd(adapter, vpd, len);
> -	else
> -		rc = cxl_guest_read_afu_vpd(afu, vpd, len);
> -
> -	if (rc > 0) {
> -		cxl_dump_debug_buffer(vpd, rc);
> -		rc = 0;
> -	}
> -	return rc;
> -}
> -
> -int cxl_of_read_afu_handle(struct cxl_afu *afu, struct device_node *afu_np)
> -{
> -	return of_property_read_reg(afu_np, 0, &afu->guest->handle, NULL);
> -}
> -
> -int cxl_of_read_afu_properties(struct cxl_afu *afu, struct device_node *np)
> -{
> -	int i, rc;
> -	u16 device_id, vendor_id;
> -	u32 val = 0, class_code;
> -
> -	/* Properties are read in the same order as listed in PAPR */
> -
> -	rc = read_phys_addr(np, "reg", afu);
> -	if (rc)
> -		return rc;
> -
> -	rc = read_phys_addr(np, "assigned-addresses", afu);
> -	if (rc)
> -		return rc;
> -
> -	if (afu->psn_phys == 0)
> -		afu->psa = false;
> -	else
> -		afu->psa = true;
> -
> -	of_property_read_u32(np, "ibm,#processes", &afu->max_procs_virtualised);
> -
> -	if (cxl_verbose)
> -		read_vpd(NULL, afu);
> -
> -	of_property_read_u32(np, "ibm,max-ints-per-process", &afu->guest->max_ints);
> -	afu->irqs_max = afu->guest->max_ints;
> -
> -	if (!of_property_read_u32(np, "ibm,min-ints-per-process", &afu->pp_irqs)) {
> -		/* One extra interrupt for the PSL interrupt is already
> -		 * included. Remove it now to keep only AFU interrupts and
> -		 * match the native case.
> -		 */
> -		afu->pp_irqs--;
> -	}
> -
> -	of_property_read_u64(np, "ibm,error-buffer-size", &afu->eb_len);
> -	afu->eb_offset = 0;
> -
> -	of_property_read_u64(np, "ibm,config-record-size", &afu->crs_len);
> -	afu->crs_offset = 0;
> -
> -	of_property_read_u32(np, "ibm,#config-records", &afu->crs_num);
> -
> -	if (cxl_verbose) {
> -		for (i = 0; i < afu->crs_num; i++) {
> -			rc = cxl_ops->afu_cr_read16(afu, i, PCI_DEVICE_ID,
> -						&device_id);
> -			if (!rc)
> -				pr_info("record %d - device-id: %#x\n",
> -					i, device_id);
> -			rc = cxl_ops->afu_cr_read16(afu, i, PCI_VENDOR_ID,
> -						&vendor_id);
> -			if (!rc)
> -				pr_info("record %d - vendor-id: %#x\n",
> -					i, vendor_id);
> -			rc = cxl_ops->afu_cr_read32(afu, i, PCI_CLASS_REVISION,
> -						&class_code);
> -			if (!rc) {
> -				class_code >>= 8;
> -				pr_info("record %d - class-code: %#x\n",
> -					i, class_code);
> -			}
> -		}
> -	}
> -	/*
> -	 * if "ibm,process-mmio" doesn't exist then per-process mmio is
> -	 * not supported
> -	 */
> -	val = 0;
> -	if (!of_property_read_u32(np, "ibm,process-mmio", &val) && val == 1)
> -		afu->pp_psa = true;
> -	else
> -		afu->pp_psa = false;
> -
> -	if (!of_property_read_u32(np, "ibm,function-error-interrupt", &val))
> -		afu->serr_hwirq = val;
> -
> -	pr_devel("AFU handle: %#llx\n", afu->guest->handle);
> -	pr_devel("p2n_phys: %#llx (size %#llx)\n",
> -		afu->guest->p2n_phys, afu->guest->p2n_size);
> -	pr_devel("psn_phys: %#llx (size %#llx)\n",
> -		afu->psn_phys, afu->adapter->ps_size);
> -	pr_devel("Max number of processes virtualised=%i\n",
> -		afu->max_procs_virtualised);
> -	pr_devel("Per-process irqs min=%i, max=%i\n", afu->pp_irqs,
> -		 afu->irqs_max);
> -	pr_devel("Slice error interrupt=%#lx\n", afu->serr_hwirq);
> -
> -	return 0;
> -}
> -
> -static int read_adapter_irq_config(struct cxl *adapter, struct device_node *np)
> -{
> -	const __be32 *ranges;
> -	int len, nranges, i;
> -	struct irq_avail *cur;
> -
> -	ranges = of_get_property(np, "interrupt-ranges", &len);
> -	if (ranges == NULL || len < (2 * sizeof(int)))
> -		return -EINVAL;
> -
> -	/*
> -	 * encoded array of two cells per entry, each cell encoded as
> -	 * with encode-int
> -	 */
> -	nranges = len / (2 * sizeof(int));
> -	if (nranges == 0 || (nranges * 2 * sizeof(int)) != len)
> -		return -EINVAL;
> -
> -	adapter->guest->irq_avail = kcalloc(nranges, sizeof(struct irq_avail),
> -					    GFP_KERNEL);
> -	if (adapter->guest->irq_avail == NULL)
> -		return -ENOMEM;
> -
> -	adapter->guest->irq_base_offset = be32_to_cpu(ranges[0]);
> -	for (i = 0; i < nranges; i++) {
> -		cur = &adapter->guest->irq_avail[i];
> -		cur->offset = be32_to_cpu(ranges[i * 2]);
> -		cur->range  = be32_to_cpu(ranges[i * 2 + 1]);
> -		cur->bitmap = bitmap_zalloc(cur->range, GFP_KERNEL);
> -		if (cur->bitmap == NULL)
> -			goto err;
> -		if (cur->offset < adapter->guest->irq_base_offset)
> -			adapter->guest->irq_base_offset = cur->offset;
> -		if (cxl_verbose)
> -			pr_info("available IRQ range: %#lx-%#lx (%lu)\n",
> -				cur->offset, cur->offset + cur->range - 1,
> -				cur->range);
> -	}
> -	adapter->guest->irq_nranges = nranges;
> -	spin_lock_init(&adapter->guest->irq_alloc_lock);
> -
> -	return 0;
> -err:
> -	for (i--; i >= 0; i--) {
> -		cur = &adapter->guest->irq_avail[i];
> -		bitmap_free(cur->bitmap);
> -	}
> -	kfree(adapter->guest->irq_avail);
> -	adapter->guest->irq_avail = NULL;
> -	return -ENOMEM;
> -}
> -
> -int cxl_of_read_adapter_handle(struct cxl *adapter, struct device_node *np)
> -{
> -	return of_property_read_reg(np, 0, &adapter->guest->handle, NULL);
> -}
> -
> -int cxl_of_read_adapter_properties(struct cxl *adapter, struct device_node *np)
> -{
> -	int rc;
> -	const char *p;
> -	u32 val = 0;
> -
> -	/* Properties are read in the same order as listed in PAPR */
> -
> -	if ((rc = read_adapter_irq_config(adapter, np)))
> -		return rc;
> -
> -	if (!of_property_read_u32(np, "ibm,caia-version", &val)) {
> -		adapter->caia_major = (val & 0xFF00) >> 8;
> -		adapter->caia_minor = val & 0xFF;
> -	}
> -
> -	if (!of_property_read_u32(np, "ibm,psl-revision", &val))
> -		adapter->psl_rev = val;
> -
> -	if (!of_property_read_string(np, "status", &p)) {
> -		adapter->guest->status = kasprintf(GFP_KERNEL, "%s", p);
> -		if (adapter->guest->status == NULL)
> -			return -ENOMEM;
> -	}
> -
> -	if (!of_property_read_u32(np, "vendor-id", &val))
> -		adapter->guest->vendor = val;
> -
> -	if (!of_property_read_u32(np, "device-id", &val))
> -		adapter->guest->device = val;
> -
> -	if (!of_property_read_u32(np, "subsystem-vendor-id", &val))
> -		adapter->guest->subsystem_vendor = val;
> -
> -	if (!of_property_read_u32(np, "subsystem-id", &val))
> -		adapter->guest->subsystem = val;
> -
> -	if (cxl_verbose)
> -		read_vpd(adapter, NULL);
> -
> -	return 0;
> -}
> -
> -static void cxl_of_remove(struct platform_device *pdev)
> -{
> -	struct cxl *adapter;
> -	int afu;
> -
> -	adapter = dev_get_drvdata(&pdev->dev);
> -	for (afu = 0; afu < adapter->slices; afu++)
> -		cxl_guest_remove_afu(adapter->afu[afu]);
> -
> -	cxl_guest_remove_adapter(adapter);
> -}
> -
> -static void cxl_of_shutdown(struct platform_device *pdev)
> -{
> -	cxl_of_remove(pdev);
> -}
> -
> -int cxl_of_probe(struct platform_device *pdev)
> -{
> -	struct device_node *np = NULL;
> -	struct device_node *afu_np = NULL;
> -	struct cxl *adapter = NULL;
> -	int ret;
> -	int slice = 0, slice_ok = 0;
> -
> -	dev_err_once(&pdev->dev, "DEPRECATION: cxl is deprecated and will be removed in a future kernel release\n");
> -
> -	pr_devel("in %s\n", __func__);
> -
> -	np = pdev->dev.of_node;
> -	if (np == NULL)
> -		return -ENODEV;
> -
> -	/* init adapter */
> -	adapter = cxl_guest_init_adapter(np, pdev);
> -	if (IS_ERR(adapter)) {
> -		dev_err(&pdev->dev, "guest_init_adapter failed: %li\n", PTR_ERR(adapter));
> -		return PTR_ERR(adapter);
> -	}
> -
> -	/* init afu */
> -	for_each_child_of_node(np, afu_np) {
> -		if ((ret = cxl_guest_init_afu(adapter, slice, afu_np)))
> -			dev_err(&pdev->dev, "AFU %i failed to initialise: %i\n",
> -				slice, ret);
> -		else
> -			slice_ok++;
> -		slice++;
> -	}
> -
> -	if (slice_ok == 0) {
> -		dev_info(&pdev->dev, "No active AFU");
> -		adapter->slices = 0;
> -	}
> -
> -	return 0;
> -}
> -
> -static const struct of_device_id cxl_of_match[] = {
> -	{ .compatible = "ibm,coherent-platform-facility",},
> -	{},
> -};
> -MODULE_DEVICE_TABLE(of, cxl_of_match);
> -
> -struct platform_driver cxl_of_driver = {
> -	.driver = {
> -		.name = "cxl_of",
> -		.of_match_table = cxl_of_match,
> -		.owner = THIS_MODULE
> -	},
> -	.probe = cxl_of_probe,
> -	.remove = cxl_of_remove,
> -	.shutdown = cxl_of_shutdown,
> -};
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> deleted file mode 100644
> index 92bf7c5c7b35..000000000000
> --- a/drivers/misc/cxl/pci.c
> +++ /dev/null
> @@ -1,2103 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * Copyright 2014 IBM Corp.
> - */
> -
> -#include <linux/pci_regs.h>
> -#include <linux/pci_ids.h>
> -#include <linux/device.h>
> -#include <linux/module.h>
> -#include <linux/kernel.h>
> -#include <linux/slab.h>
> -#include <linux/sort.h>
> -#include <linux/pci.h>
> -#include <linux/of.h>
> -#include <linux/delay.h>
> -#include <asm/opal.h>
> -#include <asm/msi_bitmap.h>
> -#include <asm/pnv-pci.h>
> -#include <asm/io.h>
> -#include <asm/reg.h>
> -
> -#include "cxl.h"
> -#include <misc/cxl.h>
> -
> -
> -#define CXL_PCI_VSEC_ID	0x1280
> -#define CXL_VSEC_MIN_SIZE 0x80
> -
> -#define CXL_READ_VSEC_LENGTH(dev, vsec, dest)			\
> -	{							\
> -		pci_read_config_word(dev, vsec + 0x6, dest);	\
> -		*dest >>= 4;					\
> -	}
> -#define CXL_READ_VSEC_NAFUS(dev, vsec, dest) \
> -	pci_read_config_byte(dev, vsec + 0x8, dest)
> -
> -#define CXL_READ_VSEC_STATUS(dev, vsec, dest) \
> -	pci_read_config_byte(dev, vsec + 0x9, dest)
> -#define CXL_STATUS_SECOND_PORT  0x80
> -#define CXL_STATUS_MSI_X_FULL   0x40
> -#define CXL_STATUS_MSI_X_SINGLE 0x20
> -#define CXL_STATUS_FLASH_RW     0x08
> -#define CXL_STATUS_FLASH_RO     0x04
> -#define CXL_STATUS_LOADABLE_AFU 0x02
> -#define CXL_STATUS_LOADABLE_PSL 0x01
> -/* If we see these features we won't try to use the card */
> -#define CXL_UNSUPPORTED_FEATURES \
> -	(CXL_STATUS_MSI_X_FULL | CXL_STATUS_MSI_X_SINGLE)
> -
> -#define CXL_READ_VSEC_MODE_CONTROL(dev, vsec, dest) \
> -	pci_read_config_byte(dev, vsec + 0xa, dest)
> -#define CXL_WRITE_VSEC_MODE_CONTROL(dev, vsec, val) \
> -	pci_write_config_byte(dev, vsec + 0xa, val)
> -#define CXL_VSEC_PROTOCOL_MASK   0xe0
> -#define CXL_VSEC_PROTOCOL_1024TB 0x80
> -#define CXL_VSEC_PROTOCOL_512TB  0x40
> -#define CXL_VSEC_PROTOCOL_256TB  0x20 /* Power 8/9 uses this */
> -#define CXL_VSEC_PROTOCOL_ENABLE 0x01
> -
> -#define CXL_READ_VSEC_PSL_REVISION(dev, vsec, dest) \
> -	pci_read_config_word(dev, vsec + 0xc, dest)
> -#define CXL_READ_VSEC_CAIA_MINOR(dev, vsec, dest) \
> -	pci_read_config_byte(dev, vsec + 0xe, dest)
> -#define CXL_READ_VSEC_CAIA_MAJOR(dev, vsec, dest) \
> -	pci_read_config_byte(dev, vsec + 0xf, dest)
> -#define CXL_READ_VSEC_BASE_IMAGE(dev, vsec, dest) \
> -	pci_read_config_word(dev, vsec + 0x10, dest)
> -
> -#define CXL_READ_VSEC_IMAGE_STATE(dev, vsec, dest) \
> -	pci_read_config_byte(dev, vsec + 0x13, dest)
> -#define CXL_WRITE_VSEC_IMAGE_STATE(dev, vsec, val) \
> -	pci_write_config_byte(dev, vsec + 0x13, val)
> -#define CXL_VSEC_USER_IMAGE_LOADED 0x80 /* RO */
> -#define CXL_VSEC_PERST_LOADS_IMAGE 0x20 /* RW */
> -#define CXL_VSEC_PERST_SELECT_USER 0x10 /* RW */
> -
> -#define CXL_READ_VSEC_AFU_DESC_OFF(dev, vsec, dest) \
> -	pci_read_config_dword(dev, vsec + 0x20, dest)
> -#define CXL_READ_VSEC_AFU_DESC_SIZE(dev, vsec, dest) \
> -	pci_read_config_dword(dev, vsec + 0x24, dest)
> -#define CXL_READ_VSEC_PS_OFF(dev, vsec, dest) \
> -	pci_read_config_dword(dev, vsec + 0x28, dest)
> -#define CXL_READ_VSEC_PS_SIZE(dev, vsec, dest) \
> -	pci_read_config_dword(dev, vsec + 0x2c, dest)
> -
> -
> -/* This works a little different than the p1/p2 register accesses to make it
> - * easier to pull out individual fields */
> -#define AFUD_READ(afu, off)		in_be64(afu->native->afu_desc_mmio + off)
> -#define AFUD_READ_LE(afu, off)		in_le64(afu->native->afu_desc_mmio + off)
> -#define EXTRACT_PPC_BIT(val, bit)	(!!(val & PPC_BIT(bit)))
> -#define EXTRACT_PPC_BITS(val, bs, be)	((val & PPC_BITMASK(bs, be)) >> PPC_BITLSHIFT(be))
> -
> -#define AFUD_READ_INFO(afu)		AFUD_READ(afu, 0x0)
> -#define   AFUD_NUM_INTS_PER_PROC(val)	EXTRACT_PPC_BITS(val,  0, 15)
> -#define   AFUD_NUM_PROCS(val)		EXTRACT_PPC_BITS(val, 16, 31)
> -#define   AFUD_NUM_CRS(val)		EXTRACT_PPC_BITS(val, 32, 47)
> -#define   AFUD_MULTIMODE(val)		EXTRACT_PPC_BIT(val, 48)
> -#define   AFUD_PUSH_BLOCK_TRANSFER(val)	EXTRACT_PPC_BIT(val, 55)
> -#define   AFUD_DEDICATED_PROCESS(val)	EXTRACT_PPC_BIT(val, 59)
> -#define   AFUD_AFU_DIRECTED(val)	EXTRACT_PPC_BIT(val, 61)
> -#define   AFUD_TIME_SLICED(val)		EXTRACT_PPC_BIT(val, 63)
> -#define AFUD_READ_CR(afu)		AFUD_READ(afu, 0x20)
> -#define   AFUD_CR_LEN(val)		EXTRACT_PPC_BITS(val, 8, 63)
> -#define AFUD_READ_CR_OFF(afu)		AFUD_READ(afu, 0x28)
> -#define AFUD_READ_PPPSA(afu)		AFUD_READ(afu, 0x30)
> -#define   AFUD_PPPSA_PP(val)		EXTRACT_PPC_BIT(val, 6)
> -#define   AFUD_PPPSA_PSA(val)		EXTRACT_PPC_BIT(val, 7)
> -#define   AFUD_PPPSA_LEN(val)		EXTRACT_PPC_BITS(val, 8, 63)
> -#define AFUD_READ_PPPSA_OFF(afu)	AFUD_READ(afu, 0x38)
> -#define AFUD_READ_EB(afu)		AFUD_READ(afu, 0x40)
> -#define   AFUD_EB_LEN(val)		EXTRACT_PPC_BITS(val, 8, 63)
> -#define AFUD_READ_EB_OFF(afu)		AFUD_READ(afu, 0x48)
> -
> -static const struct pci_device_id cxl_pci_tbl[] = {
> -	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x0477), },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x044b), },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x04cf), },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x0601), },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x0623), },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x0628), },
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(pci, cxl_pci_tbl);
> -
> -
> -/*
> - * Mostly using these wrappers to avoid confusion:
> - * priv 1 is BAR2, while priv 2 is BAR0
> - */
> -static inline resource_size_t p1_base(struct pci_dev *dev)
> -{
> -	return pci_resource_start(dev, 2);
> -}
> -
> -static inline resource_size_t p1_size(struct pci_dev *dev)
> -{
> -	return pci_resource_len(dev, 2);
> -}
> -
> -static inline resource_size_t p2_base(struct pci_dev *dev)
> -{
> -	return pci_resource_start(dev, 0);
> -}
> -
> -static inline resource_size_t p2_size(struct pci_dev *dev)
> -{
> -	return pci_resource_len(dev, 0);
> -}
> -
> -static int find_cxl_vsec(struct pci_dev *dev)
> -{
> -	return pci_find_vsec_capability(dev, PCI_VENDOR_ID_IBM, CXL_PCI_VSEC_ID);
> -}
> -
> -static void dump_cxl_config_space(struct pci_dev *dev)
> -{
> -	int vsec;
> -	u32 val;
> -
> -	dev_info(&dev->dev, "dump_cxl_config_space\n");
> -
> -	pci_read_config_dword(dev, PCI_BASE_ADDRESS_0, &val);
> -	dev_info(&dev->dev, "BAR0: %#.8x\n", val);
> -	pci_read_config_dword(dev, PCI_BASE_ADDRESS_1, &val);
> -	dev_info(&dev->dev, "BAR1: %#.8x\n", val);
> -	pci_read_config_dword(dev, PCI_BASE_ADDRESS_2, &val);
> -	dev_info(&dev->dev, "BAR2: %#.8x\n", val);
> -	pci_read_config_dword(dev, PCI_BASE_ADDRESS_3, &val);
> -	dev_info(&dev->dev, "BAR3: %#.8x\n", val);
> -	pci_read_config_dword(dev, PCI_BASE_ADDRESS_4, &val);
> -	dev_info(&dev->dev, "BAR4: %#.8x\n", val);
> -	pci_read_config_dword(dev, PCI_BASE_ADDRESS_5, &val);
> -	dev_info(&dev->dev, "BAR5: %#.8x\n", val);
> -
> -	dev_info(&dev->dev, "p1 regs: %#llx, len: %#llx\n",
> -		p1_base(dev), p1_size(dev));
> -	dev_info(&dev->dev, "p2 regs: %#llx, len: %#llx\n",
> -		p2_base(dev), p2_size(dev));
> -	dev_info(&dev->dev, "BAR 4/5: %#llx, len: %#llx\n",
> -		pci_resource_start(dev, 4), pci_resource_len(dev, 4));
> -
> -	if (!(vsec = find_cxl_vsec(dev)))
> -		return;
> -
> -#define show_reg(name, what) \
> -	dev_info(&dev->dev, "cxl vsec: %30s: %#x\n", name, what)
> -
> -	pci_read_config_dword(dev, vsec + 0x0, &val);
> -	show_reg("Cap ID", (val >> 0) & 0xffff);
> -	show_reg("Cap Ver", (val >> 16) & 0xf);
> -	show_reg("Next Cap Ptr", (val >> 20) & 0xfff);
> -	pci_read_config_dword(dev, vsec + 0x4, &val);
> -	show_reg("VSEC ID", (val >> 0) & 0xffff);
> -	show_reg("VSEC Rev", (val >> 16) & 0xf);
> -	show_reg("VSEC Length",	(val >> 20) & 0xfff);
> -	pci_read_config_dword(dev, vsec + 0x8, &val);
> -	show_reg("Num AFUs", (val >> 0) & 0xff);
> -	show_reg("Status", (val >> 8) & 0xff);
> -	show_reg("Mode Control", (val >> 16) & 0xff);
> -	show_reg("Reserved", (val >> 24) & 0xff);
> -	pci_read_config_dword(dev, vsec + 0xc, &val);
> -	show_reg("PSL Rev", (val >> 0) & 0xffff);
> -	show_reg("CAIA Ver", (val >> 16) & 0xffff);
> -	pci_read_config_dword(dev, vsec + 0x10, &val);
> -	show_reg("Base Image Rev", (val >> 0) & 0xffff);
> -	show_reg("Reserved", (val >> 16) & 0x0fff);
> -	show_reg("Image Control", (val >> 28) & 0x3);
> -	show_reg("Reserved", (val >> 30) & 0x1);
> -	show_reg("Image Loaded", (val >> 31) & 0x1);
> -
> -	pci_read_config_dword(dev, vsec + 0x14, &val);
> -	show_reg("Reserved", val);
> -	pci_read_config_dword(dev, vsec + 0x18, &val);
> -	show_reg("Reserved", val);
> -	pci_read_config_dword(dev, vsec + 0x1c, &val);
> -	show_reg("Reserved", val);
> -
> -	pci_read_config_dword(dev, vsec + 0x20, &val);
> -	show_reg("AFU Descriptor Offset", val);
> -	pci_read_config_dword(dev, vsec + 0x24, &val);
> -	show_reg("AFU Descriptor Size", val);
> -	pci_read_config_dword(dev, vsec + 0x28, &val);
> -	show_reg("Problem State Offset", val);
> -	pci_read_config_dword(dev, vsec + 0x2c, &val);
> -	show_reg("Problem State Size", val);
> -
> -	pci_read_config_dword(dev, vsec + 0x30, &val);
> -	show_reg("Reserved", val);
> -	pci_read_config_dword(dev, vsec + 0x34, &val);
> -	show_reg("Reserved", val);
> -	pci_read_config_dword(dev, vsec + 0x38, &val);
> -	show_reg("Reserved", val);
> -	pci_read_config_dword(dev, vsec + 0x3c, &val);
> -	show_reg("Reserved", val);
> -
> -	pci_read_config_dword(dev, vsec + 0x40, &val);
> -	show_reg("PSL Programming Port", val);
> -	pci_read_config_dword(dev, vsec + 0x44, &val);
> -	show_reg("PSL Programming Control", val);
> -
> -	pci_read_config_dword(dev, vsec + 0x48, &val);
> -	show_reg("Reserved", val);
> -	pci_read_config_dword(dev, vsec + 0x4c, &val);
> -	show_reg("Reserved", val);
> -
> -	pci_read_config_dword(dev, vsec + 0x50, &val);
> -	show_reg("Flash Address Register", val);
> -	pci_read_config_dword(dev, vsec + 0x54, &val);
> -	show_reg("Flash Size Register", val);
> -	pci_read_config_dword(dev, vsec + 0x58, &val);
> -	show_reg("Flash Status/Control Register", val);
> -	pci_read_config_dword(dev, vsec + 0x58, &val);
> -	show_reg("Flash Data Port", val);
> -
> -#undef show_reg
> -}
> -
> -static void dump_afu_descriptor(struct cxl_afu *afu)
> -{
> -	u64 val, afu_cr_num, afu_cr_off, afu_cr_len;
> -	int i;
> -
> -#define show_reg(name, what) \
> -	dev_info(&afu->dev, "afu desc: %30s: %#llx\n", name, what)
> -
> -	val = AFUD_READ_INFO(afu);
> -	show_reg("num_ints_per_process", AFUD_NUM_INTS_PER_PROC(val));
> -	show_reg("num_of_processes", AFUD_NUM_PROCS(val));
> -	show_reg("num_of_afu_CRs", AFUD_NUM_CRS(val));
> -	show_reg("req_prog_mode", val & 0xffffULL);
> -	afu_cr_num = AFUD_NUM_CRS(val);
> -
> -	val = AFUD_READ(afu, 0x8);
> -	show_reg("Reserved", val);
> -	val = AFUD_READ(afu, 0x10);
> -	show_reg("Reserved", val);
> -	val = AFUD_READ(afu, 0x18);
> -	show_reg("Reserved", val);
> -
> -	val = AFUD_READ_CR(afu);
> -	show_reg("Reserved", (val >> (63-7)) & 0xff);
> -	show_reg("AFU_CR_len", AFUD_CR_LEN(val));
> -	afu_cr_len = AFUD_CR_LEN(val) * 256;
> -
> -	val = AFUD_READ_CR_OFF(afu);
> -	afu_cr_off = val;
> -	show_reg("AFU_CR_offset", val);
> -
> -	val = AFUD_READ_PPPSA(afu);
> -	show_reg("PerProcessPSA_control", (val >> (63-7)) & 0xff);
> -	show_reg("PerProcessPSA Length", AFUD_PPPSA_LEN(val));
> -
> -	val = AFUD_READ_PPPSA_OFF(afu);
> -	show_reg("PerProcessPSA_offset", val);
> -
> -	val = AFUD_READ_EB(afu);
> -	show_reg("Reserved", (val >> (63-7)) & 0xff);
> -	show_reg("AFU_EB_len", AFUD_EB_LEN(val));
> -
> -	val = AFUD_READ_EB_OFF(afu);
> -	show_reg("AFU_EB_offset", val);
> -
> -	for (i = 0; i < afu_cr_num; i++) {
> -		val = AFUD_READ_LE(afu, afu_cr_off + i * afu_cr_len);
> -		show_reg("CR Vendor", val & 0xffff);
> -		show_reg("CR Device", (val >> 16) & 0xffff);
> -	}
> -#undef show_reg
> -}
> -
> -#define P8_CAPP_UNIT0_ID 0xBA
> -#define P8_CAPP_UNIT1_ID 0XBE
> -#define P9_CAPP_UNIT0_ID 0xC0
> -#define P9_CAPP_UNIT1_ID 0xE0
> -
> -static int get_phb_index(struct device_node *np, u32 *phb_index)
> -{
> -	if (of_property_read_u32(np, "ibm,phb-index", phb_index))
> -		return -ENODEV;
> -	return 0;
> -}
> -
> -static u64 get_capp_unit_id(struct device_node *np, u32 phb_index)
> -{
> -	/*
> -	 * POWER 8:
> -	 *  - For chips other than POWER8NVL, we only have CAPP 0,
> -	 *    irrespective of which PHB is used.
> -	 *  - For POWER8NVL, assume CAPP 0 is attached to PHB0 and
> -	 *    CAPP 1 is attached to PHB1.
> -	 */
> -	if (cxl_is_power8()) {
> -		if (!pvr_version_is(PVR_POWER8NVL))
> -			return P8_CAPP_UNIT0_ID;
> -
> -		if (phb_index == 0)
> -			return P8_CAPP_UNIT0_ID;
> -
> -		if (phb_index == 1)
> -			return P8_CAPP_UNIT1_ID;
> -	}
> -
> -	/*
> -	 * POWER 9:
> -	 *   PEC0 (PHB0). Capp ID = CAPP0 (0b1100_0000)
> -	 *   PEC1 (PHB1 - PHB2). No capi mode
> -	 *   PEC2 (PHB3 - PHB4 - PHB5): Capi mode on PHB3 only. Capp ID = CAPP1 (0b1110_0000)
> -	 */
> -	if (cxl_is_power9()) {
> -		if (phb_index == 0)
> -			return P9_CAPP_UNIT0_ID;
> -
> -		if (phb_index == 3)
> -			return P9_CAPP_UNIT1_ID;
> -	}
> -
> -	return 0;
> -}
> -
> -int cxl_calc_capp_routing(struct pci_dev *dev, u64 *chipid,
> -			     u32 *phb_index, u64 *capp_unit_id)
> -{
> -	int rc;
> -	struct device_node *np;
> -	u32 id;
> -
> -	if (!(np = pnv_pci_get_phb_node(dev)))
> -		return -ENODEV;
> -
> -	while (np && of_property_read_u32(np, "ibm,chip-id", &id))
> -		np = of_get_next_parent(np);
> -	if (!np)
> -		return -ENODEV;
> -
> -	*chipid = id;
> -
> -	rc = get_phb_index(np, phb_index);
> -	if (rc) {
> -		pr_err("cxl: invalid phb index\n");
> -		of_node_put(np);
> -		return rc;
> -	}
> -
> -	*capp_unit_id = get_capp_unit_id(np, *phb_index);
> -	of_node_put(np);
> -	if (!*capp_unit_id) {
> -		pr_err("cxl: No capp unit found for PHB[%lld,%d]. Make sure the adapter is on a capi-compatible slot\n",
> -		       *chipid, *phb_index);
> -		return -ENODEV;
> -	}
> -
> -	return 0;
> -}
> -
> -static DEFINE_MUTEX(indications_mutex);
> -
> -static int get_phb_indications(struct pci_dev *dev, u64 *capiind, u64 *asnind,
> -			       u64 *nbwind)
> -{
> -	static u32 val[3];
> -	struct device_node *np;
> -
> -	mutex_lock(&indications_mutex);
> -	if (!val[0]) {
> -		if (!(np = pnv_pci_get_phb_node(dev))) {
> -			mutex_unlock(&indications_mutex);
> -			return -ENODEV;
> -		}
> -
> -		if (of_property_read_u32_array(np, "ibm,phb-indications", val, 3)) {
> -			val[2] = 0x0300UL; /* legacy values */
> -			val[1] = 0x0400UL;
> -			val[0] = 0x0200UL;
> -		}
> -		of_node_put(np);
> -	}
> -	*capiind = val[0];
> -	*asnind = val[1];
> -	*nbwind = val[2];
> -	mutex_unlock(&indications_mutex);
> -	return 0;
> -}
> -
> -int cxl_get_xsl9_dsnctl(struct pci_dev *dev, u64 capp_unit_id, u64 *reg)
> -{
> -	u64 xsl_dsnctl;
> -	u64 capiind, asnind, nbwind;
> -
> -	/*
> -	 * CAPI Identifier bits [0:7]
> -	 * bit 61:60 MSI bits --> 0
> -	 * bit 59 TVT selector --> 0
> -	 */
> -	if (get_phb_indications(dev, &capiind, &asnind, &nbwind))
> -		return -ENODEV;
> -
> -	/*
> -	 * Tell XSL where to route data to.
> -	 * The field chipid should match the PHB CAPI_CMPM register
> -	 */
> -	xsl_dsnctl = (capiind << (63-15)); /* Bit 57 */
> -	xsl_dsnctl |= (capp_unit_id << (63-15));
> -
> -	/* nMMU_ID Defaults to: b’000001001’*/
> -	xsl_dsnctl |= ((u64)0x09 << (63-28));
> -
> -	/*
> -	 * Used to identify CAPI packets which should be sorted into
> -	 * the Non-Blocking queues by the PHB. This field should match
> -	 * the PHB PBL_NBW_CMPM register
> -	 * nbwind=0x03, bits [57:58], must include capi indicator.
> -	 * Not supported on P9 DD1.
> -	 */
> -	xsl_dsnctl |= (nbwind << (63-55));
> -
> -	/*
> -	 * Upper 16b address bits of ASB_Notify messages sent to the
> -	 * system. Need to match the PHB’s ASN Compare/Mask Register.
> -	 * Not supported on P9 DD1.
> -	 */
> -	xsl_dsnctl |= asnind;
> -
> -	*reg = xsl_dsnctl;
> -	return 0;
> -}
> -
> -static int init_implementation_adapter_regs_psl9(struct cxl *adapter,
> -						 struct pci_dev *dev)
> -{
> -	u64 xsl_dsnctl, psl_fircntl;
> -	u64 chipid;
> -	u32 phb_index;
> -	u64 capp_unit_id;
> -	u64 psl_debug;
> -	int rc;
> -
> -	rc = cxl_calc_capp_routing(dev, &chipid, &phb_index, &capp_unit_id);
> -	if (rc)
> -		return rc;
> -
> -	rc = cxl_get_xsl9_dsnctl(dev, capp_unit_id, &xsl_dsnctl);
> -	if (rc)
> -		return rc;
> -
> -	cxl_p1_write(adapter, CXL_XSL9_DSNCTL, xsl_dsnctl);
> -
> -	/* Set fir_cntl to recommended value for production env */
> -	psl_fircntl = (0x2ULL << (63-3)); /* ce_report */
> -	psl_fircntl |= (0x1ULL << (63-6)); /* FIR_report */
> -	psl_fircntl |= 0x1ULL; /* ce_thresh */
> -	cxl_p1_write(adapter, CXL_PSL9_FIR_CNTL, psl_fircntl);
> -
> -	/* Setup the PSL to transmit packets on the PCIe before the
> -	 * CAPP is enabled. Make sure that CAPP virtual machines are disabled
> -	 */
> -	cxl_p1_write(adapter, CXL_PSL9_DSNDCTL, 0x0001001000012A10ULL);
> -
> -	/*
> -	 * A response to an ASB_Notify request is returned by the
> -	 * system as an MMIO write to the address defined in
> -	 * the PSL_TNR_ADDR register.
> -	 * keep the Reset Value: 0x00020000E0000000
> -	 */
> -
> -	/* Enable XSL rty limit */
> -	cxl_p1_write(adapter, CXL_XSL9_DEF, 0x51F8000000000005ULL);
> -
> -	/* Change XSL_INV dummy read threshold */
> -	cxl_p1_write(adapter, CXL_XSL9_INV, 0x0000040007FFC200ULL);
> -
> -	if (phb_index == 3) {
> -		/* disable machines 31-47 and 20-27 for DMA */
> -		cxl_p1_write(adapter, CXL_PSL9_APCDEDTYPE, 0x40000FF3FFFF0000ULL);
> -	}
> -
> -	/* Snoop machines */
> -	cxl_p1_write(adapter, CXL_PSL9_APCDEDALLOC, 0x800F000200000000ULL);
> -
> -	/* Enable NORST and DD2 features */
> -	cxl_p1_write(adapter, CXL_PSL9_DEBUG, 0xC000000000000000ULL);
> -
> -	/*
> -	 * Check if PSL has data-cache. We need to flush adapter datacache
> -	 * when as its about to be removed.
> -	 */
> -	psl_debug = cxl_p1_read(adapter, CXL_PSL9_DEBUG);
> -	if (psl_debug & CXL_PSL_DEBUG_CDC) {
> -		dev_dbg(&dev->dev, "No data-cache present\n");
> -		adapter->native->no_data_cache = true;
> -	}
> -
> -	return 0;
> -}
> -
> -static int init_implementation_adapter_regs_psl8(struct cxl *adapter, struct pci_dev *dev)
> -{
> -	u64 psl_dsnctl, psl_fircntl;
> -	u64 chipid;
> -	u32 phb_index;
> -	u64 capp_unit_id;
> -	int rc;
> -
> -	rc = cxl_calc_capp_routing(dev, &chipid, &phb_index, &capp_unit_id);
> -	if (rc)
> -		return rc;
> -
> -	psl_dsnctl = 0x0000900000000000ULL; /* pteupd ttype, scdone */
> -	psl_dsnctl |= (0x2ULL << (63-38)); /* MMIO hang pulse: 256 us */
> -	/* Tell PSL where to route data to */
> -	psl_dsnctl |= (chipid << (63-5));
> -	psl_dsnctl |= (capp_unit_id << (63-13));
> -
> -	cxl_p1_write(adapter, CXL_PSL_DSNDCTL, psl_dsnctl);
> -	cxl_p1_write(adapter, CXL_PSL_RESLCKTO, 0x20000000200ULL);
> -	/* snoop write mask */
> -	cxl_p1_write(adapter, CXL_PSL_SNWRALLOC, 0x00000000FFFFFFFFULL);
> -	/* set fir_cntl to recommended value for production env */
> -	psl_fircntl = (0x2ULL << (63-3)); /* ce_report */
> -	psl_fircntl |= (0x1ULL << (63-6)); /* FIR_report */
> -	psl_fircntl |= 0x1ULL; /* ce_thresh */
> -	cxl_p1_write(adapter, CXL_PSL_FIR_CNTL, psl_fircntl);
> -	/* for debugging with trace arrays */
> -	cxl_p1_write(adapter, CXL_PSL_TRACE, 0x0000FF7C00000000ULL);
> -
> -	return 0;
> -}
> -
> -/* PSL */
> -#define TBSYNC_CAL(n) (((u64)n & 0x7) << (63-3))
> -#define TBSYNC_CNT(n) (((u64)n & 0x7) << (63-6))
> -/* For the PSL this is a multiple for 0 < n <= 7: */
> -#define PSL_2048_250MHZ_CYCLES 1
> -
> -static void write_timebase_ctrl_psl8(struct cxl *adapter)
> -{
> -	cxl_p1_write(adapter, CXL_PSL_TB_CTLSTAT,
> -		     TBSYNC_CNT(2 * PSL_2048_250MHZ_CYCLES));
> -}
> -
> -static u64 timebase_read_psl9(struct cxl *adapter)
> -{
> -	return cxl_p1_read(adapter, CXL_PSL9_Timebase);
> -}
> -
> -static u64 timebase_read_psl8(struct cxl *adapter)
> -{
> -	return cxl_p1_read(adapter, CXL_PSL_Timebase);
> -}
> -
> -static void cxl_setup_psl_timebase(struct cxl *adapter, struct pci_dev *dev)
> -{
> -	struct device_node *np;
> -
> -	adapter->psl_timebase_synced = false;
> -
> -	if (!(np = pnv_pci_get_phb_node(dev)))
> -		return;
> -
> -	/* Do not fail when CAPP timebase sync is not supported by OPAL */
> -	of_node_get(np);
> -	if (!of_property_present(np, "ibm,capp-timebase-sync")) {
> -		of_node_put(np);
> -		dev_info(&dev->dev, "PSL timebase inactive: OPAL support missing\n");
> -		return;
> -	}
> -	of_node_put(np);
> -
> -	/*
> -	 * Setup PSL Timebase Control and Status register
> -	 * with the recommended Timebase Sync Count value
> -	 */
> -	if (adapter->native->sl_ops->write_timebase_ctrl)
> -		adapter->native->sl_ops->write_timebase_ctrl(adapter);
> -
> -	/* Enable PSL Timebase */
> -	cxl_p1_write(adapter, CXL_PSL_Control, 0x0000000000000000);
> -	cxl_p1_write(adapter, CXL_PSL_Control, CXL_PSL_Control_tb);
> -
> -	return;
> -}
> -
> -static int init_implementation_afu_regs_psl9(struct cxl_afu *afu)
> -{
> -	return 0;
> -}
> -
> -static int init_implementation_afu_regs_psl8(struct cxl_afu *afu)
> -{
> -	/* read/write masks for this slice */
> -	cxl_p1n_write(afu, CXL_PSL_APCALLOC_A, 0xFFFFFFFEFEFEFEFEULL);
> -	/* APC read/write masks for this slice */
> -	cxl_p1n_write(afu, CXL_PSL_COALLOC_A, 0xFF000000FEFEFEFEULL);
> -	/* for debugging with trace arrays */
> -	cxl_p1n_write(afu, CXL_PSL_SLICE_TRACE, 0x0000FFFF00000000ULL);
> -	cxl_p1n_write(afu, CXL_PSL_RXCTL_A, CXL_PSL_RXCTL_AFUHP_4S);
> -
> -	return 0;
> -}
> -
> -int cxl_pci_setup_irq(struct cxl *adapter, unsigned int hwirq,
> -		unsigned int virq)
> -{
> -	struct pci_dev *dev = to_pci_dev(adapter->dev.parent);
> -
> -	return pnv_cxl_ioda_msi_setup(dev, hwirq, virq);
> -}
> -
> -int cxl_update_image_control(struct cxl *adapter)
> -{
> -	struct pci_dev *dev = to_pci_dev(adapter->dev.parent);
> -	int rc;
> -	int vsec;
> -	u8 image_state;
> -
> -	if (!(vsec = find_cxl_vsec(dev))) {
> -		dev_err(&dev->dev, "ABORTING: CXL VSEC not found!\n");
> -		return -ENODEV;
> -	}
> -
> -	if ((rc = CXL_READ_VSEC_IMAGE_STATE(dev, vsec, &image_state))) {
> -		dev_err(&dev->dev, "failed to read image state: %i\n", rc);
> -		return rc;
> -	}
> -
> -	if (adapter->perst_loads_image)
> -		image_state |= CXL_VSEC_PERST_LOADS_IMAGE;
> -	else
> -		image_state &= ~CXL_VSEC_PERST_LOADS_IMAGE;
> -
> -	if (adapter->perst_select_user)
> -		image_state |= CXL_VSEC_PERST_SELECT_USER;
> -	else
> -		image_state &= ~CXL_VSEC_PERST_SELECT_USER;
> -
> -	if ((rc = CXL_WRITE_VSEC_IMAGE_STATE(dev, vsec, image_state))) {
> -		dev_err(&dev->dev, "failed to update image control: %i\n", rc);
> -		return rc;
> -	}
> -
> -	return 0;
> -}
> -
> -int cxl_pci_alloc_one_irq(struct cxl *adapter)
> -{
> -	struct pci_dev *dev = to_pci_dev(adapter->dev.parent);
> -
> -	return pnv_cxl_alloc_hwirqs(dev, 1);
> -}
> -
> -void cxl_pci_release_one_irq(struct cxl *adapter, int hwirq)
> -{
> -	struct pci_dev *dev = to_pci_dev(adapter->dev.parent);
> -
> -	return pnv_cxl_release_hwirqs(dev, hwirq, 1);
> -}
> -
> -int cxl_pci_alloc_irq_ranges(struct cxl_irq_ranges *irqs,
> -			struct cxl *adapter, unsigned int num)
> -{
> -	struct pci_dev *dev = to_pci_dev(adapter->dev.parent);
> -
> -	return pnv_cxl_alloc_hwirq_ranges(irqs, dev, num);
> -}
> -
> -void cxl_pci_release_irq_ranges(struct cxl_irq_ranges *irqs,
> -				struct cxl *adapter)
> -{
> -	struct pci_dev *dev = to_pci_dev(adapter->dev.parent);
> -
> -	pnv_cxl_release_hwirq_ranges(irqs, dev);
> -}
> -
> -static int setup_cxl_bars(struct pci_dev *dev)
> -{
> -	/* Safety check in case we get backported to < 3.17 without M64 */
> -	if ((p1_base(dev) < 0x100000000ULL) ||
> -	    (p2_base(dev) < 0x100000000ULL)) {
> -		dev_err(&dev->dev, "ABORTING: M32 BAR assignment incompatible with CXL\n");
> -		return -ENODEV;
> -	}
> -
> -	/*
> -	 * BAR 4/5 has a special meaning for CXL and must be programmed with a
> -	 * special value corresponding to the CXL protocol address range.
> -	 * For POWER 8/9 that means bits 48:49 must be set to 10
> -	 */
> -	pci_write_config_dword(dev, PCI_BASE_ADDRESS_4, 0x00000000);
> -	pci_write_config_dword(dev, PCI_BASE_ADDRESS_5, 0x00020000);
> -
> -	return 0;
> -}
> -
> -/* pciex node: ibm,opal-m64-window = <0x3d058 0x0 0x3d058 0x0 0x8 0x0>; */
> -static int switch_card_to_cxl(struct pci_dev *dev)
> -{
> -	int vsec;
> -	u8 val;
> -	int rc;
> -
> -	dev_info(&dev->dev, "switch card to CXL\n");
> -
> -	if (!(vsec = find_cxl_vsec(dev))) {
> -		dev_err(&dev->dev, "ABORTING: CXL VSEC not found!\n");
> -		return -ENODEV;
> -	}
> -
> -	if ((rc = CXL_READ_VSEC_MODE_CONTROL(dev, vsec, &val))) {
> -		dev_err(&dev->dev, "failed to read current mode control: %i", rc);
> -		return rc;
> -	}
> -	val &= ~CXL_VSEC_PROTOCOL_MASK;
> -	val |= CXL_VSEC_PROTOCOL_256TB | CXL_VSEC_PROTOCOL_ENABLE;
> -	if ((rc = CXL_WRITE_VSEC_MODE_CONTROL(dev, vsec, val))) {
> -		dev_err(&dev->dev, "failed to enable CXL protocol: %i", rc);
> -		return rc;
> -	}
> -	/*
> -	 * The CAIA spec (v0.12 11.6 Bi-modal Device Support) states
> -	 * we must wait 100ms after this mode switch before touching
> -	 * PCIe config space.
> -	 */
> -	msleep(100);
> -
> -	return 0;
> -}
> -
> -static int pci_map_slice_regs(struct cxl_afu *afu, struct cxl *adapter, struct pci_dev *dev)
> -{
> -	u64 p1n_base, p2n_base, afu_desc;
> -	const u64 p1n_size = 0x100;
> -	const u64 p2n_size = 0x1000;
> -
> -	p1n_base = p1_base(dev) + 0x10000 + (afu->slice * p1n_size);
> -	p2n_base = p2_base(dev) + (afu->slice * p2n_size);
> -	afu->psn_phys = p2_base(dev) + (adapter->native->ps_off + (afu->slice * adapter->ps_size));
> -	afu_desc = p2_base(dev) + adapter->native->afu_desc_off + (afu->slice * adapter->native->afu_desc_size);
> -
> -	if (!(afu->native->p1n_mmio = ioremap(p1n_base, p1n_size)))
> -		goto err;
> -	if (!(afu->p2n_mmio = ioremap(p2n_base, p2n_size)))
> -		goto err1;
> -	if (afu_desc) {
> -		if (!(afu->native->afu_desc_mmio = ioremap(afu_desc, adapter->native->afu_desc_size)))
> -			goto err2;
> -	}
> -
> -	return 0;
> -err2:
> -	iounmap(afu->p2n_mmio);
> -err1:
> -	iounmap(afu->native->p1n_mmio);
> -err:
> -	dev_err(&afu->dev, "Error mapping AFU MMIO regions\n");
> -	return -ENOMEM;
> -}
> -
> -static void pci_unmap_slice_regs(struct cxl_afu *afu)
> -{
> -	if (afu->p2n_mmio) {
> -		iounmap(afu->p2n_mmio);
> -		afu->p2n_mmio = NULL;
> -	}
> -	if (afu->native->p1n_mmio) {
> -		iounmap(afu->native->p1n_mmio);
> -		afu->native->p1n_mmio = NULL;
> -	}
> -	if (afu->native->afu_desc_mmio) {
> -		iounmap(afu->native->afu_desc_mmio);
> -		afu->native->afu_desc_mmio = NULL;
> -	}
> -}
> -
> -void cxl_pci_release_afu(struct device *dev)
> -{
> -	struct cxl_afu *afu = to_cxl_afu(dev);
> -
> -	pr_devel("%s\n", __func__);
> -
> -	idr_destroy(&afu->contexts_idr);
> -	cxl_release_spa(afu);
> -
> -	kfree(afu->native);
> -	kfree(afu);
> -}
> -
> -/* Expects AFU struct to have recently been zeroed out */
> -static int cxl_read_afu_descriptor(struct cxl_afu *afu)
> -{
> -	u64 val;
> -
> -	val = AFUD_READ_INFO(afu);
> -	afu->pp_irqs = AFUD_NUM_INTS_PER_PROC(val);
> -	afu->max_procs_virtualised = AFUD_NUM_PROCS(val);
> -	afu->crs_num = AFUD_NUM_CRS(val);
> -
> -	if (AFUD_AFU_DIRECTED(val))
> -		afu->modes_supported |= CXL_MODE_DIRECTED;
> -	if (AFUD_DEDICATED_PROCESS(val))
> -		afu->modes_supported |= CXL_MODE_DEDICATED;
> -	if (AFUD_TIME_SLICED(val))
> -		afu->modes_supported |= CXL_MODE_TIME_SLICED;
> -
> -	val = AFUD_READ_PPPSA(afu);
> -	afu->pp_size = AFUD_PPPSA_LEN(val) * 4096;
> -	afu->psa = AFUD_PPPSA_PSA(val);
> -	if ((afu->pp_psa = AFUD_PPPSA_PP(val)))
> -		afu->native->pp_offset = AFUD_READ_PPPSA_OFF(afu);
> -
> -	val = AFUD_READ_CR(afu);
> -	afu->crs_len = AFUD_CR_LEN(val) * 256;
> -	afu->crs_offset = AFUD_READ_CR_OFF(afu);
> -
> -
> -	/* eb_len is in multiple of 4K */
> -	afu->eb_len = AFUD_EB_LEN(AFUD_READ_EB(afu)) * 4096;
> -	afu->eb_offset = AFUD_READ_EB_OFF(afu);
> -
> -	/* eb_off is 4K aligned so lower 12 bits are always zero */
> -	if (EXTRACT_PPC_BITS(afu->eb_offset, 0, 11) != 0) {
> -		dev_warn(&afu->dev,
> -			 "Invalid AFU error buffer offset %Lx\n",
> -			 afu->eb_offset);
> -		dev_info(&afu->dev,
> -			 "Ignoring AFU error buffer in the descriptor\n");
> -		/* indicate that no afu buffer exists */
> -		afu->eb_len = 0;
> -	}
> -
> -	return 0;
> -}
> -
> -static int cxl_afu_descriptor_looks_ok(struct cxl_afu *afu)
> -{
> -	int i, rc;
> -	u32 val;
> -
> -	if (afu->psa && afu->adapter->ps_size <
> -			(afu->native->pp_offset + afu->pp_size*afu->max_procs_virtualised)) {
> -		dev_err(&afu->dev, "per-process PSA can't fit inside the PSA!\n");
> -		return -ENODEV;
> -	}
> -
> -	if (afu->pp_psa && (afu->pp_size < PAGE_SIZE))
> -		dev_warn(&afu->dev, "AFU uses pp_size(%#016llx) < PAGE_SIZE per-process PSA!\n", afu->pp_size);
> -
> -	for (i = 0; i < afu->crs_num; i++) {
> -		rc = cxl_ops->afu_cr_read32(afu, i, 0, &val);
> -		if (rc || val == 0) {
> -			dev_err(&afu->dev, "ABORTING: AFU configuration record %i is invalid\n", i);
> -			return -EINVAL;
> -		}
> -	}
> -
> -	if ((afu->modes_supported & ~CXL_MODE_DEDICATED) && afu->max_procs_virtualised == 0) {
> -		/*
> -		 * We could also check this for the dedicated process model
> -		 * since the architecture indicates it should be set to 1, but
> -		 * in that case we ignore the value and I'd rather not risk
> -		 * breaking any existing dedicated process AFUs that left it as
> -		 * 0 (not that I'm aware of any). It is clearly an error for an
> -		 * AFU directed AFU to set this to 0, and would have previously
> -		 * triggered a bug resulting in the maximum not being enforced
> -		 * at all since idr_alloc treats 0 as no maximum.
> -		 */
> -		dev_err(&afu->dev, "AFU does not support any processes\n");
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
> -static int sanitise_afu_regs_psl9(struct cxl_afu *afu)
> -{
> -	u64 reg;
> -
> -	/*
> -	 * Clear out any regs that contain either an IVTE or address or may be
> -	 * waiting on an acknowledgment to try to be a bit safer as we bring
> -	 * it online
> -	 */
> -	reg = cxl_p2n_read(afu, CXL_AFU_Cntl_An);
> -	if ((reg & CXL_AFU_Cntl_An_ES_MASK) != CXL_AFU_Cntl_An_ES_Disabled) {
> -		dev_warn(&afu->dev, "WARNING: AFU was not disabled: %#016llx\n", reg);
> -		if (cxl_ops->afu_reset(afu))
> -			return -EIO;
> -		if (cxl_afu_disable(afu))
> -			return -EIO;
> -		if (cxl_psl_purge(afu))
> -			return -EIO;
> -	}
> -	cxl_p1n_write(afu, CXL_PSL_SPAP_An, 0x0000000000000000);
> -	cxl_p1n_write(afu, CXL_PSL_AMBAR_An, 0x0000000000000000);
> -	reg = cxl_p2n_read(afu, CXL_PSL_DSISR_An);
> -	if (reg) {
> -		dev_warn(&afu->dev, "AFU had pending DSISR: %#016llx\n", reg);
> -		if (reg & CXL_PSL9_DSISR_An_TF)
> -			cxl_p2n_write(afu, CXL_PSL_TFC_An, CXL_PSL_TFC_An_AE);
> -		else
> -			cxl_p2n_write(afu, CXL_PSL_TFC_An, CXL_PSL_TFC_An_A);
> -	}
> -	if (afu->adapter->native->sl_ops->register_serr_irq) {
> -		reg = cxl_p1n_read(afu, CXL_PSL_SERR_An);
> -		if (reg) {
> -			if (reg & ~0x000000007fffffff)
> -				dev_warn(&afu->dev, "AFU had pending SERR: %#016llx\n", reg);
> -			cxl_p1n_write(afu, CXL_PSL_SERR_An, reg & ~0xffff);
> -		}
> -	}
> -	reg = cxl_p2n_read(afu, CXL_PSL_ErrStat_An);
> -	if (reg) {
> -		dev_warn(&afu->dev, "AFU had pending error status: %#016llx\n", reg);
> -		cxl_p2n_write(afu, CXL_PSL_ErrStat_An, reg);
> -	}
> -
> -	return 0;
> -}
> -
> -static int sanitise_afu_regs_psl8(struct cxl_afu *afu)
> -{
> -	u64 reg;
> -
> -	/*
> -	 * Clear out any regs that contain either an IVTE or address or may be
> -	 * waiting on an acknowledgement to try to be a bit safer as we bring
> -	 * it online
> -	 */
> -	reg = cxl_p2n_read(afu, CXL_AFU_Cntl_An);
> -	if ((reg & CXL_AFU_Cntl_An_ES_MASK) != CXL_AFU_Cntl_An_ES_Disabled) {
> -		dev_warn(&afu->dev, "WARNING: AFU was not disabled: %#016llx\n", reg);
> -		if (cxl_ops->afu_reset(afu))
> -			return -EIO;
> -		if (cxl_afu_disable(afu))
> -			return -EIO;
> -		if (cxl_psl_purge(afu))
> -			return -EIO;
> -	}
> -	cxl_p1n_write(afu, CXL_PSL_SPAP_An, 0x0000000000000000);
> -	cxl_p1n_write(afu, CXL_PSL_IVTE_Limit_An, 0x0000000000000000);
> -	cxl_p1n_write(afu, CXL_PSL_IVTE_Offset_An, 0x0000000000000000);
> -	cxl_p1n_write(afu, CXL_PSL_AMBAR_An, 0x0000000000000000);
> -	cxl_p1n_write(afu, CXL_PSL_SPOffset_An, 0x0000000000000000);
> -	cxl_p1n_write(afu, CXL_HAURP_An, 0x0000000000000000);
> -	cxl_p2n_write(afu, CXL_CSRP_An, 0x0000000000000000);
> -	cxl_p2n_write(afu, CXL_AURP1_An, 0x0000000000000000);
> -	cxl_p2n_write(afu, CXL_AURP0_An, 0x0000000000000000);
> -	cxl_p2n_write(afu, CXL_SSTP1_An, 0x0000000000000000);
> -	cxl_p2n_write(afu, CXL_SSTP0_An, 0x0000000000000000);
> -	reg = cxl_p2n_read(afu, CXL_PSL_DSISR_An);
> -	if (reg) {
> -		dev_warn(&afu->dev, "AFU had pending DSISR: %#016llx\n", reg);
> -		if (reg & CXL_PSL_DSISR_TRANS)
> -			cxl_p2n_write(afu, CXL_PSL_TFC_An, CXL_PSL_TFC_An_AE);
> -		else
> -			cxl_p2n_write(afu, CXL_PSL_TFC_An, CXL_PSL_TFC_An_A);
> -	}
> -	if (afu->adapter->native->sl_ops->register_serr_irq) {
> -		reg = cxl_p1n_read(afu, CXL_PSL_SERR_An);
> -		if (reg) {
> -			if (reg & ~0xffff)
> -				dev_warn(&afu->dev, "AFU had pending SERR: %#016llx\n", reg);
> -			cxl_p1n_write(afu, CXL_PSL_SERR_An, reg & ~0xffff);
> -		}
> -	}
> -	reg = cxl_p2n_read(afu, CXL_PSL_ErrStat_An);
> -	if (reg) {
> -		dev_warn(&afu->dev, "AFU had pending error status: %#016llx\n", reg);
> -		cxl_p2n_write(afu, CXL_PSL_ErrStat_An, reg);
> -	}
> -
> -	return 0;
> -}
> -
> -#define ERR_BUFF_MAX_COPY_SIZE PAGE_SIZE
> -/*
> - * afu_eb_read:
> - * Called from sysfs and reads the afu error info buffer. The h/w only supports
> - * 4/8 bytes aligned access. So in case the requested offset/count arent 8 byte
> - * aligned the function uses a bounce buffer which can be max PAGE_SIZE.
> - */
> -ssize_t cxl_pci_afu_read_err_buffer(struct cxl_afu *afu, char *buf,
> -				loff_t off, size_t count)
> -{
> -	loff_t aligned_start, aligned_end;
> -	size_t aligned_length;
> -	void *tbuf;
> -	const void __iomem *ebuf = afu->native->afu_desc_mmio + afu->eb_offset;
> -
> -	if (count == 0 || off < 0 || (size_t)off >= afu->eb_len)
> -		return 0;
> -
> -	/* calculate aligned read window */
> -	count = min((size_t)(afu->eb_len - off), count);
> -	aligned_start = round_down(off, 8);
> -	aligned_end = round_up(off + count, 8);
> -	aligned_length = aligned_end - aligned_start;
> -
> -	/* max we can copy in one read is PAGE_SIZE */
> -	if (aligned_length > ERR_BUFF_MAX_COPY_SIZE) {
> -		aligned_length = ERR_BUFF_MAX_COPY_SIZE;
> -		count = ERR_BUFF_MAX_COPY_SIZE - (off & 0x7);
> -	}
> -
> -	/* use bounce buffer for copy */
> -	tbuf = (void *)__get_free_page(GFP_KERNEL);
> -	if (!tbuf)
> -		return -ENOMEM;
> -
> -	/* perform aligned read from the mmio region */
> -	memcpy_fromio(tbuf, ebuf + aligned_start, aligned_length);
> -	memcpy(buf, tbuf + (off & 0x7), count);
> -
> -	free_page((unsigned long)tbuf);
> -
> -	return count;
> -}
> -
> -static int pci_configure_afu(struct cxl_afu *afu, struct cxl *adapter, struct pci_dev *dev)
> -{
> -	int rc;
> -
> -	if ((rc = pci_map_slice_regs(afu, adapter, dev)))
> -		return rc;
> -
> -	if (adapter->native->sl_ops->sanitise_afu_regs) {
> -		rc = adapter->native->sl_ops->sanitise_afu_regs(afu);
> -		if (rc)
> -			goto err1;
> -	}
> -
> -	/* We need to reset the AFU before we can read the AFU descriptor */
> -	if ((rc = cxl_ops->afu_reset(afu)))
> -		goto err1;
> -
> -	if (cxl_verbose)
> -		dump_afu_descriptor(afu);
> -
> -	if ((rc = cxl_read_afu_descriptor(afu)))
> -		goto err1;
> -
> -	if ((rc = cxl_afu_descriptor_looks_ok(afu)))
> -		goto err1;
> -
> -	if (adapter->native->sl_ops->afu_regs_init)
> -		if ((rc = adapter->native->sl_ops->afu_regs_init(afu)))
> -			goto err1;
> -
> -	if (adapter->native->sl_ops->register_serr_irq)
> -		if ((rc = adapter->native->sl_ops->register_serr_irq(afu)))
> -			goto err1;
> -
> -	if ((rc = cxl_native_register_psl_irq(afu)))
> -		goto err2;
> -
> -	atomic_set(&afu->configured_state, 0);
> -	return 0;
> -
> -err2:
> -	if (adapter->native->sl_ops->release_serr_irq)
> -		adapter->native->sl_ops->release_serr_irq(afu);
> -err1:
> -	pci_unmap_slice_regs(afu);
> -	return rc;
> -}
> -
> -static void pci_deconfigure_afu(struct cxl_afu *afu)
> -{
> -	/*
> -	 * It's okay to deconfigure when AFU is already locked, otherwise wait
> -	 * until there are no readers
> -	 */
> -	if (atomic_read(&afu->configured_state) != -1) {
> -		while (atomic_cmpxchg(&afu->configured_state, 0, -1) != -1)
> -			schedule();
> -	}
> -	cxl_native_release_psl_irq(afu);
> -	if (afu->adapter->native->sl_ops->release_serr_irq)
> -		afu->adapter->native->sl_ops->release_serr_irq(afu);
> -	pci_unmap_slice_regs(afu);
> -}
> -
> -static int pci_init_afu(struct cxl *adapter, int slice, struct pci_dev *dev)
> -{
> -	struct cxl_afu *afu;
> -	int rc = -ENOMEM;
> -
> -	afu = cxl_alloc_afu(adapter, slice);
> -	if (!afu)
> -		return -ENOMEM;
> -
> -	afu->native = kzalloc(sizeof(struct cxl_afu_native), GFP_KERNEL);
> -	if (!afu->native)
> -		goto err_free_afu;
> -
> -	mutex_init(&afu->native->spa_mutex);
> -
> -	rc = dev_set_name(&afu->dev, "afu%i.%i", adapter->adapter_num, slice);
> -	if (rc)
> -		goto err_free_native;
> -
> -	rc = pci_configure_afu(afu, adapter, dev);
> -	if (rc)
> -		goto err_free_native;
> -
> -	/* Don't care if this fails */
> -	cxl_debugfs_afu_add(afu);
> -
> -	/*
> -	 * After we call this function we must not free the afu directly, even
> -	 * if it returns an error!
> -	 */
> -	if ((rc = cxl_register_afu(afu)))
> -		goto err_put_dev;
> -
> -	if ((rc = cxl_sysfs_afu_add(afu)))
> -		goto err_del_dev;
> -
> -	adapter->afu[afu->slice] = afu;
> -
> -	if ((rc = cxl_pci_vphb_add(afu)))
> -		dev_info(&afu->dev, "Can't register vPHB\n");
> -
> -	return 0;
> -
> -err_del_dev:
> -	device_del(&afu->dev);
> -err_put_dev:
> -	pci_deconfigure_afu(afu);
> -	cxl_debugfs_afu_remove(afu);
> -	put_device(&afu->dev);
> -	return rc;
> -
> -err_free_native:
> -	kfree(afu->native);
> -err_free_afu:
> -	kfree(afu);
> -	return rc;
> -
> -}
> -
> -static void cxl_pci_remove_afu(struct cxl_afu *afu)
> -{
> -	pr_devel("%s\n", __func__);
> -
> -	if (!afu)
> -		return;
> -
> -	cxl_pci_vphb_remove(afu);
> -	cxl_sysfs_afu_remove(afu);
> -	cxl_debugfs_afu_remove(afu);
> -
> -	spin_lock(&afu->adapter->afu_list_lock);
> -	afu->adapter->afu[afu->slice] = NULL;
> -	spin_unlock(&afu->adapter->afu_list_lock);
> -
> -	cxl_context_detach_all(afu);
> -	cxl_ops->afu_deactivate_mode(afu, afu->current_mode);
> -
> -	pci_deconfigure_afu(afu);
> -	device_unregister(&afu->dev);
> -}
> -
> -int cxl_pci_reset(struct cxl *adapter)
> -{
> -	struct pci_dev *dev = to_pci_dev(adapter->dev.parent);
> -	int rc;
> -
> -	if (adapter->perst_same_image) {
> -		dev_warn(&dev->dev,
> -			 "cxl: refusing to reset/reflash when perst_reloads_same_image is set.\n");
> -		return -EINVAL;
> -	}
> -
> -	dev_info(&dev->dev, "CXL reset\n");
> -
> -	/*
> -	 * The adapter is about to be reset, so ignore errors.
> -	 */
> -	cxl_data_cache_flush(adapter);
> -
> -	/* pcie_warm_reset requests a fundamental pci reset which includes a
> -	 * PERST assert/deassert.  PERST triggers a loading of the image
> -	 * if "user" or "factory" is selected in sysfs */
> -	if ((rc = pci_set_pcie_reset_state(dev, pcie_warm_reset))) {
> -		dev_err(&dev->dev, "cxl: pcie_warm_reset failed\n");
> -		return rc;
> -	}
> -
> -	return rc;
> -}
> -
> -static int cxl_map_adapter_regs(struct cxl *adapter, struct pci_dev *dev)
> -{
> -	if (pci_request_region(dev, 2, "priv 2 regs"))
> -		goto err1;
> -	if (pci_request_region(dev, 0, "priv 1 regs"))
> -		goto err2;
> -
> -	pr_devel("cxl_map_adapter_regs: p1: %#016llx %#llx, p2: %#016llx %#llx",
> -			p1_base(dev), p1_size(dev), p2_base(dev), p2_size(dev));
> -
> -	if (!(adapter->native->p1_mmio = ioremap(p1_base(dev), p1_size(dev))))
> -		goto err3;
> -
> -	if (!(adapter->native->p2_mmio = ioremap(p2_base(dev), p2_size(dev))))
> -		goto err4;
> -
> -	return 0;
> -
> -err4:
> -	iounmap(adapter->native->p1_mmio);
> -	adapter->native->p1_mmio = NULL;
> -err3:
> -	pci_release_region(dev, 0);
> -err2:
> -	pci_release_region(dev, 2);
> -err1:
> -	return -ENOMEM;
> -}
> -
> -static void cxl_unmap_adapter_regs(struct cxl *adapter)
> -{
> -	if (adapter->native->p1_mmio) {
> -		iounmap(adapter->native->p1_mmio);
> -		adapter->native->p1_mmio = NULL;
> -		pci_release_region(to_pci_dev(adapter->dev.parent), 2);
> -	}
> -	if (adapter->native->p2_mmio) {
> -		iounmap(adapter->native->p2_mmio);
> -		adapter->native->p2_mmio = NULL;
> -		pci_release_region(to_pci_dev(adapter->dev.parent), 0);
> -	}
> -}
> -
> -static int cxl_read_vsec(struct cxl *adapter, struct pci_dev *dev)
> -{
> -	int vsec;
> -	u32 afu_desc_off, afu_desc_size;
> -	u32 ps_off, ps_size;
> -	u16 vseclen;
> -	u8 image_state;
> -
> -	if (!(vsec = find_cxl_vsec(dev))) {
> -		dev_err(&dev->dev, "ABORTING: CXL VSEC not found!\n");
> -		return -ENODEV;
> -	}
> -
> -	CXL_READ_VSEC_LENGTH(dev, vsec, &vseclen);
> -	if (vseclen < CXL_VSEC_MIN_SIZE) {
> -		dev_err(&dev->dev, "ABORTING: CXL VSEC too short\n");
> -		return -EINVAL;
> -	}
> -
> -	CXL_READ_VSEC_STATUS(dev, vsec, &adapter->vsec_status);
> -	CXL_READ_VSEC_PSL_REVISION(dev, vsec, &adapter->psl_rev);
> -	CXL_READ_VSEC_CAIA_MAJOR(dev, vsec, &adapter->caia_major);
> -	CXL_READ_VSEC_CAIA_MINOR(dev, vsec, &adapter->caia_minor);
> -	CXL_READ_VSEC_BASE_IMAGE(dev, vsec, &adapter->base_image);
> -	CXL_READ_VSEC_IMAGE_STATE(dev, vsec, &image_state);
> -	adapter->user_image_loaded = !!(image_state & CXL_VSEC_USER_IMAGE_LOADED);
> -	adapter->perst_select_user = !!(image_state & CXL_VSEC_USER_IMAGE_LOADED);
> -	adapter->perst_loads_image = !!(image_state & CXL_VSEC_PERST_LOADS_IMAGE);
> -
> -	CXL_READ_VSEC_NAFUS(dev, vsec, &adapter->slices);
> -	CXL_READ_VSEC_AFU_DESC_OFF(dev, vsec, &afu_desc_off);
> -	CXL_READ_VSEC_AFU_DESC_SIZE(dev, vsec, &afu_desc_size);
> -	CXL_READ_VSEC_PS_OFF(dev, vsec, &ps_off);
> -	CXL_READ_VSEC_PS_SIZE(dev, vsec, &ps_size);
> -
> -	/* Convert everything to bytes, because there is NO WAY I'd look at the
> -	 * code a month later and forget what units these are in ;-) */
> -	adapter->native->ps_off = ps_off * 64 * 1024;
> -	adapter->ps_size = ps_size * 64 * 1024;
> -	adapter->native->afu_desc_off = afu_desc_off * 64 * 1024;
> -	adapter->native->afu_desc_size = afu_desc_size * 64 * 1024;
> -
> -	/* Total IRQs - 1 PSL ERROR - #AFU*(1 slice error + 1 DSI) */
> -	adapter->user_irqs = pnv_cxl_get_irq_count(dev) - 1 - 2*adapter->slices;
> -
> -	return 0;
> -}
> -
> -/*
> - * Workaround a PCIe Host Bridge defect on some cards, that can cause
> - * malformed Transaction Layer Packet (TLP) errors to be erroneously
> - * reported. Mask this error in the Uncorrectable Error Mask Register.
> - *
> - * The upper nibble of the PSL revision is used to distinguish between
> - * different cards. The affected ones have it set to 0.
> - */
> -static void cxl_fixup_malformed_tlp(struct cxl *adapter, struct pci_dev *dev)
> -{
> -	int aer;
> -	u32 data;
> -
> -	if (adapter->psl_rev & 0xf000)
> -		return;
> -	if (!(aer = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR)))
> -		return;
> -	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, &data);
> -	if (data & PCI_ERR_UNC_MALF_TLP)
> -		if (data & PCI_ERR_UNC_INTN)
> -			return;
> -	data |= PCI_ERR_UNC_MALF_TLP;
> -	data |= PCI_ERR_UNC_INTN;
> -	pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, data);
> -}
> -
> -static bool cxl_compatible_caia_version(struct cxl *adapter)
> -{
> -	if (cxl_is_power8() && (adapter->caia_major == 1))
> -		return true;
> -
> -	if (cxl_is_power9() && (adapter->caia_major == 2))
> -		return true;
> -
> -	return false;
> -}
> -
> -static int cxl_vsec_looks_ok(struct cxl *adapter, struct pci_dev *dev)
> -{
> -	if (adapter->vsec_status & CXL_STATUS_SECOND_PORT)
> -		return -EBUSY;
> -
> -	if (adapter->vsec_status & CXL_UNSUPPORTED_FEATURES) {
> -		dev_err(&dev->dev, "ABORTING: CXL requires unsupported features\n");
> -		return -EINVAL;
> -	}
> -
> -	if (!cxl_compatible_caia_version(adapter)) {
> -		dev_info(&dev->dev, "Ignoring card. PSL type is not supported (caia version: %d)\n",
> -			 adapter->caia_major);
> -		return -ENODEV;
> -	}
> -
> -	if (!adapter->slices) {
> -		/* Once we support dynamic reprogramming we can use the card if
> -		 * it supports loadable AFUs */
> -		dev_err(&dev->dev, "ABORTING: Device has no AFUs\n");
> -		return -EINVAL;
> -	}
> -
> -	if (!adapter->native->afu_desc_off || !adapter->native->afu_desc_size) {
> -		dev_err(&dev->dev, "ABORTING: VSEC shows no AFU descriptors\n");
> -		return -EINVAL;
> -	}
> -
> -	if (adapter->ps_size > p2_size(dev) - adapter->native->ps_off) {
> -		dev_err(&dev->dev, "ABORTING: Problem state size larger than "
> -				   "available in BAR2: 0x%llx > 0x%llx\n",
> -			 adapter->ps_size, p2_size(dev) - adapter->native->ps_off);
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
> -ssize_t cxl_pci_read_adapter_vpd(struct cxl *adapter, void *buf, size_t len)
> -{
> -	return pci_read_vpd(to_pci_dev(adapter->dev.parent), 0, len, buf);
> -}
> -
> -static void cxl_release_adapter(struct device *dev)
> -{
> -	struct cxl *adapter = to_cxl_adapter(dev);
> -
> -	pr_devel("cxl_release_adapter\n");
> -
> -	cxl_remove_adapter_nr(adapter);
> -
> -	kfree(adapter->native);
> -	kfree(adapter);
> -}
> -
> -#define CXL_PSL_ErrIVTE_tberror (0x1ull << (63-31))
> -
> -static int sanitise_adapter_regs(struct cxl *adapter)
> -{
> -	int rc = 0;
> -
> -	/* Clear PSL tberror bit by writing 1 to it */
> -	cxl_p1_write(adapter, CXL_PSL_ErrIVTE, CXL_PSL_ErrIVTE_tberror);
> -
> -	if (adapter->native->sl_ops->invalidate_all) {
> -		/* do not invalidate ERAT entries when not reloading on PERST */
> -		if (cxl_is_power9() && (adapter->perst_loads_image))
> -			return 0;
> -		rc = adapter->native->sl_ops->invalidate_all(adapter);
> -	}
> -
> -	return rc;
> -}
> -
> -/* This should contain *only* operations that can safely be done in
> - * both creation and recovery.
> - */
> -static int cxl_configure_adapter(struct cxl *adapter, struct pci_dev *dev)
> -{
> -	int rc;
> -
> -	adapter->dev.parent = &dev->dev;
> -	adapter->dev.release = cxl_release_adapter;
> -	pci_set_drvdata(dev, adapter);
> -
> -	rc = pci_enable_device(dev);
> -	if (rc) {
> -		dev_err(&dev->dev, "pci_enable_device failed: %i\n", rc);
> -		return rc;
> -	}
> -
> -	if ((rc = cxl_read_vsec(adapter, dev)))
> -		return rc;
> -
> -	if ((rc = cxl_vsec_looks_ok(adapter, dev)))
> -	        return rc;
> -
> -	cxl_fixup_malformed_tlp(adapter, dev);
> -
> -	if ((rc = setup_cxl_bars(dev)))
> -		return rc;
> -
> -	if ((rc = switch_card_to_cxl(dev)))
> -		return rc;
> -
> -	if ((rc = cxl_update_image_control(adapter)))
> -		return rc;
> -
> -	if ((rc = cxl_map_adapter_regs(adapter, dev)))
> -		return rc;
> -
> -	if ((rc = sanitise_adapter_regs(adapter)))
> -		goto err;
> -
> -	if ((rc = adapter->native->sl_ops->adapter_regs_init(adapter, dev)))
> -		goto err;
> -
> -	/* Required for devices using CAPP DMA mode, harmless for others */
> -	pci_set_master(dev);
> -
> -	adapter->tunneled_ops_supported = false;
> -
> -	if (cxl_is_power9()) {
> -		if (pnv_pci_set_tunnel_bar(dev, 0x00020000E0000000ull, 1))
> -			dev_info(&dev->dev, "Tunneled operations unsupported\n");
> -		else
> -			adapter->tunneled_ops_supported = true;
> -	}
> -
> -	if ((rc = pnv_phb_to_cxl_mode(dev, adapter->native->sl_ops->capi_mode)))
> -		goto err;
> -
> -	/* If recovery happened, the last step is to turn on snooping.
> -	 * In the non-recovery case this has no effect */
> -	if ((rc = pnv_phb_to_cxl_mode(dev, OPAL_PHB_CAPI_MODE_SNOOP_ON)))
> -		goto err;
> -
> -	/* Ignore error, adapter init is not dependant on timebase sync */
> -	cxl_setup_psl_timebase(adapter, dev);
> -
> -	if ((rc = cxl_native_register_psl_err_irq(adapter)))
> -		goto err;
> -
> -	return 0;
> -
> -err:
> -	cxl_unmap_adapter_regs(adapter);
> -	return rc;
> -
> -}
> -
> -static void cxl_deconfigure_adapter(struct cxl *adapter)
> -{
> -	struct pci_dev *pdev = to_pci_dev(adapter->dev.parent);
> -
> -	if (cxl_is_power9())
> -		pnv_pci_set_tunnel_bar(pdev, 0x00020000E0000000ull, 0);
> -
> -	cxl_native_release_psl_err_irq(adapter);
> -	cxl_unmap_adapter_regs(adapter);
> -
> -	pci_disable_device(pdev);
> -}
> -
> -static void cxl_stop_trace_psl9(struct cxl *adapter)
> -{
> -	int traceid;
> -	u64 trace_state, trace_mask;
> -	struct pci_dev *dev = to_pci_dev(adapter->dev.parent);
> -
> -	/* read each tracearray state and issue mmio to stop them is needed */
> -	for (traceid = 0; traceid <= CXL_PSL9_TRACEID_MAX; ++traceid) {
> -		trace_state = cxl_p1_read(adapter, CXL_PSL9_CTCCFG);
> -		trace_mask = (0x3ULL << (62 - traceid * 2));
> -		trace_state = (trace_state & trace_mask) >> (62 - traceid * 2);
> -		dev_dbg(&dev->dev, "cxl: Traceid-%d trace_state=0x%0llX\n",
> -			traceid, trace_state);
> -
> -		/* issue mmio if the trace array isn't in FIN state */
> -		if (trace_state != CXL_PSL9_TRACESTATE_FIN)
> -			cxl_p1_write(adapter, CXL_PSL9_TRACECFG,
> -				     0x8400000000000000ULL | traceid);
> -	}
> -}
> -
> -static void cxl_stop_trace_psl8(struct cxl *adapter)
> -{
> -	int slice;
> -
> -	/* Stop the trace */
> -	cxl_p1_write(adapter, CXL_PSL_TRACE, 0x8000000000000017LL);
> -
> -	/* Stop the slice traces */
> -	spin_lock(&adapter->afu_list_lock);
> -	for (slice = 0; slice < adapter->slices; slice++) {
> -		if (adapter->afu[slice])
> -			cxl_p1n_write(adapter->afu[slice], CXL_PSL_SLICE_TRACE,
> -				      0x8000000000000000LL);
> -	}
> -	spin_unlock(&adapter->afu_list_lock);
> -}
> -
> -static const struct cxl_service_layer_ops psl9_ops = {
> -	.adapter_regs_init = init_implementation_adapter_regs_psl9,
> -	.invalidate_all = cxl_invalidate_all_psl9,
> -	.afu_regs_init = init_implementation_afu_regs_psl9,
> -	.sanitise_afu_regs = sanitise_afu_regs_psl9,
> -	.register_serr_irq = cxl_native_register_serr_irq,
> -	.release_serr_irq = cxl_native_release_serr_irq,
> -	.handle_interrupt = cxl_irq_psl9,
> -	.fail_irq = cxl_fail_irq_psl,
> -	.activate_dedicated_process = cxl_activate_dedicated_process_psl9,
> -	.attach_afu_directed = cxl_attach_afu_directed_psl9,
> -	.attach_dedicated_process = cxl_attach_dedicated_process_psl9,
> -	.update_dedicated_ivtes = cxl_update_dedicated_ivtes_psl9,
> -	.debugfs_add_adapter_regs = cxl_debugfs_add_adapter_regs_psl9,
> -	.debugfs_add_afu_regs = cxl_debugfs_add_afu_regs_psl9,
> -	.psl_irq_dump_registers = cxl_native_irq_dump_regs_psl9,
> -	.err_irq_dump_registers = cxl_native_err_irq_dump_regs_psl9,
> -	.debugfs_stop_trace = cxl_stop_trace_psl9,
> -	.timebase_read = timebase_read_psl9,
> -	.capi_mode = OPAL_PHB_CAPI_MODE_CAPI,
> -	.needs_reset_before_disable = true,
> -};
> -
> -static const struct cxl_service_layer_ops psl8_ops = {
> -	.adapter_regs_init = init_implementation_adapter_regs_psl8,
> -	.invalidate_all = cxl_invalidate_all_psl8,
> -	.afu_regs_init = init_implementation_afu_regs_psl8,
> -	.sanitise_afu_regs = sanitise_afu_regs_psl8,
> -	.register_serr_irq = cxl_native_register_serr_irq,
> -	.release_serr_irq = cxl_native_release_serr_irq,
> -	.handle_interrupt = cxl_irq_psl8,
> -	.fail_irq = cxl_fail_irq_psl,
> -	.activate_dedicated_process = cxl_activate_dedicated_process_psl8,
> -	.attach_afu_directed = cxl_attach_afu_directed_psl8,
> -	.attach_dedicated_process = cxl_attach_dedicated_process_psl8,
> -	.update_dedicated_ivtes = cxl_update_dedicated_ivtes_psl8,
> -	.debugfs_add_adapter_regs = cxl_debugfs_add_adapter_regs_psl8,
> -	.debugfs_add_afu_regs = cxl_debugfs_add_afu_regs_psl8,
> -	.psl_irq_dump_registers = cxl_native_irq_dump_regs_psl8,
> -	.err_irq_dump_registers = cxl_native_err_irq_dump_regs_psl8,
> -	.debugfs_stop_trace = cxl_stop_trace_psl8,
> -	.write_timebase_ctrl = write_timebase_ctrl_psl8,
> -	.timebase_read = timebase_read_psl8,
> -	.capi_mode = OPAL_PHB_CAPI_MODE_CAPI,
> -	.needs_reset_before_disable = true,
> -};
> -
> -static void set_sl_ops(struct cxl *adapter, struct pci_dev *dev)
> -{
> -	if (cxl_is_power8()) {
> -		dev_info(&dev->dev, "Device uses a PSL8\n");
> -		adapter->native->sl_ops = &psl8_ops;
> -	} else {
> -		dev_info(&dev->dev, "Device uses a PSL9\n");
> -		adapter->native->sl_ops = &psl9_ops;
> -	}
> -}
> -
> -
> -static struct cxl *cxl_pci_init_adapter(struct pci_dev *dev)
> -{
> -	struct cxl *adapter;
> -	int rc;
> -
> -	adapter = cxl_alloc_adapter();
> -	if (!adapter)
> -		return ERR_PTR(-ENOMEM);
> -
> -	adapter->native = kzalloc(sizeof(struct cxl_native), GFP_KERNEL);
> -	if (!adapter->native) {
> -		rc = -ENOMEM;
> -		goto err_release;
> -	}
> -
> -	set_sl_ops(adapter, dev);
> -
> -	/* Set defaults for parameters which need to persist over
> -	 * configure/reconfigure
> -	 */
> -	adapter->perst_loads_image = true;
> -	adapter->perst_same_image = false;
> -
> -	rc = cxl_configure_adapter(adapter, dev);
> -	if (rc) {
> -		pci_disable_device(dev);
> -		goto err_release;
> -	}
> -
> -	/* Don't care if this one fails: */
> -	cxl_debugfs_adapter_add(adapter);
> -
> -	/*
> -	 * After we call this function we must not free the adapter directly,
> -	 * even if it returns an error!
> -	 */
> -	if ((rc = cxl_register_adapter(adapter)))
> -		goto err_put_dev;
> -
> -	if ((rc = cxl_sysfs_adapter_add(adapter)))
> -		goto err_del_dev;
> -
> -	/* Release the context lock as adapter is configured */
> -	cxl_adapter_context_unlock(adapter);
> -
> -	return adapter;
> -
> -err_del_dev:
> -	device_del(&adapter->dev);
> -err_put_dev:
> -	/* This should mirror cxl_remove_adapter, except without the
> -	 * sysfs parts
> -	 */
> -	cxl_debugfs_adapter_remove(adapter);
> -	cxl_deconfigure_adapter(adapter);
> -	put_device(&adapter->dev);
> -	return ERR_PTR(rc);
> -
> -err_release:
> -	cxl_release_adapter(&adapter->dev);
> -	return ERR_PTR(rc);
> -}
> -
> -static void cxl_pci_remove_adapter(struct cxl *adapter)
> -{
> -	pr_devel("cxl_remove_adapter\n");
> -
> -	cxl_sysfs_adapter_remove(adapter);
> -	cxl_debugfs_adapter_remove(adapter);
> -
> -	/*
> -	 * Flush adapter datacache as its about to be removed.
> -	 */
> -	cxl_data_cache_flush(adapter);
> -
> -	cxl_deconfigure_adapter(adapter);
> -
> -	device_unregister(&adapter->dev);
> -}
> -
> -#define CXL_MAX_PCIEX_PARENT 2
> -
> -int cxl_slot_is_switched(struct pci_dev *dev)
> -{
> -	struct device_node *np;
> -	int depth = 0;
> -
> -	if (!(np = pci_device_to_OF_node(dev))) {
> -		pr_err("cxl: np = NULL\n");
> -		return -ENODEV;
> -	}
> -	of_node_get(np);
> -	while (np) {
> -		np = of_get_next_parent(np);
> -		if (!of_node_is_type(np, "pciex"))
> -			break;
> -		depth++;
> -	}
> -	of_node_put(np);
> -	return (depth > CXL_MAX_PCIEX_PARENT);
> -}
> -
> -static int cxl_probe(struct pci_dev *dev, const struct pci_device_id *id)
> -{
> -	struct cxl *adapter;
> -	int slice;
> -	int rc;
> -
> -	dev_err_once(&dev->dev, "DEPRECATED: cxl is deprecated and will be removed in a future kernel release\n");
> -
> -	if (cxl_pci_is_vphb_device(dev)) {
> -		dev_dbg(&dev->dev, "cxl_init_adapter: Ignoring cxl vphb device\n");
> -		return -ENODEV;
> -	}
> -
> -	if (cxl_slot_is_switched(dev)) {
> -		dev_info(&dev->dev, "Ignoring card on incompatible PCI slot\n");
> -		return -ENODEV;
> -	}
> -
> -	if (cxl_is_power9() && !radix_enabled()) {
> -		dev_info(&dev->dev, "Only Radix mode supported\n");
> -		return -ENODEV;
> -	}
> -
> -	if (cxl_verbose)
> -		dump_cxl_config_space(dev);
> -
> -	adapter = cxl_pci_init_adapter(dev);
> -	if (IS_ERR(adapter)) {
> -		dev_err(&dev->dev, "cxl_init_adapter failed: %li\n", PTR_ERR(adapter));
> -		return PTR_ERR(adapter);
> -	}
> -
> -	for (slice = 0; slice < adapter->slices; slice++) {
> -		if ((rc = pci_init_afu(adapter, slice, dev))) {
> -			dev_err(&dev->dev, "AFU %i failed to initialise: %i\n", slice, rc);
> -			continue;
> -		}
> -
> -		rc = cxl_afu_select_best_mode(adapter->afu[slice]);
> -		if (rc)
> -			dev_err(&dev->dev, "AFU %i failed to start: %i\n", slice, rc);
> -	}
> -
> -	return 0;
> -}
> -
> -static void cxl_remove(struct pci_dev *dev)
> -{
> -	struct cxl *adapter = pci_get_drvdata(dev);
> -	struct cxl_afu *afu;
> -	int i;
> -
> -	/*
> -	 * Lock to prevent someone grabbing a ref through the adapter list as
> -	 * we are removing it
> -	 */
> -	for (i = 0; i < adapter->slices; i++) {
> -		afu = adapter->afu[i];
> -		cxl_pci_remove_afu(afu);
> -	}
> -	cxl_pci_remove_adapter(adapter);
> -}
> -
> -static pci_ers_result_t cxl_vphb_error_detected(struct cxl_afu *afu,
> -						pci_channel_state_t state)
> -{
> -	struct pci_dev *afu_dev;
> -	struct pci_driver *afu_drv;
> -	const struct pci_error_handlers *err_handler;
> -	pci_ers_result_t result = PCI_ERS_RESULT_NEED_RESET;
> -	pci_ers_result_t afu_result = PCI_ERS_RESULT_NEED_RESET;
> -
> -	/* There should only be one entry, but go through the list
> -	 * anyway
> -	 */
> -	if (afu == NULL || afu->phb == NULL)
> -		return result;
> -
> -	list_for_each_entry(afu_dev, &afu->phb->bus->devices, bus_list) {
> -		afu_drv = to_pci_driver(afu_dev->dev.driver);
> -		if (!afu_drv)
> -			continue;
> -
> -		afu_dev->error_state = state;
> -
> -		err_handler = afu_drv->err_handler;
> -		if (err_handler)
> -			afu_result = err_handler->error_detected(afu_dev,
> -								 state);
> -		/* Disconnect trumps all, NONE trumps NEED_RESET */
> -		if (afu_result == PCI_ERS_RESULT_DISCONNECT)
> -			result = PCI_ERS_RESULT_DISCONNECT;
> -		else if ((afu_result == PCI_ERS_RESULT_NONE) &&
> -			 (result == PCI_ERS_RESULT_NEED_RESET))
> -			result = PCI_ERS_RESULT_NONE;
> -	}
> -	return result;
> -}
> -
> -static pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
> -					       pci_channel_state_t state)
> -{
> -	struct cxl *adapter = pci_get_drvdata(pdev);
> -	struct cxl_afu *afu;
> -	pci_ers_result_t result = PCI_ERS_RESULT_NEED_RESET;
> -	pci_ers_result_t afu_result = PCI_ERS_RESULT_NEED_RESET;
> -	int i;
> -
> -	/* At this point, we could still have an interrupt pending.
> -	 * Let's try to get them out of the way before they do
> -	 * anything we don't like.
> -	 */
> -	schedule();
> -
> -	/* If we're permanently dead, give up. */
> -	if (state == pci_channel_io_perm_failure) {
> -		spin_lock(&adapter->afu_list_lock);
> -		for (i = 0; i < adapter->slices; i++) {
> -			afu = adapter->afu[i];
> -			/*
> -			 * Tell the AFU drivers; but we don't care what they
> -			 * say, we're going away.
> -			 */
> -			cxl_vphb_error_detected(afu, state);
> -		}
> -		spin_unlock(&adapter->afu_list_lock);
> -		return PCI_ERS_RESULT_DISCONNECT;
> -	}
> -
> -	/* Are we reflashing?
> -	 *
> -	 * If we reflash, we could come back as something entirely
> -	 * different, including a non-CAPI card. As such, by default
> -	 * we don't participate in the process. We'll be unbound and
> -	 * the slot re-probed. (TODO: check EEH doesn't blindly rebind
> -	 * us!)
> -	 *
> -	 * However, this isn't the entire story: for reliablity
> -	 * reasons, we usually want to reflash the FPGA on PERST in
> -	 * order to get back to a more reliable known-good state.
> -	 *
> -	 * This causes us a bit of a problem: if we reflash we can't
> -	 * trust that we'll come back the same - we could have a new
> -	 * image and been PERSTed in order to load that
> -	 * image. However, most of the time we actually *will* come
> -	 * back the same - for example a regular EEH event.
> -	 *
> -	 * Therefore, we allow the user to assert that the image is
> -	 * indeed the same and that we should continue on into EEH
> -	 * anyway.
> -	 */
> -	if (adapter->perst_loads_image && !adapter->perst_same_image) {
> -		/* TODO take the PHB out of CXL mode */
> -		dev_info(&pdev->dev, "reflashing, so opting out of EEH!\n");
> -		return PCI_ERS_RESULT_NONE;
> -	}
> -
> -	/*
> -	 * At this point, we want to try to recover.  We'll always
> -	 * need a complete slot reset: we don't trust any other reset.
> -	 *
> -	 * Now, we go through each AFU:
> -	 *  - We send the driver, if bound, an error_detected callback.
> -	 *    We expect it to clean up, but it can also tell us to give
> -	 *    up and permanently detach the card. To simplify things, if
> -	 *    any bound AFU driver doesn't support EEH, we give up on EEH.
> -	 *
> -	 *  - We detach all contexts associated with the AFU. This
> -	 *    does not free them, but puts them into a CLOSED state
> -	 *    which causes any the associated files to return useful
> -	 *    errors to userland. It also unmaps, but does not free,
> -	 *    any IRQs.
> -	 *
> -	 *  - We clean up our side: releasing and unmapping resources we hold
> -	 *    so we can wire them up again when the hardware comes back up.
> -	 *
> -	 * Driver authors should note:
> -	 *
> -	 *  - Any contexts you create in your kernel driver (except
> -	 *    those associated with anonymous file descriptors) are
> -	 *    your responsibility to free and recreate. Likewise with
> -	 *    any attached resources.
> -	 *
> -	 *  - We will take responsibility for re-initialising the
> -	 *    device context (the one set up for you in
> -	 *    cxl_pci_enable_device_hook and accessed through
> -	 *    cxl_get_context). If you've attached IRQs or other
> -	 *    resources to it, they remains yours to free.
> -	 *
> -	 * You can call the same functions to release resources as you
> -	 * normally would: we make sure that these functions continue
> -	 * to work when the hardware is down.
> -	 *
> -	 * Two examples:
> -	 *
> -	 * 1) If you normally free all your resources at the end of
> -	 *    each request, or if you use anonymous FDs, your
> -	 *    error_detected callback can simply set a flag to tell
> -	 *    your driver not to start any new calls. You can then
> -	 *    clear the flag in the resume callback.
> -	 *
> -	 * 2) If you normally allocate your resources on startup:
> -	 *     * Set a flag in error_detected as above.
> -	 *     * Let CXL detach your contexts.
> -	 *     * In slot_reset, free the old resources and allocate new ones.
> -	 *     * In resume, clear the flag to allow things to start.
> -	 */
> -
> -	/* Make sure no one else changes the afu list */
> -	spin_lock(&adapter->afu_list_lock);
> -
> -	for (i = 0; i < adapter->slices; i++) {
> -		afu = adapter->afu[i];
> -
> -		if (afu == NULL)
> -			continue;
> -
> -		afu_result = cxl_vphb_error_detected(afu, state);
> -		cxl_context_detach_all(afu);
> -		cxl_ops->afu_deactivate_mode(afu, afu->current_mode);
> -		pci_deconfigure_afu(afu);
> -
> -		/* Disconnect trumps all, NONE trumps NEED_RESET */
> -		if (afu_result == PCI_ERS_RESULT_DISCONNECT)
> -			result = PCI_ERS_RESULT_DISCONNECT;
> -		else if ((afu_result == PCI_ERS_RESULT_NONE) &&
> -			 (result == PCI_ERS_RESULT_NEED_RESET))
> -			result = PCI_ERS_RESULT_NONE;
> -	}
> -	spin_unlock(&adapter->afu_list_lock);
> -
> -	/* should take the context lock here */
> -	if (cxl_adapter_context_lock(adapter) != 0)
> -		dev_warn(&adapter->dev,
> -			 "Couldn't take context lock with %d active-contexts\n",
> -			 atomic_read(&adapter->contexts_num));
> -
> -	cxl_deconfigure_adapter(adapter);
> -
> -	return result;
> -}
> -
> -static pci_ers_result_t cxl_pci_slot_reset(struct pci_dev *pdev)
> -{
> -	struct cxl *adapter = pci_get_drvdata(pdev);
> -	struct cxl_afu *afu;
> -	struct cxl_context *ctx;
> -	struct pci_dev *afu_dev;
> -	struct pci_driver *afu_drv;
> -	const struct pci_error_handlers *err_handler;
> -	pci_ers_result_t afu_result = PCI_ERS_RESULT_RECOVERED;
> -	pci_ers_result_t result = PCI_ERS_RESULT_RECOVERED;
> -	int i;
> -
> -	if (cxl_configure_adapter(adapter, pdev))
> -		goto err;
> -
> -	/*
> -	 * Unlock context activation for the adapter. Ideally this should be
> -	 * done in cxl_pci_resume but cxlflash module tries to activate the
> -	 * master context as part of slot_reset callback.
> -	 */
> -	cxl_adapter_context_unlock(adapter);
> -
> -	spin_lock(&adapter->afu_list_lock);
> -	for (i = 0; i < adapter->slices; i++) {
> -		afu = adapter->afu[i];
> -
> -		if (afu == NULL)
> -			continue;
> -
> -		if (pci_configure_afu(afu, adapter, pdev))
> -			goto err_unlock;
> -
> -		if (cxl_afu_select_best_mode(afu))
> -			goto err_unlock;
> -
> -		if (afu->phb == NULL)
> -			continue;
> -
> -		list_for_each_entry(afu_dev, &afu->phb->bus->devices, bus_list) {
> -			/* Reset the device context.
> -			 * TODO: make this less disruptive
> -			 */
> -			ctx = cxl_get_context(afu_dev);
> -
> -			if (ctx && cxl_release_context(ctx))
> -				goto err_unlock;
> -
> -			ctx = cxl_dev_context_init(afu_dev);
> -			if (IS_ERR(ctx))
> -				goto err_unlock;
> -
> -			afu_dev->dev.archdata.cxl_ctx = ctx;
> -
> -			if (cxl_ops->afu_check_and_enable(afu))
> -				goto err_unlock;
> -
> -			afu_dev->error_state = pci_channel_io_normal;
> -
> -			/* If there's a driver attached, allow it to
> -			 * chime in on recovery. Drivers should check
> -			 * if everything has come back OK, but
> -			 * shouldn't start new work until we call
> -			 * their resume function.
> -			 */
> -			afu_drv = to_pci_driver(afu_dev->dev.driver);
> -			if (!afu_drv)
> -				continue;
> -
> -			err_handler = afu_drv->err_handler;
> -			if (err_handler && err_handler->slot_reset)
> -				afu_result = err_handler->slot_reset(afu_dev);
> -
> -			if (afu_result == PCI_ERS_RESULT_DISCONNECT)
> -				result = PCI_ERS_RESULT_DISCONNECT;
> -		}
> -	}
> -
> -	spin_unlock(&adapter->afu_list_lock);
> -	return result;
> -
> -err_unlock:
> -	spin_unlock(&adapter->afu_list_lock);
> -
> -err:
> -	/* All the bits that happen in both error_detected and cxl_remove
> -	 * should be idempotent, so we don't need to worry about leaving a mix
> -	 * of unconfigured and reconfigured resources.
> -	 */
> -	dev_err(&pdev->dev, "EEH recovery failed. Asking to be disconnected.\n");
> -	return PCI_ERS_RESULT_DISCONNECT;
> -}
> -
> -static void cxl_pci_resume(struct pci_dev *pdev)
> -{
> -	struct cxl *adapter = pci_get_drvdata(pdev);
> -	struct cxl_afu *afu;
> -	struct pci_dev *afu_dev;
> -	struct pci_driver *afu_drv;
> -	const struct pci_error_handlers *err_handler;
> -	int i;
> -
> -	/* Everything is back now. Drivers should restart work now.
> -	 * This is not the place to be checking if everything came back up
> -	 * properly, because there's no return value: do that in slot_reset.
> -	 */
> -	spin_lock(&adapter->afu_list_lock);
> -	for (i = 0; i < adapter->slices; i++) {
> -		afu = adapter->afu[i];
> -
> -		if (afu == NULL || afu->phb == NULL)
> -			continue;
> -
> -		list_for_each_entry(afu_dev, &afu->phb->bus->devices, bus_list) {
> -			afu_drv = to_pci_driver(afu_dev->dev.driver);
> -			if (!afu_drv)
> -				continue;
> -
> -			err_handler = afu_drv->err_handler;
> -			if (err_handler && err_handler->resume)
> -				err_handler->resume(afu_dev);
> -		}
> -	}
> -	spin_unlock(&adapter->afu_list_lock);
> -}
> -
> -static const struct pci_error_handlers cxl_err_handler = {
> -	.error_detected = cxl_pci_error_detected,
> -	.slot_reset = cxl_pci_slot_reset,
> -	.resume = cxl_pci_resume,
> -};
> -
> -struct pci_driver cxl_pci_driver = {
> -	.name = "cxl-pci",
> -	.id_table = cxl_pci_tbl,
> -	.probe = cxl_probe,
> -	.remove = cxl_remove,
> -	.shutdown = cxl_remove,
> -	.err_handler = &cxl_err_handler,
> -};
> diff --git a/drivers/misc/cxl/sysfs.c b/drivers/misc/cxl/sysfs.c
> deleted file mode 100644
> index b1fc6446bd4b..000000000000
> --- a/drivers/misc/cxl/sysfs.c
> +++ /dev/null
> @@ -1,771 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * Copyright 2014 IBM Corp.
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/device.h>
> -#include <linux/sysfs.h>
> -#include <linux/pci_regs.h>
> -
> -#include "cxl.h"
> -
> -#define to_afu_chardev_m(d) dev_get_drvdata(d)
> -
> -/*********  Adapter attributes  **********************************************/
> -
> -static ssize_t caia_version_show(struct device *device,
> -				 struct device_attribute *attr,
> -				 char *buf)
> -{
> -	struct cxl *adapter = to_cxl_adapter(device);
> -
> -	return scnprintf(buf, PAGE_SIZE, "%i.%i\n", adapter->caia_major,
> -			 adapter->caia_minor);
> -}
> -
> -static ssize_t psl_revision_show(struct device *device,
> -				 struct device_attribute *attr,
> -				 char *buf)
> -{
> -	struct cxl *adapter = to_cxl_adapter(device);
> -
> -	return scnprintf(buf, PAGE_SIZE, "%i\n", adapter->psl_rev);
> -}
> -
> -static ssize_t base_image_show(struct device *device,
> -			       struct device_attribute *attr,
> -			       char *buf)
> -{
> -	struct cxl *adapter = to_cxl_adapter(device);
> -
> -	return scnprintf(buf, PAGE_SIZE, "%i\n", adapter->base_image);
> -}
> -
> -static ssize_t image_loaded_show(struct device *device,
> -				 struct device_attribute *attr,
> -				 char *buf)
> -{
> -	struct cxl *adapter = to_cxl_adapter(device);
> -
> -	if (adapter->user_image_loaded)
> -		return scnprintf(buf, PAGE_SIZE, "user\n");
> -	return scnprintf(buf, PAGE_SIZE, "factory\n");
> -}
> -
> -static ssize_t psl_timebase_synced_show(struct device *device,
> -					struct device_attribute *attr,
> -					char *buf)
> -{
> -	struct cxl *adapter = to_cxl_adapter(device);
> -	u64 psl_tb, delta;
> -
> -	/* Recompute the status only in native mode */
> -	if (cpu_has_feature(CPU_FTR_HVMODE)) {
> -		psl_tb = adapter->native->sl_ops->timebase_read(adapter);
> -		delta = abs(mftb() - psl_tb);
> -
> -		/* CORE TB and PSL TB difference <= 16usecs ? */
> -		adapter->psl_timebase_synced = (tb_to_ns(delta) < 16000) ? true : false;
> -		pr_devel("PSL timebase %s - delta: 0x%016llx\n",
> -			 (tb_to_ns(delta) < 16000) ? "synchronized" :
> -			 "not synchronized", tb_to_ns(delta));
> -	}
> -	return scnprintf(buf, PAGE_SIZE, "%i\n", adapter->psl_timebase_synced);
> -}
> -
> -static ssize_t tunneled_ops_supported_show(struct device *device,
> -					struct device_attribute *attr,
> -					char *buf)
> -{
> -	struct cxl *adapter = to_cxl_adapter(device);
> -
> -	return scnprintf(buf, PAGE_SIZE, "%i\n", adapter->tunneled_ops_supported);
> -}
> -
> -static ssize_t reset_adapter_store(struct device *device,
> -				   struct device_attribute *attr,
> -				   const char *buf, size_t count)
> -{
> -	struct cxl *adapter = to_cxl_adapter(device);
> -	int rc;
> -	int val;
> -
> -	rc = sscanf(buf, "%i", &val);
> -	if ((rc != 1) || (val != 1 && val != -1))
> -		return -EINVAL;
> -
> -	/*
> -	 * See if we can lock the context mapping that's only allowed
> -	 * when there are no contexts attached to the adapter. Once
> -	 * taken this will also prevent any context from getting activated.
> -	 */
> -	if (val == 1) {
> -		rc =  cxl_adapter_context_lock(adapter);
> -		if (rc)
> -			goto out;
> -
> -		rc = cxl_ops->adapter_reset(adapter);
> -		/* In case reset failed release context lock */
> -		if (rc)
> -			cxl_adapter_context_unlock(adapter);
> -
> -	} else if (val == -1) {
> -		/* Perform a forced adapter reset */
> -		rc = cxl_ops->adapter_reset(adapter);
> -	}
> -
> -out:
> -	return rc ? rc : count;
> -}
> -
> -static ssize_t load_image_on_perst_show(struct device *device,
> -				 struct device_attribute *attr,
> -				 char *buf)
> -{
> -	struct cxl *adapter = to_cxl_adapter(device);
> -
> -	if (!adapter->perst_loads_image)
> -		return scnprintf(buf, PAGE_SIZE, "none\n");
> -
> -	if (adapter->perst_select_user)
> -		return scnprintf(buf, PAGE_SIZE, "user\n");
> -	return scnprintf(buf, PAGE_SIZE, "factory\n");
> -}
> -
> -static ssize_t load_image_on_perst_store(struct device *device,
> -				 struct device_attribute *attr,
> -				 const char *buf, size_t count)
> -{
> -	struct cxl *adapter = to_cxl_adapter(device);
> -	int rc;
> -
> -	if (!strncmp(buf, "none", 4))
> -		adapter->perst_loads_image = false;
> -	else if (!strncmp(buf, "user", 4)) {
> -		adapter->perst_select_user = true;
> -		adapter->perst_loads_image = true;
> -	} else if (!strncmp(buf, "factory", 7)) {
> -		adapter->perst_select_user = false;
> -		adapter->perst_loads_image = true;
> -	} else
> -		return -EINVAL;
> -
> -	if ((rc = cxl_update_image_control(adapter)))
> -		return rc;
> -
> -	return count;
> -}
> -
> -static ssize_t perst_reloads_same_image_show(struct device *device,
> -				 struct device_attribute *attr,
> -				 char *buf)
> -{
> -	struct cxl *adapter = to_cxl_adapter(device);
> -
> -	return scnprintf(buf, PAGE_SIZE, "%i\n", adapter->perst_same_image);
> -}
> -
> -static ssize_t perst_reloads_same_image_store(struct device *device,
> -				 struct device_attribute *attr,
> -				 const char *buf, size_t count)
> -{
> -	struct cxl *adapter = to_cxl_adapter(device);
> -	int rc;
> -	int val;
> -
> -	rc = sscanf(buf, "%i", &val);
> -	if ((rc != 1) || !(val == 1 || val == 0))
> -		return -EINVAL;
> -
> -	adapter->perst_same_image = (val == 1);
> -	return count;
> -}
> -
> -static struct device_attribute adapter_attrs[] = {
> -	__ATTR_RO(caia_version),
> -	__ATTR_RO(psl_revision),
> -	__ATTR_RO(base_image),
> -	__ATTR_RO(image_loaded),
> -	__ATTR_RO(psl_timebase_synced),
> -	__ATTR_RO(tunneled_ops_supported),
> -	__ATTR_RW(load_image_on_perst),
> -	__ATTR_RW(perst_reloads_same_image),
> -	__ATTR(reset, S_IWUSR, NULL, reset_adapter_store),
> -};
> -
> -
> -/*********  AFU master specific attributes  **********************************/
> -
> -static ssize_t mmio_size_show_master(struct device *device,
> -				     struct device_attribute *attr,
> -				     char *buf)
> -{
> -	struct cxl_afu *afu = to_afu_chardev_m(device);
> -
> -	return scnprintf(buf, PAGE_SIZE, "%llu\n", afu->adapter->ps_size);
> -}
> -
> -static ssize_t pp_mmio_off_show(struct device *device,
> -				struct device_attribute *attr,
> -				char *buf)
> -{
> -	struct cxl_afu *afu = to_afu_chardev_m(device);
> -
> -	return scnprintf(buf, PAGE_SIZE, "%llu\n", afu->native->pp_offset);
> -}
> -
> -static ssize_t pp_mmio_len_show(struct device *device,
> -				struct device_attribute *attr,
> -				char *buf)
> -{
> -	struct cxl_afu *afu = to_afu_chardev_m(device);
> -
> -	return scnprintf(buf, PAGE_SIZE, "%llu\n", afu->pp_size);
> -}
> -
> -static struct device_attribute afu_master_attrs[] = {
> -	__ATTR(mmio_size, S_IRUGO, mmio_size_show_master, NULL),
> -	__ATTR_RO(pp_mmio_off),
> -	__ATTR_RO(pp_mmio_len),
> -};
> -
> -
> -/*********  AFU attributes  **************************************************/
> -
> -static ssize_t mmio_size_show(struct device *device,
> -			      struct device_attribute *attr,
> -			      char *buf)
> -{
> -	struct cxl_afu *afu = to_cxl_afu(device);
> -
> -	if (afu->pp_size)
> -		return scnprintf(buf, PAGE_SIZE, "%llu\n", afu->pp_size);
> -	return scnprintf(buf, PAGE_SIZE, "%llu\n", afu->adapter->ps_size);
> -}
> -
> -static ssize_t reset_store_afu(struct device *device,
> -			       struct device_attribute *attr,
> -			       const char *buf, size_t count)
> -{
> -	struct cxl_afu *afu = to_cxl_afu(device);
> -	int rc;
> -
> -	/* Not safe to reset if it is currently in use */
> -	mutex_lock(&afu->contexts_lock);
> -	if (!idr_is_empty(&afu->contexts_idr)) {
> -		rc = -EBUSY;
> -		goto err;
> -	}
> -
> -	if ((rc = cxl_ops->afu_reset(afu)))
> -		goto err;
> -
> -	rc = count;
> -err:
> -	mutex_unlock(&afu->contexts_lock);
> -	return rc;
> -}
> -
> -static ssize_t irqs_min_show(struct device *device,
> -			     struct device_attribute *attr,
> -			     char *buf)
> -{
> -	struct cxl_afu *afu = to_cxl_afu(device);
> -
> -	return scnprintf(buf, PAGE_SIZE, "%i\n", afu->pp_irqs);
> -}
> -
> -static ssize_t irqs_max_show(struct device *device,
> -				  struct device_attribute *attr,
> -				  char *buf)
> -{
> -	struct cxl_afu *afu = to_cxl_afu(device);
> -
> -	return scnprintf(buf, PAGE_SIZE, "%i\n", afu->irqs_max);
> -}
> -
> -static ssize_t irqs_max_store(struct device *device,
> -				  struct device_attribute *attr,
> -				  const char *buf, size_t count)
> -{
> -	struct cxl_afu *afu = to_cxl_afu(device);
> -	ssize_t ret;
> -	int irqs_max;
> -
> -	ret = sscanf(buf, "%i", &irqs_max);
> -	if (ret != 1)
> -		return -EINVAL;
> -
> -	if (irqs_max < afu->pp_irqs)
> -		return -EINVAL;
> -
> -	if (cpu_has_feature(CPU_FTR_HVMODE)) {
> -		if (irqs_max > afu->adapter->user_irqs)
> -			return -EINVAL;
> -	} else {
> -		/* pHyp sets a per-AFU limit */
> -		if (irqs_max > afu->guest->max_ints)
> -			return -EINVAL;
> -	}
> -
> -	afu->irqs_max = irqs_max;
> -	return count;
> -}
> -
> -static ssize_t modes_supported_show(struct device *device,
> -				    struct device_attribute *attr, char *buf)
> -{
> -	struct cxl_afu *afu = to_cxl_afu(device);
> -	char *p = buf, *end = buf + PAGE_SIZE;
> -
> -	if (afu->modes_supported & CXL_MODE_DEDICATED)
> -		p += scnprintf(p, end - p, "dedicated_process\n");
> -	if (afu->modes_supported & CXL_MODE_DIRECTED)
> -		p += scnprintf(p, end - p, "afu_directed\n");
> -	return (p - buf);
> -}
> -
> -static ssize_t prefault_mode_show(struct device *device,
> -				  struct device_attribute *attr,
> -				  char *buf)
> -{
> -	struct cxl_afu *afu = to_cxl_afu(device);
> -
> -	switch (afu->prefault_mode) {
> -	case CXL_PREFAULT_WED:
> -		return scnprintf(buf, PAGE_SIZE, "work_element_descriptor\n");
> -	case CXL_PREFAULT_ALL:
> -		return scnprintf(buf, PAGE_SIZE, "all\n");
> -	default:
> -		return scnprintf(buf, PAGE_SIZE, "none\n");
> -	}
> -}
> -
> -static ssize_t prefault_mode_store(struct device *device,
> -			  struct device_attribute *attr,
> -			  const char *buf, size_t count)
> -{
> -	struct cxl_afu *afu = to_cxl_afu(device);
> -	enum prefault_modes mode = -1;
> -
> -	if (!strncmp(buf, "none", 4))
> -		mode = CXL_PREFAULT_NONE;
> -	else {
> -		if (!radix_enabled()) {
> -
> -			/* only allowed when not in radix mode */
> -			if (!strncmp(buf, "work_element_descriptor", 23))
> -				mode = CXL_PREFAULT_WED;
> -			if (!strncmp(buf, "all", 3))
> -				mode = CXL_PREFAULT_ALL;
> -		} else {
> -			dev_err(device, "Cannot prefault with radix enabled\n");
> -		}
> -	}
> -
> -	if (mode == -1)
> -		return -EINVAL;
> -
> -	afu->prefault_mode = mode;
> -	return count;
> -}
> -
> -static ssize_t mode_show(struct device *device,
> -			 struct device_attribute *attr,
> -			 char *buf)
> -{
> -	struct cxl_afu *afu = to_cxl_afu(device);
> -
> -	if (afu->current_mode == CXL_MODE_DEDICATED)
> -		return scnprintf(buf, PAGE_SIZE, "dedicated_process\n");
> -	if (afu->current_mode == CXL_MODE_DIRECTED)
> -		return scnprintf(buf, PAGE_SIZE, "afu_directed\n");
> -	return scnprintf(buf, PAGE_SIZE, "none\n");
> -}
> -
> -static ssize_t mode_store(struct device *device, struct device_attribute *attr,
> -			  const char *buf, size_t count)
> -{
> -	struct cxl_afu *afu = to_cxl_afu(device);
> -	int old_mode, mode = -1;
> -	int rc = -EBUSY;
> -
> -	/* can't change this if we have a user */
> -	mutex_lock(&afu->contexts_lock);
> -	if (!idr_is_empty(&afu->contexts_idr))
> -		goto err;
> -
> -	if (!strncmp(buf, "dedicated_process", 17))
> -		mode = CXL_MODE_DEDICATED;
> -	if (!strncmp(buf, "afu_directed", 12))
> -		mode = CXL_MODE_DIRECTED;
> -	if (!strncmp(buf, "none", 4))
> -		mode = 0;
> -
> -	if (mode == -1) {
> -		rc = -EINVAL;
> -		goto err;
> -	}
> -
> -	/*
> -	 * afu_deactivate_mode needs to be done outside the lock, prevent
> -	 * other contexts coming in before we are ready:
> -	 */
> -	old_mode = afu->current_mode;
> -	afu->current_mode = 0;
> -	afu->num_procs = 0;
> -
> -	mutex_unlock(&afu->contexts_lock);
> -
> -	if ((rc = cxl_ops->afu_deactivate_mode(afu, old_mode)))
> -		return rc;
> -	if ((rc = cxl_ops->afu_activate_mode(afu, mode)))
> -		return rc;
> -
> -	return count;
> -err:
> -	mutex_unlock(&afu->contexts_lock);
> -	return rc;
> -}
> -
> -static ssize_t api_version_show(struct device *device,
> -				struct device_attribute *attr,
> -				char *buf)
> -{
> -	return scnprintf(buf, PAGE_SIZE, "%i\n", CXL_API_VERSION);
> -}
> -
> -static ssize_t api_version_compatible_show(struct device *device,
> -					   struct device_attribute *attr,
> -					   char *buf)
> -{
> -	return scnprintf(buf, PAGE_SIZE, "%i\n", CXL_API_VERSION_COMPATIBLE);
> -}
> -
> -static ssize_t afu_eb_read(struct file *filp, struct kobject *kobj,
> -			       const struct bin_attribute *bin_attr, char *buf,
> -			       loff_t off, size_t count)
> -{
> -	struct cxl_afu *afu = to_cxl_afu(kobj_to_dev(kobj));
> -
> -	return cxl_ops->afu_read_err_buffer(afu, buf, off, count);
> -}
> -
> -static struct device_attribute afu_attrs[] = {
> -	__ATTR_RO(mmio_size),
> -	__ATTR_RO(irqs_min),
> -	__ATTR_RW(irqs_max),
> -	__ATTR_RO(modes_supported),
> -	__ATTR_RW(mode),
> -	__ATTR_RW(prefault_mode),
> -	__ATTR_RO(api_version),
> -	__ATTR_RO(api_version_compatible),
> -	__ATTR(reset, S_IWUSR, NULL, reset_store_afu),
> -};
> -
> -int cxl_sysfs_adapter_add(struct cxl *adapter)
> -{
> -	struct device_attribute *dev_attr;
> -	int i, rc;
> -
> -	for (i = 0; i < ARRAY_SIZE(adapter_attrs); i++) {
> -		dev_attr = &adapter_attrs[i];
> -		if (cxl_ops->support_attributes(dev_attr->attr.name,
> -						CXL_ADAPTER_ATTRS)) {
> -			if ((rc = device_create_file(&adapter->dev, dev_attr)))
> -				goto err;
> -		}
> -	}
> -	return 0;
> -err:
> -	for (i--; i >= 0; i--) {
> -		dev_attr = &adapter_attrs[i];
> -		if (cxl_ops->support_attributes(dev_attr->attr.name,
> -						CXL_ADAPTER_ATTRS))
> -			device_remove_file(&adapter->dev, dev_attr);
> -	}
> -	return rc;
> -}
> -
> -void cxl_sysfs_adapter_remove(struct cxl *adapter)
> -{
> -	struct device_attribute *dev_attr;
> -	int i;
> -
> -	for (i = 0; i < ARRAY_SIZE(adapter_attrs); i++) {
> -		dev_attr = &adapter_attrs[i];
> -		if (cxl_ops->support_attributes(dev_attr->attr.name,
> -						CXL_ADAPTER_ATTRS))
> -			device_remove_file(&adapter->dev, dev_attr);
> -	}
> -}
> -
> -struct afu_config_record {
> -	struct kobject kobj;
> -	struct bin_attribute config_attr;
> -	struct list_head list;
> -	int cr;
> -	u16 device;
> -	u16 vendor;
> -	u32 class;
> -};
> -
> -#define to_cr(obj) container_of(obj, struct afu_config_record, kobj)
> -
> -static ssize_t vendor_show(struct kobject *kobj,
> -			   struct kobj_attribute *attr, char *buf)
> -{
> -	struct afu_config_record *cr = to_cr(kobj);
> -
> -	return scnprintf(buf, PAGE_SIZE, "0x%.4x\n", cr->vendor);
> -}
> -
> -static ssize_t device_show(struct kobject *kobj,
> -			   struct kobj_attribute *attr, char *buf)
> -{
> -	struct afu_config_record *cr = to_cr(kobj);
> -
> -	return scnprintf(buf, PAGE_SIZE, "0x%.4x\n", cr->device);
> -}
> -
> -static ssize_t class_show(struct kobject *kobj,
> -			  struct kobj_attribute *attr, char *buf)
> -{
> -	struct afu_config_record *cr = to_cr(kobj);
> -
> -	return scnprintf(buf, PAGE_SIZE, "0x%.6x\n", cr->class);
> -}
> -
> -static ssize_t afu_read_config(struct file *filp, struct kobject *kobj,
> -			       const struct bin_attribute *bin_attr, char *buf,
> -			       loff_t off, size_t count)
> -{
> -	struct afu_config_record *cr = to_cr(kobj);
> -	struct cxl_afu *afu = to_cxl_afu(kobj_to_dev(kobj->parent));
> -
> -	u64 i, j, val, rc;
> -
> -	for (i = 0; i < count;) {
> -		rc = cxl_ops->afu_cr_read64(afu, cr->cr, off & ~0x7, &val);
> -		if (rc)
> -			val = ~0ULL;
> -		for (j = off & 0x7; j < 8 && i < count; i++, j++, off++)
> -			buf[i] = (val >> (j * 8)) & 0xff;
> -	}
> -
> -	return count;
> -}
> -
> -static struct kobj_attribute vendor_attribute =
> -	__ATTR_RO(vendor);
> -static struct kobj_attribute device_attribute =
> -	__ATTR_RO(device);
> -static struct kobj_attribute class_attribute =
> -	__ATTR_RO(class);
> -
> -static struct attribute *afu_cr_attrs[] = {
> -	&vendor_attribute.attr,
> -	&device_attribute.attr,
> -	&class_attribute.attr,
> -	NULL,
> -};
> -ATTRIBUTE_GROUPS(afu_cr);
> -
> -static void release_afu_config_record(struct kobject *kobj)
> -{
> -	struct afu_config_record *cr = to_cr(kobj);
> -
> -	kfree(cr);
> -}
> -
> -static const struct kobj_type afu_config_record_type = {
> -	.sysfs_ops = &kobj_sysfs_ops,
> -	.release = release_afu_config_record,
> -	.default_groups = afu_cr_groups,
> -};
> -
> -static struct afu_config_record *cxl_sysfs_afu_new_cr(struct cxl_afu *afu, int cr_idx)
> -{
> -	struct afu_config_record *cr;
> -	int rc;
> -
> -	cr = kzalloc(sizeof(struct afu_config_record), GFP_KERNEL);
> -	if (!cr)
> -		return ERR_PTR(-ENOMEM);
> -
> -	cr->cr = cr_idx;
> -
> -	rc = cxl_ops->afu_cr_read16(afu, cr_idx, PCI_DEVICE_ID, &cr->device);
> -	if (rc)
> -		goto err;
> -	rc = cxl_ops->afu_cr_read16(afu, cr_idx, PCI_VENDOR_ID, &cr->vendor);
> -	if (rc)
> -		goto err;
> -	rc = cxl_ops->afu_cr_read32(afu, cr_idx, PCI_CLASS_REVISION, &cr->class);
> -	if (rc)
> -		goto err;
> -	cr->class >>= 8;
> -
> -	/*
> -	 * Export raw AFU PCIe like config record. For now this is read only by
> -	 * root - we can expand that later to be readable by non-root and maybe
> -	 * even writable provided we have a good use-case. Once we support
> -	 * exposing AFUs through a virtual PHB they will get that for free from
> -	 * Linux' PCI infrastructure, but until then it's not clear that we
> -	 * need it for anything since the main use case is just identifying
> -	 * AFUs, which can be done via the vendor, device and class attributes.
> -	 */
> -	sysfs_bin_attr_init(&cr->config_attr);
> -	cr->config_attr.attr.name = "config";
> -	cr->config_attr.attr.mode = S_IRUSR;
> -	cr->config_attr.size = afu->crs_len;
> -	cr->config_attr.read_new = afu_read_config;
> -
> -	rc = kobject_init_and_add(&cr->kobj, &afu_config_record_type,
> -				  &afu->dev.kobj, "cr%i", cr->cr);
> -	if (rc)
> -		goto err1;
> -
> -	rc = sysfs_create_bin_file(&cr->kobj, &cr->config_attr);
> -	if (rc)
> -		goto err1;
> -
> -	rc = kobject_uevent(&cr->kobj, KOBJ_ADD);
> -	if (rc)
> -		goto err2;
> -
> -	return cr;
> -err2:
> -	sysfs_remove_bin_file(&cr->kobj, &cr->config_attr);
> -err1:
> -	kobject_put(&cr->kobj);
> -	return ERR_PTR(rc);
> -err:
> -	kfree(cr);
> -	return ERR_PTR(rc);
> -}
> -
> -void cxl_sysfs_afu_remove(struct cxl_afu *afu)
> -{
> -	struct device_attribute *dev_attr;
> -	struct afu_config_record *cr, *tmp;
> -	int i;
> -
> -	/* remove the err buffer bin attribute */
> -	if (afu->eb_len)
> -		device_remove_bin_file(&afu->dev, &afu->attr_eb);
> -
> -	for (i = 0; i < ARRAY_SIZE(afu_attrs); i++) {
> -		dev_attr = &afu_attrs[i];
> -		if (cxl_ops->support_attributes(dev_attr->attr.name,
> -						CXL_AFU_ATTRS))
> -			device_remove_file(&afu->dev, &afu_attrs[i]);
> -	}
> -
> -	list_for_each_entry_safe(cr, tmp, &afu->crs, list) {
> -		sysfs_remove_bin_file(&cr->kobj, &cr->config_attr);
> -		kobject_put(&cr->kobj);
> -	}
> -}
> -
> -int cxl_sysfs_afu_add(struct cxl_afu *afu)
> -{
> -	struct device_attribute *dev_attr;
> -	struct afu_config_record *cr;
> -	int i, rc;
> -
> -	INIT_LIST_HEAD(&afu->crs);
> -
> -	for (i = 0; i < ARRAY_SIZE(afu_attrs); i++) {
> -		dev_attr = &afu_attrs[i];
> -		if (cxl_ops->support_attributes(dev_attr->attr.name,
> -						CXL_AFU_ATTRS)) {
> -			if ((rc = device_create_file(&afu->dev, &afu_attrs[i])))
> -				goto err;
> -		}
> -	}
> -
> -	/* conditionally create the add the binary file for error info buffer */
> -	if (afu->eb_len) {
> -		sysfs_attr_init(&afu->attr_eb.attr);
> -
> -		afu->attr_eb.attr.name = "afu_err_buff";
> -		afu->attr_eb.attr.mode = S_IRUGO;
> -		afu->attr_eb.size = afu->eb_len;
> -		afu->attr_eb.read_new = afu_eb_read;
> -
> -		rc = device_create_bin_file(&afu->dev, &afu->attr_eb);
> -		if (rc) {
> -			dev_err(&afu->dev,
> -				"Unable to create eb attr for the afu. Err(%d)\n",
> -				rc);
> -			goto err;
> -		}
> -	}
> -
> -	for (i = 0; i < afu->crs_num; i++) {
> -		cr = cxl_sysfs_afu_new_cr(afu, i);
> -		if (IS_ERR(cr)) {
> -			rc = PTR_ERR(cr);
> -			goto err1;
> -		}
> -		list_add(&cr->list, &afu->crs);
> -	}
> -
> -	return 0;
> -
> -err1:
> -	cxl_sysfs_afu_remove(afu);
> -	return rc;
> -err:
> -	/* reset the eb_len as we havent created the bin attr */
> -	afu->eb_len = 0;
> -
> -	for (i--; i >= 0; i--) {
> -		dev_attr = &afu_attrs[i];
> -		if (cxl_ops->support_attributes(dev_attr->attr.name,
> -						CXL_AFU_ATTRS))
> -		device_remove_file(&afu->dev, &afu_attrs[i]);
> -	}
> -	return rc;
> -}
> -
> -int cxl_sysfs_afu_m_add(struct cxl_afu *afu)
> -{
> -	struct device_attribute *dev_attr;
> -	int i, rc;
> -
> -	for (i = 0; i < ARRAY_SIZE(afu_master_attrs); i++) {
> -		dev_attr = &afu_master_attrs[i];
> -		if (cxl_ops->support_attributes(dev_attr->attr.name,
> -						CXL_AFU_MASTER_ATTRS)) {
> -			if ((rc = device_create_file(afu->chardev_m, &afu_master_attrs[i])))
> -				goto err;
> -		}
> -	}
> -
> -	return 0;
> -
> -err:
> -	for (i--; i >= 0; i--) {
> -		dev_attr = &afu_master_attrs[i];
> -		if (cxl_ops->support_attributes(dev_attr->attr.name,
> -						CXL_AFU_MASTER_ATTRS))
> -			device_remove_file(afu->chardev_m, &afu_master_attrs[i]);
> -	}
> -	return rc;
> -}
> -
> -void cxl_sysfs_afu_m_remove(struct cxl_afu *afu)
> -{
> -	struct device_attribute *dev_attr;
> -	int i;
> -
> -	for (i = 0; i < ARRAY_SIZE(afu_master_attrs); i++) {
> -		dev_attr = &afu_master_attrs[i];
> -		if (cxl_ops->support_attributes(dev_attr->attr.name,
> -						CXL_AFU_MASTER_ATTRS))
> -			device_remove_file(afu->chardev_m, &afu_master_attrs[i]);
> -	}
> -}
> diff --git a/drivers/misc/cxl/trace.c b/drivers/misc/cxl/trace.c
> deleted file mode 100644
> index 86f654b99efb..000000000000
> --- a/drivers/misc/cxl/trace.c
> +++ /dev/null
> @@ -1,9 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * Copyright 2015 IBM Corp.
> - */
> -
> -#ifndef __CHECKER__
> -#define CREATE_TRACE_POINTS
> -#include "trace.h"
> -#endif
> diff --git a/drivers/misc/cxl/trace.h b/drivers/misc/cxl/trace.h
> deleted file mode 100644
> index c474157c6857..000000000000
> --- a/drivers/misc/cxl/trace.h
> +++ /dev/null
> @@ -1,691 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * Copyright 2015 IBM Corp.
> - */
> -
> -#undef TRACE_SYSTEM
> -#define TRACE_SYSTEM cxl
> -
> -#if !defined(_CXL_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
> -#define _CXL_TRACE_H
> -
> -#include <linux/tracepoint.h>
> -
> -#include "cxl.h"
> -
> -#define dsisr_psl9_flags(flags) \
> -	__print_flags(flags, "|", \
> -		{ CXL_PSL9_DSISR_An_CO_MASK,	"FR" }, \
> -		{ CXL_PSL9_DSISR_An_TF,		"TF" }, \
> -		{ CXL_PSL9_DSISR_An_PE,		"PE" }, \
> -		{ CXL_PSL9_DSISR_An_AE,		"AE" }, \
> -		{ CXL_PSL9_DSISR_An_OC,		"OC" }, \
> -		{ CXL_PSL9_DSISR_An_S,		"S" })
> -
> -#define DSISR_FLAGS \
> -	{ CXL_PSL_DSISR_An_DS,	"DS" }, \
> -	{ CXL_PSL_DSISR_An_DM,	"DM" }, \
> -	{ CXL_PSL_DSISR_An_ST,	"ST" }, \
> -	{ CXL_PSL_DSISR_An_UR,	"UR" }, \
> -	{ CXL_PSL_DSISR_An_PE,	"PE" }, \
> -	{ CXL_PSL_DSISR_An_AE,	"AE" }, \
> -	{ CXL_PSL_DSISR_An_OC,	"OC" }, \
> -	{ CXL_PSL_DSISR_An_M,	"M" }, \
> -	{ CXL_PSL_DSISR_An_P,	"P" }, \
> -	{ CXL_PSL_DSISR_An_A,	"A" }, \
> -	{ CXL_PSL_DSISR_An_S,	"S" }, \
> -	{ CXL_PSL_DSISR_An_K,	"K" }
> -
> -#define TFC_FLAGS \
> -	{ CXL_PSL_TFC_An_A,	"A" }, \
> -	{ CXL_PSL_TFC_An_C,	"C" }, \
> -	{ CXL_PSL_TFC_An_AE,	"AE" }, \
> -	{ CXL_PSL_TFC_An_R,	"R" }
> -
> -#define LLCMD_NAMES \
> -	{ CXL_SPA_SW_CMD_TERMINATE,	"TERMINATE" }, \
> -	{ CXL_SPA_SW_CMD_REMOVE,	"REMOVE" }, \
> -	{ CXL_SPA_SW_CMD_SUSPEND,	"SUSPEND" }, \
> -	{ CXL_SPA_SW_CMD_RESUME,	"RESUME" }, \
> -	{ CXL_SPA_SW_CMD_ADD,		"ADD" }, \
> -	{ CXL_SPA_SW_CMD_UPDATE,	"UPDATE" }
> -
> -#define AFU_COMMANDS \
> -	{ 0,			"DISABLE" }, \
> -	{ CXL_AFU_Cntl_An_E,	"ENABLE" }, \
> -	{ CXL_AFU_Cntl_An_RA,	"RESET" }
> -
> -#define PSL_COMMANDS \
> -	{ CXL_PSL_SCNTL_An_Pc,	"PURGE" }, \
> -	{ CXL_PSL_SCNTL_An_Sc,	"SUSPEND" }
> -
> -
> -DECLARE_EVENT_CLASS(cxl_pe_class,
> -	TP_PROTO(struct cxl_context *ctx),
> -
> -	TP_ARGS(ctx),
> -
> -	TP_STRUCT__entry(
> -		__field(u8, card)
> -		__field(u8, afu)
> -		__field(u16, pe)
> -	),
> -
> -	TP_fast_assign(
> -		__entry->card = ctx->afu->adapter->adapter_num;
> -		__entry->afu = ctx->afu->slice;
> -		__entry->pe = ctx->pe;
> -	),
> -
> -	TP_printk("afu%i.%i pe=%i",
> -		__entry->card,
> -		__entry->afu,
> -		__entry->pe
> -	)
> -);
> -
> -
> -TRACE_EVENT(cxl_attach,
> -	TP_PROTO(struct cxl_context *ctx, u64 wed, s16 num_interrupts, u64 amr),
> -
> -	TP_ARGS(ctx, wed, num_interrupts, amr),
> -
> -	TP_STRUCT__entry(
> -		__field(u8, card)
> -		__field(u8, afu)
> -		__field(u16, pe)
> -		__field(pid_t, pid)
> -		__field(u64, wed)
> -		__field(u64, amr)
> -		__field(s16, num_interrupts)
> -	),
> -
> -	TP_fast_assign(
> -		__entry->card = ctx->afu->adapter->adapter_num;
> -		__entry->afu = ctx->afu->slice;
> -		__entry->pe = ctx->pe;
> -		__entry->pid = pid_nr(ctx->pid);
> -		__entry->wed = wed;
> -		__entry->amr = amr;
> -		__entry->num_interrupts = num_interrupts;
> -	),
> -
> -	TP_printk("afu%i.%i pid=%i pe=%i wed=0x%016llx irqs=%i amr=0x%llx",
> -		__entry->card,
> -		__entry->afu,
> -		__entry->pid,
> -		__entry->pe,
> -		__entry->wed,
> -		__entry->num_interrupts,
> -		__entry->amr
> -	)
> -);
> -
> -DEFINE_EVENT(cxl_pe_class, cxl_detach,
> -	TP_PROTO(struct cxl_context *ctx),
> -	TP_ARGS(ctx)
> -);
> -
> -TRACE_EVENT(cxl_afu_irq,
> -	TP_PROTO(struct cxl_context *ctx, int afu_irq, int virq, irq_hw_number_t hwirq),
> -
> -	TP_ARGS(ctx, afu_irq, virq, hwirq),
> -
> -	TP_STRUCT__entry(
> -		__field(u8, card)
> -		__field(u8, afu)
> -		__field(u16, pe)
> -		__field(u16, afu_irq)
> -		__field(int, virq)
> -		__field(irq_hw_number_t, hwirq)
> -	),
> -
> -	TP_fast_assign(
> -		__entry->card = ctx->afu->adapter->adapter_num;
> -		__entry->afu = ctx->afu->slice;
> -		__entry->pe = ctx->pe;
> -		__entry->afu_irq = afu_irq;
> -		__entry->virq = virq;
> -		__entry->hwirq = hwirq;
> -	),
> -
> -	TP_printk("afu%i.%i pe=%i afu_irq=%i virq=%i hwirq=0x%lx",
> -		__entry->card,
> -		__entry->afu,
> -		__entry->pe,
> -		__entry->afu_irq,
> -		__entry->virq,
> -		__entry->hwirq
> -	)
> -);
> -
> -TRACE_EVENT(cxl_psl9_irq,
> -	TP_PROTO(struct cxl_context *ctx, int irq, u64 dsisr, u64 dar),
> -
> -	TP_ARGS(ctx, irq, dsisr, dar),
> -
> -	TP_STRUCT__entry(
> -		__field(u8, card)
> -		__field(u8, afu)
> -		__field(u16, pe)
> -		__field(int, irq)
> -		__field(u64, dsisr)
> -		__field(u64, dar)
> -	),
> -
> -	TP_fast_assign(
> -		__entry->card = ctx->afu->adapter->adapter_num;
> -		__entry->afu = ctx->afu->slice;
> -		__entry->pe = ctx->pe;
> -		__entry->irq = irq;
> -		__entry->dsisr = dsisr;
> -		__entry->dar = dar;
> -	),
> -
> -	TP_printk("afu%i.%i pe=%i irq=%i dsisr=0x%016llx dsisr=%s dar=0x%016llx",
> -		__entry->card,
> -		__entry->afu,
> -		__entry->pe,
> -		__entry->irq,
> -		__entry->dsisr,
> -		dsisr_psl9_flags(__entry->dsisr),
> -		__entry->dar
> -	)
> -);
> -
> -TRACE_EVENT(cxl_psl_irq,
> -	TP_PROTO(struct cxl_context *ctx, int irq, u64 dsisr, u64 dar),
> -
> -	TP_ARGS(ctx, irq, dsisr, dar),
> -
> -	TP_STRUCT__entry(
> -		__field(u8, card)
> -		__field(u8, afu)
> -		__field(u16, pe)
> -		__field(int, irq)
> -		__field(u64, dsisr)
> -		__field(u64, dar)
> -	),
> -
> -	TP_fast_assign(
> -		__entry->card = ctx->afu->adapter->adapter_num;
> -		__entry->afu = ctx->afu->slice;
> -		__entry->pe = ctx->pe;
> -		__entry->irq = irq;
> -		__entry->dsisr = dsisr;
> -		__entry->dar = dar;
> -	),
> -
> -	TP_printk("afu%i.%i pe=%i irq=%i dsisr=%s dar=0x%016llx",
> -		__entry->card,
> -		__entry->afu,
> -		__entry->pe,
> -		__entry->irq,
> -		__print_flags(__entry->dsisr, "|", DSISR_FLAGS),
> -		__entry->dar
> -	)
> -);
> -
> -TRACE_EVENT(cxl_psl_irq_ack,
> -	TP_PROTO(struct cxl_context *ctx, u64 tfc),
> -
> -	TP_ARGS(ctx, tfc),
> -
> -	TP_STRUCT__entry(
> -		__field(u8, card)
> -		__field(u8, afu)
> -		__field(u16, pe)
> -		__field(u64, tfc)
> -	),
> -
> -	TP_fast_assign(
> -		__entry->card = ctx->afu->adapter->adapter_num;
> -		__entry->afu = ctx->afu->slice;
> -		__entry->pe = ctx->pe;
> -		__entry->tfc = tfc;
> -	),
> -
> -	TP_printk("afu%i.%i pe=%i tfc=%s",
> -		__entry->card,
> -		__entry->afu,
> -		__entry->pe,
> -		__print_flags(__entry->tfc, "|", TFC_FLAGS)
> -	)
> -);
> -
> -TRACE_EVENT(cxl_ste_miss,
> -	TP_PROTO(struct cxl_context *ctx, u64 dar),
> -
> -	TP_ARGS(ctx, dar),
> -
> -	TP_STRUCT__entry(
> -		__field(u8, card)
> -		__field(u8, afu)
> -		__field(u16, pe)
> -		__field(u64, dar)
> -	),
> -
> -	TP_fast_assign(
> -		__entry->card = ctx->afu->adapter->adapter_num;
> -		__entry->afu = ctx->afu->slice;
> -		__entry->pe = ctx->pe;
> -		__entry->dar = dar;
> -	),
> -
> -	TP_printk("afu%i.%i pe=%i dar=0x%016llx",
> -		__entry->card,
> -		__entry->afu,
> -		__entry->pe,
> -		__entry->dar
> -	)
> -);
> -
> -TRACE_EVENT(cxl_ste_write,
> -	TP_PROTO(struct cxl_context *ctx, unsigned int idx, u64 e, u64 v),
> -
> -	TP_ARGS(ctx, idx, e, v),
> -
> -	TP_STRUCT__entry(
> -		__field(u8, card)
> -		__field(u8, afu)
> -		__field(u16, pe)
> -		__field(unsigned int, idx)
> -		__field(u64, e)
> -		__field(u64, v)
> -	),
> -
> -	TP_fast_assign(
> -		__entry->card = ctx->afu->adapter->adapter_num;
> -		__entry->afu = ctx->afu->slice;
> -		__entry->pe = ctx->pe;
> -		__entry->idx = idx;
> -		__entry->e = e;
> -		__entry->v = v;
> -	),
> -
> -	TP_printk("afu%i.%i pe=%i SSTE[%i] E=0x%016llx V=0x%016llx",
> -		__entry->card,
> -		__entry->afu,
> -		__entry->pe,
> -		__entry->idx,
> -		__entry->e,
> -		__entry->v
> -	)
> -);
> -
> -TRACE_EVENT(cxl_pte_miss,
> -	TP_PROTO(struct cxl_context *ctx, u64 dsisr, u64 dar),
> -
> -	TP_ARGS(ctx, dsisr, dar),
> -
> -	TP_STRUCT__entry(
> -		__field(u8, card)
> -		__field(u8, afu)
> -		__field(u16, pe)
> -		__field(u64, dsisr)
> -		__field(u64, dar)
> -	),
> -
> -	TP_fast_assign(
> -		__entry->card = ctx->afu->adapter->adapter_num;
> -		__entry->afu = ctx->afu->slice;
> -		__entry->pe = ctx->pe;
> -		__entry->dsisr = dsisr;
> -		__entry->dar = dar;
> -	),
> -
> -	TP_printk("afu%i.%i pe=%i dsisr=%s dar=0x%016llx",
> -		__entry->card,
> -		__entry->afu,
> -		__entry->pe,
> -		__print_flags(__entry->dsisr, "|", DSISR_FLAGS),
> -		__entry->dar
> -	)
> -);
> -
> -TRACE_EVENT(cxl_llcmd,
> -	TP_PROTO(struct cxl_context *ctx, u64 cmd),
> -
> -	TP_ARGS(ctx, cmd),
> -
> -	TP_STRUCT__entry(
> -		__field(u8, card)
> -		__field(u8, afu)
> -		__field(u16, pe)
> -		__field(u64, cmd)
> -	),
> -
> -	TP_fast_assign(
> -		__entry->card = ctx->afu->adapter->adapter_num;
> -		__entry->afu = ctx->afu->slice;
> -		__entry->pe = ctx->pe;
> -		__entry->cmd = cmd;
> -	),
> -
> -	TP_printk("afu%i.%i pe=%i cmd=%s",
> -		__entry->card,
> -		__entry->afu,
> -		__entry->pe,
> -		__print_symbolic_u64(__entry->cmd, LLCMD_NAMES)
> -	)
> -);
> -
> -TRACE_EVENT(cxl_llcmd_done,
> -	TP_PROTO(struct cxl_context *ctx, u64 cmd, int rc),
> -
> -	TP_ARGS(ctx, cmd, rc),
> -
> -	TP_STRUCT__entry(
> -		__field(u8, card)
> -		__field(u8, afu)
> -		__field(u16, pe)
> -		__field(u64, cmd)
> -		__field(int, rc)
> -	),
> -
> -	TP_fast_assign(
> -		__entry->card = ctx->afu->adapter->adapter_num;
> -		__entry->afu = ctx->afu->slice;
> -		__entry->pe = ctx->pe;
> -		__entry->rc = rc;
> -		__entry->cmd = cmd;
> -	),
> -
> -	TP_printk("afu%i.%i pe=%i cmd=%s rc=%i",
> -		__entry->card,
> -		__entry->afu,
> -		__entry->pe,
> -		__print_symbolic_u64(__entry->cmd, LLCMD_NAMES),
> -		__entry->rc
> -	)
> -);
> -
> -DECLARE_EVENT_CLASS(cxl_afu_psl_ctrl,
> -	TP_PROTO(struct cxl_afu *afu, u64 cmd),
> -
> -	TP_ARGS(afu, cmd),
> -
> -	TP_STRUCT__entry(
> -		__field(u8, card)
> -		__field(u8, afu)
> -		__field(u64, cmd)
> -	),
> -
> -	TP_fast_assign(
> -		__entry->card = afu->adapter->adapter_num;
> -		__entry->afu = afu->slice;
> -		__entry->cmd = cmd;
> -	),
> -
> -	TP_printk("afu%i.%i cmd=%s",
> -		__entry->card,
> -		__entry->afu,
> -		__print_symbolic_u64(__entry->cmd, AFU_COMMANDS)
> -	)
> -);
> -
> -DECLARE_EVENT_CLASS(cxl_afu_psl_ctrl_done,
> -	TP_PROTO(struct cxl_afu *afu, u64 cmd, int rc),
> -
> -	TP_ARGS(afu, cmd, rc),
> -
> -	TP_STRUCT__entry(
> -		__field(u8, card)
> -		__field(u8, afu)
> -		__field(u64, cmd)
> -		__field(int, rc)
> -	),
> -
> -	TP_fast_assign(
> -		__entry->card = afu->adapter->adapter_num;
> -		__entry->afu = afu->slice;
> -		__entry->rc = rc;
> -		__entry->cmd = cmd;
> -	),
> -
> -	TP_printk("afu%i.%i cmd=%s rc=%i",
> -		__entry->card,
> -		__entry->afu,
> -		__print_symbolic_u64(__entry->cmd, AFU_COMMANDS),
> -		__entry->rc
> -	)
> -);
> -
> -DEFINE_EVENT(cxl_afu_psl_ctrl, cxl_afu_ctrl,
> -	TP_PROTO(struct cxl_afu *afu, u64 cmd),
> -	TP_ARGS(afu, cmd)
> -);
> -
> -DEFINE_EVENT(cxl_afu_psl_ctrl_done, cxl_afu_ctrl_done,
> -	TP_PROTO(struct cxl_afu *afu, u64 cmd, int rc),
> -	TP_ARGS(afu, cmd, rc)
> -);
> -
> -DEFINE_EVENT_PRINT(cxl_afu_psl_ctrl, cxl_psl_ctrl,
> -	TP_PROTO(struct cxl_afu *afu, u64 cmd),
> -	TP_ARGS(afu, cmd),
> -
> -	TP_printk("psl%i.%i cmd=%s",
> -		__entry->card,
> -		__entry->afu,
> -		__print_symbolic_u64(__entry->cmd, PSL_COMMANDS)
> -	)
> -);
> -
> -DEFINE_EVENT_PRINT(cxl_afu_psl_ctrl_done, cxl_psl_ctrl_done,
> -	TP_PROTO(struct cxl_afu *afu, u64 cmd, int rc),
> -	TP_ARGS(afu, cmd, rc),
> -
> -	TP_printk("psl%i.%i cmd=%s rc=%i",
> -		__entry->card,
> -		__entry->afu,
> -		__print_symbolic_u64(__entry->cmd, PSL_COMMANDS),
> -		__entry->rc
> -	)
> -);
> -
> -DEFINE_EVENT(cxl_pe_class, cxl_slbia,
> -	TP_PROTO(struct cxl_context *ctx),
> -	TP_ARGS(ctx)
> -);
> -
> -TRACE_EVENT(cxl_hcall,
> -	TP_PROTO(u64 unit_address, u64 process_token, long rc),
> -
> -	TP_ARGS(unit_address, process_token, rc),
> -
> -	TP_STRUCT__entry(
> -		__field(u64, unit_address)
> -		__field(u64, process_token)
> -		__field(long, rc)
> -	),
> -
> -	TP_fast_assign(
> -		__entry->unit_address = unit_address;
> -		__entry->process_token = process_token;
> -		__entry->rc = rc;
> -	),
> -
> -	TP_printk("unit_address=0x%016llx process_token=0x%016llx rc=%li",
> -		__entry->unit_address,
> -		__entry->process_token,
> -		__entry->rc
> -	)
> -);
> -
> -TRACE_EVENT(cxl_hcall_control,
> -	TP_PROTO(u64 unit_address, char *fct, u64 p1, u64 p2, u64 p3,
> -	u64 p4, unsigned long r4, long rc),
> -
> -	TP_ARGS(unit_address, fct, p1, p2, p3, p4, r4, rc),
> -
> -	TP_STRUCT__entry(
> -		__field(u64, unit_address)
> -		__field(char *, fct)
> -		__field(u64, p1)
> -		__field(u64, p2)
> -		__field(u64, p3)
> -		__field(u64, p4)
> -		__field(unsigned long, r4)
> -		__field(long, rc)
> -	),
> -
> -	TP_fast_assign(
> -		__entry->unit_address = unit_address;
> -		__entry->fct = fct;
> -		__entry->p1 = p1;
> -		__entry->p2 = p2;
> -		__entry->p3 = p3;
> -		__entry->p4 = p4;
> -		__entry->r4 = r4;
> -		__entry->rc = rc;
> -	),
> -
> -	TP_printk("unit_address=%#.16llx %s(%#llx, %#llx, %#llx, %#llx, R4: %#lx)): %li",
> -		__entry->unit_address,
> -		__entry->fct,
> -		__entry->p1,
> -		__entry->p2,
> -		__entry->p3,
> -		__entry->p4,
> -		__entry->r4,
> -		__entry->rc
> -	)
> -);
> -
> -TRACE_EVENT(cxl_hcall_attach,
> -	TP_PROTO(u64 unit_address, u64 phys_addr, unsigned long process_token,
> -		unsigned long mmio_addr, unsigned long mmio_size, long rc),
> -
> -	TP_ARGS(unit_address, phys_addr, process_token,
> -		mmio_addr, mmio_size, rc),
> -
> -	TP_STRUCT__entry(
> -		__field(u64, unit_address)
> -		__field(u64, phys_addr)
> -		__field(unsigned long, process_token)
> -		__field(unsigned long, mmio_addr)
> -		__field(unsigned long, mmio_size)
> -		__field(long, rc)
> -	),
> -
> -	TP_fast_assign(
> -		__entry->unit_address = unit_address;
> -		__entry->phys_addr = phys_addr;
> -		__entry->process_token = process_token;
> -		__entry->mmio_addr = mmio_addr;
> -		__entry->mmio_size = mmio_size;
> -		__entry->rc = rc;
> -	),
> -
> -	TP_printk("unit_address=0x%016llx phys_addr=0x%016llx "
> -		"token=0x%.8lx mmio_addr=0x%lx mmio_size=0x%lx rc=%li",
> -		__entry->unit_address,
> -		__entry->phys_addr,
> -		__entry->process_token,
> -		__entry->mmio_addr,
> -		__entry->mmio_size,
> -		__entry->rc
> -	)
> -);
> -
> -DEFINE_EVENT(cxl_hcall, cxl_hcall_detach,
> -	TP_PROTO(u64 unit_address, u64 process_token, long rc),
> -	TP_ARGS(unit_address, process_token, rc)
> -);
> -
> -DEFINE_EVENT(cxl_hcall_control, cxl_hcall_control_function,
> -	TP_PROTO(u64 unit_address, char *fct, u64 p1, u64 p2, u64 p3,
> -	u64 p4, unsigned long r4, long rc),
> -	TP_ARGS(unit_address, fct, p1, p2, p3, p4, r4, rc)
> -);
> -
> -DEFINE_EVENT(cxl_hcall, cxl_hcall_collect_int_info,
> -	TP_PROTO(u64 unit_address, u64 process_token, long rc),
> -	TP_ARGS(unit_address, process_token, rc)
> -);
> -
> -TRACE_EVENT(cxl_hcall_control_faults,
> -	TP_PROTO(u64 unit_address, u64 process_token,
> -		u64 control_mask, u64 reset_mask, unsigned long r4,
> -		long rc),
> -
> -	TP_ARGS(unit_address, process_token,
> -		control_mask, reset_mask, r4, rc),
> -
> -	TP_STRUCT__entry(
> -		__field(u64, unit_address)
> -		__field(u64, process_token)
> -		__field(u64, control_mask)
> -		__field(u64, reset_mask)
> -		__field(unsigned long, r4)
> -		__field(long, rc)
> -	),
> -
> -	TP_fast_assign(
> -		__entry->unit_address = unit_address;
> -		__entry->process_token = process_token;
> -		__entry->control_mask = control_mask;
> -		__entry->reset_mask = reset_mask;
> -		__entry->r4 = r4;
> -		__entry->rc = rc;
> -	),
> -
> -	TP_printk("unit_address=0x%016llx process_token=0x%llx "
> -		"control_mask=%#llx reset_mask=%#llx r4=%#lx rc=%li",
> -		__entry->unit_address,
> -		__entry->process_token,
> -		__entry->control_mask,
> -		__entry->reset_mask,
> -		__entry->r4,
> -		__entry->rc
> -	)
> -);
> -
> -DEFINE_EVENT(cxl_hcall_control, cxl_hcall_control_facility,
> -	TP_PROTO(u64 unit_address, char *fct, u64 p1, u64 p2, u64 p3,
> -	u64 p4, unsigned long r4, long rc),
> -	TP_ARGS(unit_address, fct, p1, p2, p3, p4, r4, rc)
> -);
> -
> -TRACE_EVENT(cxl_hcall_download_facility,
> -	TP_PROTO(u64 unit_address, char *fct, u64 list_address, u64 num,
> -	unsigned long r4, long rc),
> -
> -	TP_ARGS(unit_address, fct, list_address, num, r4, rc),
> -
> -	TP_STRUCT__entry(
> -		__field(u64, unit_address)
> -		__field(char *, fct)
> -		__field(u64, list_address)
> -		__field(u64, num)
> -		__field(unsigned long, r4)
> -		__field(long, rc)
> -	),
> -
> -	TP_fast_assign(
> -		__entry->unit_address = unit_address;
> -		__entry->fct = fct;
> -		__entry->list_address = list_address;
> -		__entry->num = num;
> -		__entry->r4 = r4;
> -		__entry->rc = rc;
> -	),
> -
> -	TP_printk("%#.16llx, %s(%#llx, %#llx), %#lx): %li",
> -		__entry->unit_address,
> -		__entry->fct,
> -		__entry->list_address,
> -		__entry->num,
> -		__entry->r4,
> -		__entry->rc
> -	)
> -);
> -
> -#endif /* _CXL_TRACE_H */
> -
> -/* This part must be outside protection */
> -#undef TRACE_INCLUDE_PATH
> -#define TRACE_INCLUDE_PATH .
> -#define TRACE_INCLUDE_FILE trace
> -#include <trace/define_trace.h>
> diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
> deleted file mode 100644
> index 6332db8044bd..000000000000
> --- a/drivers/misc/cxl/vphb.c
> +++ /dev/null
> @@ -1,309 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * Copyright 2014 IBM Corp.
> - */
> -
> -#include <linux/pci.h>
> -#include <misc/cxl.h>
> -#include "cxl.h"
> -
> -static int cxl_pci_probe_mode(struct pci_bus *bus)
> -{
> -	return PCI_PROBE_NORMAL;
> -}
> -
> -static int cxl_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
> -{
> -	return -ENODEV;
> -}
> -
> -static void cxl_teardown_msi_irqs(struct pci_dev *pdev)
> -{
> -	/*
> -	 * MSI should never be set but need still need to provide this call
> -	 * back.
> -	 */
> -}
> -
> -static bool cxl_pci_enable_device_hook(struct pci_dev *dev)
> -{
> -	struct pci_controller *phb;
> -	struct cxl_afu *afu;
> -	struct cxl_context *ctx;
> -
> -	phb = pci_bus_to_host(dev->bus);
> -	afu = (struct cxl_afu *)phb->private_data;
> -
> -	if (!cxl_ops->link_ok(afu->adapter, afu)) {
> -		dev_warn(&dev->dev, "%s: Device link is down, refusing to enable AFU\n", __func__);
> -		return false;
> -	}
> -
> -	dev->dev.archdata.dma_offset = PAGE_OFFSET;
> -
> -	/*
> -	 * Allocate a context to do cxl things too.  If we eventually do real
> -	 * DMA ops, we'll need a default context to attach them to
> -	 */
> -	ctx = cxl_dev_context_init(dev);
> -	if (IS_ERR(ctx))
> -		return false;
> -	dev->dev.archdata.cxl_ctx = ctx;
> -
> -	return (cxl_ops->afu_check_and_enable(afu) == 0);
> -}
> -
> -static void cxl_pci_disable_device(struct pci_dev *dev)
> -{
> -	struct cxl_context *ctx = cxl_get_context(dev);
> -
> -	if (ctx) {
> -		if (ctx->status == STARTED) {
> -			dev_err(&dev->dev, "Default context started\n");
> -			return;
> -		}
> -		dev->dev.archdata.cxl_ctx = NULL;
> -		cxl_release_context(ctx);
> -	}
> -}
> -
> -static void cxl_pci_reset_secondary_bus(struct pci_dev *dev)
> -{
> -	/* Should we do an AFU reset here ? */
> -}
> -
> -static int cxl_pcie_cfg_record(u8 bus, u8 devfn)
> -{
> -	return (bus << 8) + devfn;
> -}
> -
> -static inline struct cxl_afu *pci_bus_to_afu(struct pci_bus *bus)
> -{
> -	struct pci_controller *phb = bus ? pci_bus_to_host(bus) : NULL;
> -
> -	return phb ? phb->private_data : NULL;
> -}
> -
> -static void cxl_afu_configured_put(struct cxl_afu *afu)
> -{
> -	atomic_dec_if_positive(&afu->configured_state);
> -}
> -
> -static bool cxl_afu_configured_get(struct cxl_afu *afu)
> -{
> -	return atomic_inc_unless_negative(&afu->configured_state);
> -}
> -
> -static inline int cxl_pcie_config_info(struct pci_bus *bus, unsigned int devfn,
> -				       struct cxl_afu *afu, int *_record)
> -{
> -	int record;
> -
> -	record = cxl_pcie_cfg_record(bus->number, devfn);
> -	if (record > afu->crs_num)
> -		return PCIBIOS_DEVICE_NOT_FOUND;
> -
> -	*_record = record;
> -	return 0;
> -}
> -
> -static int cxl_pcie_read_config(struct pci_bus *bus, unsigned int devfn,
> -				int offset, int len, u32 *val)
> -{
> -	int rc, record;
> -	struct cxl_afu *afu;
> -	u8 val8;
> -	u16 val16;
> -	u32 val32;
> -
> -	afu = pci_bus_to_afu(bus);
> -	/* Grab a reader lock on afu. */
> -	if (afu == NULL || !cxl_afu_configured_get(afu))
> -		return PCIBIOS_DEVICE_NOT_FOUND;
> -
> -	rc = cxl_pcie_config_info(bus, devfn, afu, &record);
> -	if (rc)
> -		goto out;
> -
> -	switch (len) {
> -	case 1:
> -		rc = cxl_ops->afu_cr_read8(afu, record, offset,	&val8);
> -		*val = val8;
> -		break;
> -	case 2:
> -		rc = cxl_ops->afu_cr_read16(afu, record, offset, &val16);
> -		*val = val16;
> -		break;
> -	case 4:
> -		rc = cxl_ops->afu_cr_read32(afu, record, offset, &val32);
> -		*val = val32;
> -		break;
> -	default:
> -		WARN_ON(1);
> -	}
> -
> -out:
> -	cxl_afu_configured_put(afu);
> -	return rc ? PCIBIOS_DEVICE_NOT_FOUND : 0;
> -}
> -
> -static int cxl_pcie_write_config(struct pci_bus *bus, unsigned int devfn,
> -				 int offset, int len, u32 val)
> -{
> -	int rc, record;
> -	struct cxl_afu *afu;
> -
> -	afu = pci_bus_to_afu(bus);
> -	/* Grab a reader lock on afu. */
> -	if (afu == NULL || !cxl_afu_configured_get(afu))
> -		return PCIBIOS_DEVICE_NOT_FOUND;
> -
> -	rc = cxl_pcie_config_info(bus, devfn, afu, &record);
> -	if (rc)
> -		goto out;
> -
> -	switch (len) {
> -	case 1:
> -		rc = cxl_ops->afu_cr_write8(afu, record, offset, val & 0xff);
> -		break;
> -	case 2:
> -		rc = cxl_ops->afu_cr_write16(afu, record, offset, val & 0xffff);
> -		break;
> -	case 4:
> -		rc = cxl_ops->afu_cr_write32(afu, record, offset, val);
> -		break;
> -	default:
> -		WARN_ON(1);
> -	}
> -
> -out:
> -	cxl_afu_configured_put(afu);
> -	return rc ? PCIBIOS_SET_FAILED : 0;
> -}
> -
> -static struct pci_ops cxl_pcie_pci_ops =
> -{
> -	.read = cxl_pcie_read_config,
> -	.write = cxl_pcie_write_config,
> -};
> -
> -
> -static struct pci_controller_ops cxl_pci_controller_ops =
> -{
> -	.probe_mode = cxl_pci_probe_mode,
> -	.enable_device_hook = cxl_pci_enable_device_hook,
> -	.disable_device = cxl_pci_disable_device,
> -	.release_device = cxl_pci_disable_device,
> -	.reset_secondary_bus = cxl_pci_reset_secondary_bus,
> -	.setup_msi_irqs = cxl_setup_msi_irqs,
> -	.teardown_msi_irqs = cxl_teardown_msi_irqs,
> -};
> -
> -int cxl_pci_vphb_add(struct cxl_afu *afu)
> -{
> -	struct pci_controller *phb;
> -	struct device_node *vphb_dn;
> -	struct device *parent;
> -
> -	/*
> -	 * If there are no AFU configuration records we won't have anything to
> -	 * expose under the vPHB, so skip creating one, returning success since
> -	 * this is still a valid case. This will also opt us out of EEH
> -	 * handling since we won't have anything special to do if there are no
> -	 * kernel drivers attached to the vPHB, and EEH handling is not yet
> -	 * supported in the peer model.
> -	 */
> -	if (!afu->crs_num)
> -		return 0;
> -
> -	/* The parent device is the adapter. Reuse the device node of
> -	 * the adapter.
> -	 * We don't seem to care what device node is used for the vPHB,
> -	 * but tools such as lsvpd walk up the device parents looking
> -	 * for a valid location code, so we might as well show devices
> -	 * attached to the adapter as being located on that adapter.
> -	 */
> -	parent = afu->adapter->dev.parent;
> -	vphb_dn = parent->of_node;
> -
> -	/* Alloc and setup PHB data structure */
> -	phb = pcibios_alloc_controller(vphb_dn);
> -	if (!phb)
> -		return -ENODEV;
> -
> -	/* Setup parent in sysfs */
> -	phb->parent = parent;
> -
> -	/* Setup the PHB using arch provided callback */
> -	phb->ops = &cxl_pcie_pci_ops;
> -	phb->cfg_addr = NULL;
> -	phb->cfg_data = NULL;
> -	phb->private_data = afu;
> -	phb->controller_ops = cxl_pci_controller_ops;
> -
> -	/* Scan the bus */
> -	pcibios_scan_phb(phb);
> -	if (phb->bus == NULL)
> -		return -ENXIO;
> -
> -	/* Set release hook on root bus */
> -	pci_set_host_bridge_release(to_pci_host_bridge(phb->bus->bridge),
> -				    pcibios_free_controller_deferred,
> -				    (void *) phb);
> -
> -	/* Claim resources. This might need some rework as well depending
> -	 * whether we are doing probe-only or not, like assigning unassigned
> -	 * resources etc...
> -	 */
> -	pcibios_claim_one_bus(phb->bus);
> -
> -	/* Add probed PCI devices to the device model */
> -	pci_bus_add_devices(phb->bus);
> -
> -	afu->phb = phb;
> -
> -	return 0;
> -}
> -
> -void cxl_pci_vphb_remove(struct cxl_afu *afu)
> -{
> -	struct pci_controller *phb;
> -
> -	/* If there is no configuration record we won't have one of these */
> -	if (!afu || !afu->phb)
> -		return;
> -
> -	phb = afu->phb;
> -	afu->phb = NULL;
> -
> -	pci_remove_root_bus(phb->bus);
> -	/*
> -	 * We don't free phb here - that's handled by
> -	 * pcibios_free_controller_deferred()
> -	 */
> -}
> -
> -bool cxl_pci_is_vphb_device(struct pci_dev *dev)
> -{
> -	struct pci_controller *phb;
> -
> -	phb = pci_bus_to_host(dev->bus);
> -
> -	return (phb->ops == &cxl_pcie_pci_ops);
> -}
> -
> -struct cxl_afu *cxl_pci_to_afu(struct pci_dev *dev)
> -{
> -	struct pci_controller *phb;
> -
> -	phb = pci_bus_to_host(dev->bus);
> -
> -	return (struct cxl_afu *)phb->private_data;
> -}
> -EXPORT_SYMBOL_GPL(cxl_pci_to_afu);
> -
> -unsigned int cxl_pci_to_cfg_record(struct pci_dev *dev)
> -{
> -	return cxl_pcie_cfg_record(dev->bus->number, dev->devfn);
> -}
> -EXPORT_SYMBOL_GPL(cxl_pci_to_cfg_record);
> diff --git a/include/misc/cxl-base.h b/include/misc/cxl-base.h
> deleted file mode 100644
> index 2251da7f32d9..000000000000
> --- a/include/misc/cxl-base.h
> +++ /dev/null
> @@ -1,48 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * Copyright 2014 IBM Corp.
> - */
> -
> -#ifndef _MISC_CXL_BASE_H
> -#define _MISC_CXL_BASE_H
> -
> -#ifdef CONFIG_CXL_BASE
> -
> -#define CXL_IRQ_RANGES 4
> -
> -struct cxl_irq_ranges {
> -	irq_hw_number_t offset[CXL_IRQ_RANGES];
> -	irq_hw_number_t range[CXL_IRQ_RANGES];
> -};
> -
> -extern atomic_t cxl_use_count;
> -
> -static inline bool cxl_ctx_in_use(void)
> -{
> -       return (atomic_read(&cxl_use_count) != 0);
> -}
> -
> -static inline void cxl_ctx_get(void)
> -{
> -       atomic_inc(&cxl_use_count);
> -}
> -
> -static inline void cxl_ctx_put(void)
> -{
> -       atomic_dec(&cxl_use_count);
> -}
> -
> -struct cxl_afu *cxl_afu_get(struct cxl_afu *afu);
> -void cxl_afu_put(struct cxl_afu *afu);
> -void cxl_slbia(struct mm_struct *mm);
> -
> -#else /* CONFIG_CXL_BASE */
> -
> -static inline bool cxl_ctx_in_use(void) { return false; }
> -static inline struct cxl_afu *cxl_afu_get(struct cxl_afu *afu) { return NULL; }
> -static inline void cxl_afu_put(struct cxl_afu *afu) {}
> -static inline void cxl_slbia(struct mm_struct *mm) {}
> -
> -#endif /* CONFIG_CXL_BASE */
> -
> -#endif
> diff --git a/include/misc/cxl.h b/include/misc/cxl.h
> deleted file mode 100644
> index d8044299d654..000000000000
> --- a/include/misc/cxl.h
> +++ /dev/null
> @@ -1,265 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * Copyright 2015 IBM Corp.
> - */
> -
> -#ifndef _MISC_CXL_H
> -#define _MISC_CXL_H
> -
> -#include <linux/pci.h>
> -#include <linux/poll.h>
> -#include <linux/interrupt.h>
> -#include <uapi/misc/cxl.h>
> -
> -/*
> - * This documents the in kernel API for driver to use CXL. It allows kernel
> - * drivers to bind to AFUs using an AFU configuration record exposed as a PCI
> - * configuration record.
> - *
> - * This API enables control over AFU and contexts which can't be part of the
> - * generic PCI API. This API is agnostic to the actual AFU.
> - */
> -
> -/* Get the AFU associated with a pci_dev */
> -struct cxl_afu *cxl_pci_to_afu(struct pci_dev *dev);
> -
> -/* Get the AFU conf record number associated with a pci_dev */
> -unsigned int cxl_pci_to_cfg_record(struct pci_dev *dev);
> -
> -
> -/*
> - * Context lifetime overview:
> - *
> - * An AFU context may be inited and then started and stopped multiple times
> - * before it's released. ie.
> - *    - cxl_dev_context_init()
> - *      - cxl_start_context()
> - *      - cxl_stop_context()
> - *      - cxl_start_context()
> - *      - cxl_stop_context()
> - *     ...repeat...
> - *    - cxl_release_context()
> - * Once released, a context can't be started again.
> - *
> - * One context is inited by the cxl driver for every pci_dev. This is to be
> - * used as a default kernel context. cxl_get_context() will get this
> - * context. This context will be released by PCI hot unplug, so doesn't need to
> - * be released explicitly by drivers.
> - *
> - * Additional kernel contexts may be inited using cxl_dev_context_init().
> - * These must be released using cxl_context_detach().
> - *
> - * Once a context has been inited, IRQs may be configured. Firstly these IRQs
> - * must be allocated (cxl_allocate_afu_irqs()), then individually mapped to
> - * specific handlers (cxl_map_afu_irq()).
> - *
> - * These IRQs can be unmapped (cxl_unmap_afu_irq()) and finally released
> - * (cxl_free_afu_irqs()).
> - *
> - * The AFU can be reset (cxl_afu_reset()). This will cause the PSL/AFU
> - * hardware to lose track of all contexts. It's upto the caller of
> - * cxl_afu_reset() to restart these contexts.
> - */
> -
> -/*
> - * On pci_enabled_device(), the cxl driver will init a single cxl context for
> - * use by the driver. It doesn't start this context (as that will likely
> - * generate DMA traffic for most AFUs).
> - *
> - * This gets the default context associated with this pci_dev.  This context
> - * doesn't need to be released as this will be done by the PCI subsystem on hot
> - * unplug.
> - */
> -struct cxl_context *cxl_get_context(struct pci_dev *dev);
> -/*
> - * Allocate and initalise a context associated with a AFU PCI device. This
> - * doesn't start the context in the AFU.
> - */
> -struct cxl_context *cxl_dev_context_init(struct pci_dev *dev);
> -/*
> - * Release and free a context. Context should be stopped before calling.
> - */
> -int cxl_release_context(struct cxl_context *ctx);
> -
> -/*
> - * Set and get private data associated with a context. Allows drivers to have a
> - * back pointer to some useful structure.
> - */
> -int cxl_set_priv(struct cxl_context *ctx, void *priv);
> -void *cxl_get_priv(struct cxl_context *ctx);
> -
> -/*
> - * Allocate AFU interrupts for this context. num=0 will allocate the default
> - * for this AFU as given in the AFU descriptor. This number doesn't include the
> - * interrupt 0 (CAIA defines AFU IRQ 0 for page faults). Each interrupt to be
> - * used must map a handler with cxl_map_afu_irq.
> - */
> -int cxl_allocate_afu_irqs(struct cxl_context *cxl, int num);
> -/* Free allocated interrupts */
> -void cxl_free_afu_irqs(struct cxl_context *cxl);
> -
> -/*
> - * Map a handler for an AFU interrupt associated with a particular context. AFU
> - * IRQS numbers start from 1 (CAIA defines AFU IRQ 0 for page faults). cookie
> - * is private data is that will be provided to the interrupt handler.
> - */
> -int cxl_map_afu_irq(struct cxl_context *cxl, int num,
> -		    irq_handler_t handler, void *cookie, char *name);
> -/* unmap mapped IRQ handlers */
> -void cxl_unmap_afu_irq(struct cxl_context *cxl, int num, void *cookie);
> -
> -/*
> - * Start work on the AFU. This starts an cxl context and associates it with a
> - * task. task == NULL will make it a kernel context.
> - */
> -int cxl_start_context(struct cxl_context *ctx, u64 wed,
> -		      struct task_struct *task);
> -/*
> - * Stop a context and remove it from the PSL
> - */
> -int cxl_stop_context(struct cxl_context *ctx);
> -
> -/* Reset the AFU */
> -int cxl_afu_reset(struct cxl_context *ctx);
> -
> -/*
> - * Set a context as a master context.
> - * This sets the default problem space area mapped as the full space, rather
> - * than just the per context area (for slaves).
> - */
> -void cxl_set_master(struct cxl_context *ctx);
> -
> -/*
> - * Map and unmap the AFU Problem Space area. The amount and location mapped
> - * depends on if this context is a master or slave.
> - */
> -void __iomem *cxl_psa_map(struct cxl_context *ctx);
> -void cxl_psa_unmap(void __iomem *addr);
> -
> -/*  Get the process element for this context */
> -int cxl_process_element(struct cxl_context *ctx);
> -
> -/*
> - * These calls allow drivers to create their own file descriptors and make them
> - * identical to the cxl file descriptor user API. An example use case:
> - *
> - * struct file_operations cxl_my_fops = {};
> - * ......
> - *	// Init the context
> - *	ctx = cxl_dev_context_init(dev);
> - *	if (IS_ERR(ctx))
> - *		return PTR_ERR(ctx);
> - *	// Create and attach a new file descriptor to my file ops
> - *	file = cxl_get_fd(ctx, &cxl_my_fops, &fd);
> - *	// Start context
> - *	rc = cxl_start_work(ctx, &work.work);
> - *	if (rc) {
> - *		fput(file);
> - *		put_unused_fd(fd);
> - *		return -ENODEV;
> - *	}
> - *	// No error paths after installing the fd
> - *	fd_install(fd, file);
> - *	return fd;
> - *
> - * This inits a context, and gets a file descriptor and associates some file
> - * ops to that file descriptor. If the file ops are blank, the cxl driver will
> - * fill them in with the default ones that mimic the standard user API.  Once
> - * completed, the file descriptor can be installed. Once the file descriptor is
> - * installed, it's visible to the user so no errors must occur past this point.
> - *
> - * If cxl_fd_release() file op call is installed, the context will be stopped
> - * and released when the fd is released. Hence the driver won't need to manage
> - * this itself.
> - */
> -
> -/*
> - * Take a context and associate it with my file ops. Returns the associated
> - * file and file descriptor. Any file ops which are blank are filled in by the
> - * cxl driver with the default ops to mimic the standard API.
> - */
> -struct file *cxl_get_fd(struct cxl_context *ctx, struct file_operations *fops,
> -			int *fd);
> -/* Get the context associated with this file */
> -struct cxl_context *cxl_fops_get_context(struct file *file);
> -/*
> - * Start a context associated a struct cxl_ioctl_start_work used by the
> - * standard cxl user API.
> - */
> -int cxl_start_work(struct cxl_context *ctx,
> -		   struct cxl_ioctl_start_work *work);
> -/*
> - * Export all the existing fops so drivers can use them
> - */
> -int cxl_fd_open(struct inode *inode, struct file *file);
> -int cxl_fd_release(struct inode *inode, struct file *file);
> -long cxl_fd_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
> -int cxl_fd_mmap(struct file *file, struct vm_area_struct *vm);
> -__poll_t cxl_fd_poll(struct file *file, struct poll_table_struct *poll);
> -ssize_t cxl_fd_read(struct file *file, char __user *buf, size_t count,
> -			   loff_t *off);
> -
> -/*
> - * For EEH, a driver may want to assert a PERST will reload the same image
> - * from flash into the FPGA.
> - *
> - * This is a property of the entire adapter, not a single AFU, so drivers
> - * should set this property with care!
> - */
> -void cxl_perst_reloads_same_image(struct cxl_afu *afu,
> -				  bool perst_reloads_same_image);
> -
> -/*
> - * Read the VPD for the card where the AFU resides
> - */
> -ssize_t cxl_read_adapter_vpd(struct pci_dev *dev, void *buf, size_t count);
> -
> -/*
> - * AFU driver ops allow an AFU driver to create their own events to pass to
> - * userspace through the file descriptor as a simpler alternative to overriding
> - * the read() and poll() calls that works with the generic cxl events. These
> - * events are given priority over the generic cxl events, so they will be
> - * delivered first if multiple types of events are pending.
> - *
> - * The AFU driver must call cxl_context_events_pending() to notify the cxl
> - * driver that new events are ready to be delivered for a specific context.
> - * cxl_context_events_pending() will adjust the current count of AFU driver
> - * events for this context, and wake up anyone waiting on the context wait
> - * queue.
> - *
> - * The cxl driver will then call fetch_event() to get a structure defining
> - * the size and address of the driver specific event data. The cxl driver
> - * will build a cxl header with type and process_element fields filled in,
> - * and header.size set to sizeof(struct cxl_event_header) + data_size.
> - * The total size of the event is limited to CXL_READ_MIN_SIZE (4K).
> - *
> - * fetch_event() is called with a spin lock held, so it must not sleep.
> - *
> - * The cxl driver will then deliver the event to userspace, and finally
> - * call event_delivered() to return the status of the operation, identified
> - * by cxl context and AFU driver event data pointers.
> - *   0        Success
> - *   -EFAULT  copy_to_user() has failed
> - *   -EINVAL  Event data pointer is NULL, or event size is greater than
> - *            CXL_READ_MIN_SIZE.
> - */
> -struct cxl_afu_driver_ops {
> -	struct cxl_event_afu_driver_reserved *(*fetch_event) (
> -						struct cxl_context *ctx);
> -	void (*event_delivered) (struct cxl_context *ctx,
> -				 struct cxl_event_afu_driver_reserved *event,
> -				 int rc);
> -};
> -
> -/*
> - * Associate the above driver ops with a specific context.
> - * Reset the current count of AFU driver events.
> - */
> -void cxl_set_driver_ops(struct cxl_context *ctx,
> -			struct cxl_afu_driver_ops *ops);
> -
> -/* Notify cxl driver that new events are ready to be delivered for context */
> -void cxl_context_events_pending(struct cxl_context *ctx,
> -				unsigned int new_events);
> -
> -#endif /* _MISC_CXL_H */
> diff --git a/include/misc/cxllib.h b/include/misc/cxllib.h
> deleted file mode 100644
> index eacc417288fc..000000000000
> --- a/include/misc/cxllib.h
> +++ /dev/null
> @@ -1,129 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * Copyright 2017 IBM Corp.
> - */
> -
> -#ifndef _MISC_CXLLIB_H
> -#define _MISC_CXLLIB_H
> -
> -#include <linux/pci.h>
> -#include <asm/reg.h>
> -
> -/*
> - * cxl driver exports a in-kernel 'library' API which can be called by
> - * other drivers to help interacting with an IBM XSL.
> - */
> -
> -/*
> - * tells whether capi is supported on the PCIe slot where the
> - * device is seated
> - *
> - * Input:
> - *	dev: device whose slot needs to be checked
> - *	flags: 0 for the time being
> - */
> -bool cxllib_slot_is_supported(struct pci_dev *dev, unsigned long flags);
> -
> -
> -/*
> - * Returns the configuration parameters to be used by the XSL or device
> - *
> - * Input:
> - *	dev: device, used to find PHB
> - * Output:
> - *	struct cxllib_xsl_config:
> - *		version
> - *		capi BAR address, i.e. 0x2000000000000-0x2FFFFFFFFFFFF
> - *		capi BAR size
> - *		data send control (XSL_DSNCTL)
> - *		dummy read address (XSL_DRA)
> - */
> -#define CXL_XSL_CONFIG_VERSION1		1
> -struct cxllib_xsl_config {
> -	u32	version;     /* format version for register encoding */
> -	u32	log_bar_size;/* log size of the capi_window */
> -	u64	bar_addr;    /* address of the start of capi window */
> -	u64	dsnctl;      /* matches definition of XSL_DSNCTL */
> -	u64	dra;         /* real address that can be used for dummy read */
> -};
> -
> -int cxllib_get_xsl_config(struct pci_dev *dev, struct cxllib_xsl_config *cfg);
> -
> -
> -/*
> - * Activate capi for the pci host bridge associated with the device.
> - * Can be extended to deactivate once we know how to do it.
> - * Device must be ready to accept messages from the CAPP unit and
> - * respond accordingly (TLB invalidates, ...)
> - *
> - * PHB is switched to capi mode through calls to skiboot.
> - * CAPP snooping is activated
> - *
> - * Input:
> - *	dev: device whose PHB should switch mode
> - *	mode: mode to switch to i.e. CAPI or PCI
> - *	flags: options related to the mode
> - */
> -enum cxllib_mode {
> -	CXL_MODE_CXL,
> -	CXL_MODE_PCI,
> -};
> -
> -#define CXL_MODE_NO_DMA       0
> -#define CXL_MODE_DMA_TVT0     1
> -#define CXL_MODE_DMA_TVT1     2
> -
> -int cxllib_switch_phb_mode(struct pci_dev *dev, enum cxllib_mode mode,
> -			unsigned long flags);
> -
> -
> -/*
> - * Set the device for capi DMA.
> - * Define its dma_ops and dma offset so that allocations will be using TVT#1
> - *
> - * Input:
> - *	dev: device to set
> - *	flags: options. CXL_MODE_DMA_TVT1 should be used
> - */
> -int cxllib_set_device_dma(struct pci_dev *dev, unsigned long flags);
> -
> -
> -/*
> - * Get the Process Element structure for the given thread
> - *
> - * Input:
> - *    task: task_struct for the context of the translation
> - *    translation_mode: whether addresses should be translated
> - * Output:
> - *    attr: attributes to fill up the Process Element structure from CAIA
> - */
> -struct cxllib_pe_attributes {
> -	u64 sr;
> -	u32 lpid;
> -	u32 tid;
> -	u32 pid;
> -};
> -#define CXL_TRANSLATED_MODE 0
> -#define CXL_REAL_MODE 1
> -
> -int cxllib_get_PE_attributes(struct task_struct *task,
> -	     unsigned long translation_mode, struct cxllib_pe_attributes *attr);
> -
> -
> -/*
> - * Handle memory fault.
> - * Fault in all the pages of the specified buffer for the permissions
> - * provided in ‘flags’
> - *
> - * Shouldn't be called from interrupt context
> - *
> - * Input:
> - *	mm: struct mm for the thread faulting the pages
> - *	addr: base address of the buffer to page in
> - *	size: size of the buffer to page in
> - *	flags: permission requested (DSISR_ISSTORE...)
> - */
> -int cxllib_handle_fault(struct mm_struct *mm, u64 addr, u64 size, u64 flags);
> -
> -
> -#endif /* _MISC_CXLLIB_H */
> diff --git a/include/uapi/misc/cxl.h b/include/uapi/misc/cxl.h
> deleted file mode 100644
> index 56376d3907d8..000000000000
> --- a/include/uapi/misc/cxl.h
> +++ /dev/null
> @@ -1,156 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> -/*
> - * Copyright 2014 IBM Corp.
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * as published by the Free Software Foundation; either version
> - * 2 of the License, or (at your option) any later version.
> - */
> -
> -#ifndef _UAPI_MISC_CXL_H
> -#define _UAPI_MISC_CXL_H
> -
> -#include <linux/types.h>
> -#include <linux/ioctl.h>
> -
> -
> -struct cxl_ioctl_start_work {
> -	__u64 flags;
> -	__u64 work_element_descriptor;
> -	__u64 amr;
> -	__s16 num_interrupts;
> -	__u16 tid;
> -	__s32 reserved1;
> -	__u64 reserved2;
> -	__u64 reserved3;
> -	__u64 reserved4;
> -	__u64 reserved5;
> -};
> -
> -#define CXL_START_WORK_AMR		0x0000000000000001ULL
> -#define CXL_START_WORK_NUM_IRQS		0x0000000000000002ULL
> -#define CXL_START_WORK_ERR_FF		0x0000000000000004ULL
> -#define CXL_START_WORK_TID		0x0000000000000008ULL
> -#define CXL_START_WORK_ALL		(CXL_START_WORK_AMR |\
> -					 CXL_START_WORK_NUM_IRQS |\
> -					 CXL_START_WORK_ERR_FF |\
> -					 CXL_START_WORK_TID)
> -
> -
> -/* Possible modes that an afu can be in */
> -#define CXL_MODE_DEDICATED   0x1
> -#define CXL_MODE_DIRECTED    0x2
> -
> -/* possible flags for the cxl_afu_id flags field */
> -#define CXL_AFUID_FLAG_SLAVE    0x1  /* In directed-mode afu is in slave mode */
> -
> -struct cxl_afu_id {
> -	__u64 flags;     /* One of CXL_AFUID_FLAG_X */
> -	__u32 card_id;
> -	__u32 afu_offset;
> -	__u32 afu_mode;  /* one of the CXL_MODE_X */
> -	__u32 reserved1;
> -	__u64 reserved2;
> -	__u64 reserved3;
> -	__u64 reserved4;
> -	__u64 reserved5;
> -	__u64 reserved6;
> -};
> -
> -/* base adapter image header is included in the image */
> -#define CXL_AI_NEED_HEADER	0x0000000000000001ULL
> -#define CXL_AI_ALL		CXL_AI_NEED_HEADER
> -
> -#define CXL_AI_HEADER_SIZE 128
> -#define CXL_AI_BUFFER_SIZE 4096
> -#define CXL_AI_MAX_ENTRIES 256
> -#define CXL_AI_MAX_CHUNK_SIZE (CXL_AI_BUFFER_SIZE * CXL_AI_MAX_ENTRIES)
> -
> -struct cxl_adapter_image {
> -	__u64 flags;
> -	__u64 data;
> -	__u64 len_data;
> -	__u64 len_image;
> -	__u64 reserved1;
> -	__u64 reserved2;
> -	__u64 reserved3;
> -	__u64 reserved4;
> -};
> -
> -/* ioctl numbers */
> -#define CXL_MAGIC 0xCA
> -/* AFU devices */
> -#define CXL_IOCTL_START_WORK		_IOW(CXL_MAGIC, 0x00, struct cxl_ioctl_start_work)
> -#define CXL_IOCTL_GET_PROCESS_ELEMENT	_IOR(CXL_MAGIC, 0x01, __u32)
> -#define CXL_IOCTL_GET_AFU_ID            _IOR(CXL_MAGIC, 0x02, struct cxl_afu_id)
> -/* adapter devices */
> -#define CXL_IOCTL_DOWNLOAD_IMAGE        _IOW(CXL_MAGIC, 0x0A, struct cxl_adapter_image)
> -#define CXL_IOCTL_VALIDATE_IMAGE        _IOW(CXL_MAGIC, 0x0B, struct cxl_adapter_image)
> -
> -#define CXL_READ_MIN_SIZE 0x1000 /* 4K */
> -
> -/* Events from read() */
> -enum cxl_event_type {
> -	CXL_EVENT_RESERVED      = 0,
> -	CXL_EVENT_AFU_INTERRUPT = 1,
> -	CXL_EVENT_DATA_STORAGE  = 2,
> -	CXL_EVENT_AFU_ERROR     = 3,
> -	CXL_EVENT_AFU_DRIVER    = 4,
> -};
> -
> -struct cxl_event_header {
> -	__u16 type;
> -	__u16 size;
> -	__u16 process_element;
> -	__u16 reserved1;
> -};
> -
> -struct cxl_event_afu_interrupt {
> -	__u16 flags;
> -	__u16 irq; /* Raised AFU interrupt number */
> -	__u32 reserved1;
> -};
> -
> -struct cxl_event_data_storage {
> -	__u16 flags;
> -	__u16 reserved1;
> -	__u32 reserved2;
> -	__u64 addr;
> -	__u64 dsisr;
> -	__u64 reserved3;
> -};
> -
> -struct cxl_event_afu_error {
> -	__u16 flags;
> -	__u16 reserved1;
> -	__u32 reserved2;
> -	__u64 error;
> -};
> -
> -struct cxl_event_afu_driver_reserved {
> -	/*
> -	 * Defines the buffer passed to the cxl driver by the AFU driver.
> -	 *
> -	 * This is not ABI since the event header.size passed to the user for
> -	 * existing events is set in the read call to sizeof(cxl_event_header)
> -	 * + sizeof(whatever event is being dispatched) and the user is already
> -	 * required to use a 4K buffer on the read call.
> -	 *
> -	 * Of course the contents will be ABI, but that's up the AFU driver.
> -	 */
> -	__u32 data_size;
> -	__u8 data[];
> -};
> -
> -struct cxl_event {
> -	struct cxl_event_header header;
> -	union {
> -		struct cxl_event_afu_interrupt irq;
> -		struct cxl_event_data_storage fault;
> -		struct cxl_event_afu_error afu_error;
> -		struct cxl_event_afu_driver_reserved afu_driver_event;
> -	};
> -};
> -
> -#endif /* _UAPI_MISC_CXL_H */



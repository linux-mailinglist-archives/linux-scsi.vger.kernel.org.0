Return-Path: <linux-scsi+bounces-11934-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1B3A2559D
	for <lists+linux-scsi@lfdr.de>; Mon,  3 Feb 2025 10:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E506B3A5E2B
	for <lists+linux-scsi@lfdr.de>; Mon,  3 Feb 2025 09:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB1A1FF7A5;
	Mon,  3 Feb 2025 09:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jcIBxtue"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC021FE46B;
	Mon,  3 Feb 2025 09:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738574273; cv=none; b=amlh0XeP+FZGEfQ8fqnJxJqgsWakIwyp3WpUH/gTqrZ/xmcjXFA7AlUwgzSw1DLfETkL7ATJTggTmGYGUz6Shpb8qh9Pz3z5eRPqGjMHEtvNGEbY8DjpLIC1oD4J8r5wYLU8mFGDgFFkYTK1euwRyW++u7S+Vm38hRUo+T4gx9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738574273; c=relaxed/simple;
	bh=xVJplvixyeNh+h3pNx8KM2uclngsItL9VGnO7bn5WJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sWrlmY5KG6G8K/mQ4gpFrcOW/iJ+hxikM+xZyyghr33ITIxuiOmE9lo3JBHBUBdU8QfMyBWtFzia3QPOji556gJKkXDRpGmhnGHEkQNJPI66fp872g3OPyNrdW7EmPL2YwFXa+y0NKl1t1Ze/orrR9+Kz4dbbmWbII3H8QH2J3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jcIBxtue; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51320sVF006368;
	Mon, 3 Feb 2025 09:17:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HZAtfZ
	Ah9z03oi9RvT1YS8rguE/UQOkUn0H7l9AMppE=; b=jcIBxtue9AXyjabOG83j4n
	g8L/Xw9EpgDvEwMYD2pEBkzoE56/At7qbO7OKEvMIRIhA/Rw7aLGfEPvLPi3qaiF
	RRqwIXdq0ue/Bp4gOitVsK9rOuq6DY50XkkUdt/ZOywJKzKpWn3O/TZ0CGb+BALf
	iNh71KIhUcN1lkMlJqe/dms/c8fTyCQ/Ou0hNDKhTuqRxi6aWX0FJ2BqLj76uiuy
	TkqyaZOy6ofWuPw6VNNvi5J/vzuJPHcqgKmxtsf/ZGX+jGRwZtGVa6y0vmMC68hM
	9lUO31QTwZdWQZB/3b0luUIiDQegTM7dhnSaY/o/KyaOA1NDaf6O9yiLqcUpV1PA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44jmmy9jaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 09:17:30 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5137EBGX016271;
	Mon, 3 Feb 2025 09:17:30 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44hwxs5rfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 09:17:29 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5139HPa450594206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Feb 2025 09:17:25 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30B422010C;
	Mon,  3 Feb 2025 09:17:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 338E620109;
	Mon,  3 Feb 2025 09:17:22 +0000 (GMT)
Received: from [9.179.15.153] (unknown [9.179.15.153])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Feb 2025 09:17:22 +0000 (GMT)
Message-ID: <2a7b6930-1b4f-4b98-8b25-d73d2e65030c@linux.ibm.com>
Date: Mon, 3 Feb 2025 10:17:21 +0100
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] cxlflash: Remove driver
To: Andrew Donnellan <ajd@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, ukrishn@linux.ibm.com,
        clombard@linux.ibm.com, vaibhav@linux.ibm.com
References: <20250203072801.365551-1-ajd@linux.ibm.com>
 <20250203072801.365551-2-ajd@linux.ibm.com>
Content-Language: en-US
From: Frederic Barrat <fbarrat@linux.ibm.com>
In-Reply-To: <20250203072801.365551-2-ajd@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uuV-b-mNXGdxHaNBWH6bjqrAN2ns2ZYr
X-Proofpoint-ORIG-GUID: uuV-b-mNXGdxHaNBWH6bjqrAN2ns2ZYr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_03,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 phishscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502030071



On 03/02/2025 08:27, Andrew Donnellan wrote:
> Remove the cxlflash driver for IBM CAPI Flash devices.
> 
> The cxlflash driver has received minimal maintenance for some time, and
> the CAPI Flash hardware that uses it is no longer commercially available.
> 
> Thanks to Uma Krishnan, Matthew Ochs and Manoj Kumar for their work on
> this driver over the years.
> 
> Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>


Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>

Thanks!
   Fred



> ---
> v2: rebase
> ---
>   Documentation/arch/powerpc/cxlflash.rst       |  433 --
>   Documentation/arch/powerpc/index.rst          |    1 -
>   .../userspace-api/ioctl/ioctl-number.rst      |    2 +-
>   MAINTAINERS                                   |    9 -
>   drivers/scsi/Kconfig                          |    1 -
>   drivers/scsi/Makefile                         |    1 -
>   drivers/scsi/cxlflash/Kconfig                 |   15 -
>   drivers/scsi/cxlflash/Makefile                |    5 -
>   drivers/scsi/cxlflash/backend.h               |   48 -
>   drivers/scsi/cxlflash/common.h                |  340 --
>   drivers/scsi/cxlflash/cxl_hw.c                |  177 -
>   drivers/scsi/cxlflash/lunmgt.c                |  278 --
>   drivers/scsi/cxlflash/main.c                  | 3970 -----------------
>   drivers/scsi/cxlflash/main.h                  |  129 -
>   drivers/scsi/cxlflash/ocxl_hw.c               | 1399 ------
>   drivers/scsi/cxlflash/ocxl_hw.h               |   72 -
>   drivers/scsi/cxlflash/sislite.h               |  560 ---
>   drivers/scsi/cxlflash/superpipe.c             | 2218 ---------
>   drivers/scsi/cxlflash/superpipe.h             |  150 -
>   drivers/scsi/cxlflash/vlun.c                  | 1336 ------
>   drivers/scsi/cxlflash/vlun.h                  |   82 -
>   include/uapi/scsi/cxlflash_ioctl.h            |  276 --
>   .../filesystems/statmount/statmount_test.c    |   13 +-
>   23 files changed, 7 insertions(+), 11508 deletions(-)
>   delete mode 100644 Documentation/arch/powerpc/cxlflash.rst
>   delete mode 100644 drivers/scsi/cxlflash/Kconfig
>   delete mode 100644 drivers/scsi/cxlflash/Makefile
>   delete mode 100644 drivers/scsi/cxlflash/backend.h
>   delete mode 100644 drivers/scsi/cxlflash/common.h
>   delete mode 100644 drivers/scsi/cxlflash/cxl_hw.c
>   delete mode 100644 drivers/scsi/cxlflash/lunmgt.c
>   delete mode 100644 drivers/scsi/cxlflash/main.c
>   delete mode 100644 drivers/scsi/cxlflash/main.h
>   delete mode 100644 drivers/scsi/cxlflash/ocxl_hw.c
>   delete mode 100644 drivers/scsi/cxlflash/ocxl_hw.h
>   delete mode 100644 drivers/scsi/cxlflash/sislite.h
>   delete mode 100644 drivers/scsi/cxlflash/superpipe.c
>   delete mode 100644 drivers/scsi/cxlflash/superpipe.h
>   delete mode 100644 drivers/scsi/cxlflash/vlun.c
>   delete mode 100644 drivers/scsi/cxlflash/vlun.h
>   delete mode 100644 include/uapi/scsi/cxlflash_ioctl.h
> 
> diff --git a/Documentation/arch/powerpc/cxlflash.rst b/Documentation/arch/powerpc/cxlflash.rst
> deleted file mode 100644
> index e8f488acfa41..000000000000
> --- a/Documentation/arch/powerpc/cxlflash.rst
> +++ /dev/null
> @@ -1,433 +0,0 @@
> -================================
> -Coherent Accelerator (CXL) Flash
> -================================
> -
> -Introduction
> -============
> -
> -    The IBM Power architecture provides support for CAPI (Coherent
> -    Accelerator Power Interface), which is available to certain PCIe slots
> -    on Power 8 systems. CAPI can be thought of as a special tunneling
> -    protocol through PCIe that allow PCIe adapters to look like special
> -    purpose co-processors which can read or write an application's
> -    memory and generate page faults. As a result, the host interface to
> -    an adapter running in CAPI mode does not require the data buffers to
> -    be mapped to the device's memory (IOMMU bypass) nor does it require
> -    memory to be pinned.
> -
> -    On Linux, Coherent Accelerator (CXL) kernel services present CAPI
> -    devices as a PCI device by implementing a virtual PCI host bridge.
> -    This abstraction simplifies the infrastructure and programming
> -    model, allowing for drivers to look similar to other native PCI
> -    device drivers.
> -
> -    CXL provides a mechanism by which user space applications can
> -    directly talk to a device (network or storage) bypassing the typical
> -    kernel/device driver stack. The CXL Flash Adapter Driver enables a
> -    user space application direct access to Flash storage.
> -
> -    The CXL Flash Adapter Driver is a kernel module that sits in the
> -    SCSI stack as a low level device driver (below the SCSI disk and
> -    protocol drivers) for the IBM CXL Flash Adapter. This driver is
> -    responsible for the initialization of the adapter, setting up the
> -    special path for user space access, and performing error recovery. It
> -    communicates directly the Flash Accelerator Functional Unit (AFU)
> -    as described in Documentation/arch/powerpc/cxl.rst.
> -
> -    The cxlflash driver supports two, mutually exclusive, modes of
> -    operation at the device (LUN) level:
> -
> -        - Any flash device (LUN) can be configured to be accessed as a
> -          regular disk device (i.e.: /dev/sdc). This is the default mode.
> -
> -        - Any flash device (LUN) can be configured to be accessed from
> -          user space with a special block library. This mode further
> -          specifies the means of accessing the device and provides for
> -          either raw access to the entire LUN (referred to as direct
> -          or physical LUN access) or access to a kernel/AFU-mediated
> -          partition of the LUN (referred to as virtual LUN access). The
> -          segmentation of a disk device into virtual LUNs is assisted
> -          by special translation services provided by the Flash AFU.
> -
> -Overview
> -========
> -
> -    The Coherent Accelerator Interface Architecture (CAIA) introduces a
> -    concept of a master context. A master typically has special privileges
> -    granted to it by the kernel or hypervisor allowing it to perform AFU
> -    wide management and control. The master may or may not be involved
> -    directly in each user I/O, but at the minimum is involved in the
> -    initial setup before the user application is allowed to send requests
> -    directly to the AFU.
> -
> -    The CXL Flash Adapter Driver establishes a master context with the
> -    AFU. It uses memory mapped I/O (MMIO) for this control and setup. The
> -    Adapter Problem Space Memory Map looks like this::
> -
> -                     +-------------------------------+
> -                     |    512 * 64 KB User MMIO      |
> -                     |        (per context)          |
> -                     |       User Accessible         |
> -                     +-------------------------------+
> -                     |    512 * 128 B per context    |
> -                     |    Provisioning and Control   |
> -                     |   Trusted Process accessible  |
> -                     +-------------------------------+
> -                     |         64 KB Global          |
> -                     |   Trusted Process accessible  |
> -                     +-------------------------------+
> -
> -    This driver configures itself into the SCSI software stack as an
> -    adapter driver. The driver is the only entity that is considered a
> -    Trusted Process to program the Provisioning and Control and Global
> -    areas in the MMIO Space shown above.  The master context driver
> -    discovers all LUNs attached to the CXL Flash adapter and instantiates
> -    scsi block devices (/dev/sdb, /dev/sdc etc.) for each unique LUN
> -    seen from each path.
> -
> -    Once these scsi block devices are instantiated, an application
> -    written to a specification provided by the block library may get
> -    access to the Flash from user space (without requiring a system call).
> -
> -    This master context driver also provides a series of ioctls for this
> -    block library to enable this user space access.  The driver supports
> -    two modes for accessing the block device.
> -
> -    The first mode is called a virtual mode. In this mode a single scsi
> -    block device (/dev/sdb) may be carved up into any number of distinct
> -    virtual LUNs. The virtual LUNs may be resized as long as the sum of
> -    the sizes of all the virtual LUNs, along with the meta-data associated
> -    with it does not exceed the physical capacity.
> -
> -    The second mode is called the physical mode. In this mode a single
> -    block device (/dev/sdb) may be opened directly by the block library
> -    and the entire space for the LUN is available to the application.
> -
> -    Only the physical mode provides persistence of the data.  i.e. The
> -    data written to the block device will survive application exit and
> -    restart and also reboot. The virtual LUNs do not persist (i.e. do
> -    not survive after the application terminates or the system reboots).
> -
> -
> -Block library API
> -=================
> -
> -    Applications intending to get access to the CXL Flash from user
> -    space should use the block library, as it abstracts the details of
> -    interfacing directly with the cxlflash driver that are necessary for
> -    performing administrative actions (i.e.: setup, tear down, resize).
> -    The block library can be thought of as a 'user' of services,
> -    implemented as IOCTLs, that are provided by the cxlflash driver
> -    specifically for devices (LUNs) operating in user space access
> -    mode. While it is not a requirement that applications understand
> -    the interface between the block library and the cxlflash driver,
> -    a high-level overview of each supported service (IOCTL) is provided
> -    below.
> -
> -    The block library can be found on GitHub:
> -    http://github.com/open-power/capiflash
> -
> -
> -CXL Flash Driver LUN IOCTLs
> -===========================
> -
> -    Users, such as the block library, that wish to interface with a flash
> -    device (LUN) via user space access need to use the services provided
> -    by the cxlflash driver. As these services are implemented as ioctls,
> -    a file descriptor handle must first be obtained in order to establish
> -    the communication channel between a user and the kernel.  This file
> -    descriptor is obtained by opening the device special file associated
> -    with the scsi disk device (/dev/sdb) that was created during LUN
> -    discovery. As per the location of the cxlflash driver within the
> -    SCSI protocol stack, this open is actually not seen by the cxlflash
> -    driver. Upon successful open, the user receives a file descriptor
> -    (herein referred to as fd1) that should be used for issuing the
> -    subsequent ioctls listed below.
> -
> -    The structure definitions for these IOCTLs are available in:
> -    uapi/scsi/cxlflash_ioctl.h
> -
> -DK_CXLFLASH_ATTACH
> -------------------
> -
> -    This ioctl obtains, initializes, and starts a context using the CXL
> -    kernel services. These services specify a context id (u16) by which
> -    to uniquely identify the context and its allocated resources. The
> -    services additionally provide a second file descriptor (herein
> -    referred to as fd2) that is used by the block library to initiate
> -    memory mapped I/O (via mmap()) to the CXL flash device and poll for
> -    completion events. This file descriptor is intentionally installed by
> -    this driver and not the CXL kernel services to allow for intermediary
> -    notification and access in the event of a non-user-initiated close(),
> -    such as a killed process. This design point is described in further
> -    detail in the description for the DK_CXLFLASH_DETACH ioctl.
> -
> -    There are a few important aspects regarding the "tokens" (context id
> -    and fd2) that are provided back to the user:
> -
> -        - These tokens are only valid for the process under which they
> -          were created. The child of a forked process cannot continue
> -          to use the context id or file descriptor created by its parent
> -          (see DK_CXLFLASH_VLUN_CLONE for further details).
> -
> -        - These tokens are only valid for the lifetime of the context and
> -          the process under which they were created. Once either is
> -          destroyed, the tokens are to be considered stale and subsequent
> -          usage will result in errors.
> -
> -	- A valid adapter file descriptor (fd2 >= 0) is only returned on
> -	  the initial attach for a context. Subsequent attaches to an
> -	  existing context (DK_CXLFLASH_ATTACH_REUSE_CONTEXT flag present)
> -	  do not provide the adapter file descriptor as it was previously
> -	  made known to the application.
> -
> -        - When a context is no longer needed, the user shall detach from
> -          the context via the DK_CXLFLASH_DETACH ioctl. When this ioctl
> -	  returns with a valid adapter file descriptor and the return flag
> -	  DK_CXLFLASH_APP_CLOSE_ADAP_FD is present, the application _must_
> -	  close the adapter file descriptor following a successful detach.
> -
> -	- When this ioctl returns with a valid fd2 and the return flag
> -	  DK_CXLFLASH_APP_CLOSE_ADAP_FD is present, the application _must_
> -	  close fd2 in the following circumstances:
> -
> -		+ Following a successful detach of the last user of the context
> -		+ Following a successful recovery on the context's original fd2
> -		+ In the child process of a fork(), following a clone ioctl,
> -		  on the fd2 associated with the source context
> -
> -        - At any time, a close on fd2 will invalidate the tokens. Applications
> -	  should exercise caution to only close fd2 when appropriate (outlined
> -	  in the previous bullet) to avoid premature loss of I/O.
> -
> -DK_CXLFLASH_USER_DIRECT
> ------------------------
> -    This ioctl is responsible for transitioning the LUN to direct
> -    (physical) mode access and configuring the AFU for direct access from
> -    user space on a per-context basis. Additionally, the block size and
> -    last logical block address (LBA) are returned to the user.
> -
> -    As mentioned previously, when operating in user space access mode,
> -    LUNs may be accessed in whole or in part. Only one mode is allowed
> -    at a time and if one mode is active (outstanding references exist),
> -    requests to use the LUN in a different mode are denied.
> -
> -    The AFU is configured for direct access from user space by adding an
> -    entry to the AFU's resource handle table. The index of the entry is
> -    treated as a resource handle that is returned to the user. The user
> -    is then able to use the handle to reference the LUN during I/O.
> -
> -DK_CXLFLASH_USER_VIRTUAL
> -------------------------
> -    This ioctl is responsible for transitioning the LUN to virtual mode
> -    of access and configuring the AFU for virtual access from user space
> -    on a per-context basis. Additionally, the block size and last logical
> -    block address (LBA) are returned to the user.
> -
> -    As mentioned previously, when operating in user space access mode,
> -    LUNs may be accessed in whole or in part. Only one mode is allowed
> -    at a time and if one mode is active (outstanding references exist),
> -    requests to use the LUN in a different mode are denied.
> -
> -    The AFU is configured for virtual access from user space by adding
> -    an entry to the AFU's resource handle table. The index of the entry
> -    is treated as a resource handle that is returned to the user. The
> -    user is then able to use the handle to reference the LUN during I/O.
> -
> -    By default, the virtual LUN is created with a size of 0. The user
> -    would need to use the DK_CXLFLASH_VLUN_RESIZE ioctl to adjust the grow
> -    the virtual LUN to a desired size. To avoid having to perform this
> -    resize for the initial creation of the virtual LUN, the user has the
> -    option of specifying a size as part of the DK_CXLFLASH_USER_VIRTUAL
> -    ioctl, such that when success is returned to the user, the
> -    resource handle that is provided is already referencing provisioned
> -    storage. This is reflected by the last LBA being a non-zero value.
> -
> -    When a LUN is accessible from more than one port, this ioctl will
> -    return with the DK_CXLFLASH_ALL_PORTS_ACTIVE return flag set. This
> -    provides the user with a hint that I/O can be retried in the event
> -    of an I/O error as the LUN can be reached over multiple paths.
> -
> -DK_CXLFLASH_VLUN_RESIZE
> ------------------------
> -    This ioctl is responsible for resizing a previously created virtual
> -    LUN and will fail if invoked upon a LUN that is not in virtual
> -    mode. Upon success, an updated last LBA is returned to the user
> -    indicating the new size of the virtual LUN associated with the
> -    resource handle.
> -
> -    The partitioning of virtual LUNs is jointly mediated by the cxlflash
> -    driver and the AFU. An allocation table is kept for each LUN that is
> -    operating in the virtual mode and used to program a LUN translation
> -    table that the AFU references when provided with a resource handle.
> -
> -    This ioctl can return -EAGAIN if an AFU sync operation takes too long.
> -    In addition to returning a failure to user, cxlflash will also schedule
> -    an asynchronous AFU reset. Should the user choose to retry the operation,
> -    it is expected to succeed. If this ioctl fails with -EAGAIN, the user
> -    can either retry the operation or treat it as a failure.
> -
> -DK_CXLFLASH_RELEASE
> --------------------
> -    This ioctl is responsible for releasing a previously obtained
> -    reference to either a physical or virtual LUN. This can be
> -    thought of as the inverse of the DK_CXLFLASH_USER_DIRECT or
> -    DK_CXLFLASH_USER_VIRTUAL ioctls. Upon success, the resource handle
> -    is no longer valid and the entry in the resource handle table is
> -    made available to be used again.
> -
> -    As part of the release process for virtual LUNs, the virtual LUN
> -    is first resized to 0 to clear out and free the translation tables
> -    associated with the virtual LUN reference.
> -
> -DK_CXLFLASH_DETACH
> -------------------
> -    This ioctl is responsible for unregistering a context with the
> -    cxlflash driver and release outstanding resources that were
> -    not explicitly released via the DK_CXLFLASH_RELEASE ioctl. Upon
> -    success, all "tokens" which had been provided to the user from the
> -    DK_CXLFLASH_ATTACH onward are no longer valid.
> -
> -    When the DK_CXLFLASH_APP_CLOSE_ADAP_FD flag was returned on a successful
> -    attach, the application _must_ close the fd2 associated with the context
> -    following the detach of the final user of the context.
> -
> -DK_CXLFLASH_VLUN_CLONE
> -----------------------
> -    This ioctl is responsible for cloning a previously created
> -    context to a more recently created context. It exists solely to
> -    support maintaining user space access to storage after a process
> -    forks. Upon success, the child process (which invoked the ioctl)
> -    will have access to the same LUNs via the same resource handle(s)
> -    as the parent, but under a different context.
> -
> -    Context sharing across processes is not supported with CXL and
> -    therefore each fork must be met with establishing a new context
> -    for the child process. This ioctl simplifies the state management
> -    and playback required by a user in such a scenario. When a process
> -    forks, child process can clone the parents context by first creating
> -    a context (via DK_CXLFLASH_ATTACH) and then using this ioctl to
> -    perform the clone from the parent to the child.
> -
> -    The clone itself is fairly simple. The resource handle and lun
> -    translation tables are copied from the parent context to the child's
> -    and then synced with the AFU.
> -
> -    When the DK_CXLFLASH_APP_CLOSE_ADAP_FD flag was returned on a successful
> -    attach, the application _must_ close the fd2 associated with the source
> -    context (still resident/accessible in the parent process) following the
> -    clone. This is to avoid a stale entry in the file descriptor table of the
> -    child process.
> -
> -    This ioctl can return -EAGAIN if an AFU sync operation takes too long.
> -    In addition to returning a failure to user, cxlflash will also schedule
> -    an asynchronous AFU reset. Should the user choose to retry the operation,
> -    it is expected to succeed. If this ioctl fails with -EAGAIN, the user
> -    can either retry the operation or treat it as a failure.
> -
> -DK_CXLFLASH_VERIFY
> -------------------
> -    This ioctl is used to detect various changes such as the capacity of
> -    the disk changing, the number of LUNs visible changing, etc. In cases
> -    where the changes affect the application (such as a LUN resize), the
> -    cxlflash driver will report the changed state to the application.
> -
> -    The user calls in when they want to validate that a LUN hasn't been
> -    changed in response to a check condition. As the user is operating out
> -    of band from the kernel, they will see these types of events without
> -    the kernel's knowledge. When encountered, the user's architected
> -    behavior is to call in to this ioctl, indicating what they want to
> -    verify and passing along any appropriate information. For now, only
> -    verifying a LUN change (ie: size different) with sense data is
> -    supported.
> -
> -DK_CXLFLASH_RECOVER_AFU
> ------------------------
> -    This ioctl is used to drive recovery (if such an action is warranted)
> -    of a specified user context. Any state associated with the user context
> -    is re-established upon successful recovery.
> -
> -    User contexts are put into an error condition when the device needs to
> -    be reset or is terminating. Users are notified of this error condition
> -    by seeing all 0xF's on an MMIO read. Upon encountering this, the
> -    architected behavior for a user is to call into this ioctl to recover
> -    their context. A user may also call into this ioctl at any time to
> -    check if the device is operating normally. If a failure is returned
> -    from this ioctl, the user is expected to gracefully clean up their
> -    context via release/detach ioctls. Until they do, the context they
> -    hold is not relinquished. The user may also optionally exit the process
> -    at which time the context/resources they held will be freed as part of
> -    the release fop.
> -
> -    When the DK_CXLFLASH_APP_CLOSE_ADAP_FD flag was returned on a successful
> -    attach, the application _must_ unmap and close the fd2 associated with the
> -    original context following this ioctl returning success and indicating that
> -    the context was recovered (DK_CXLFLASH_RECOVER_AFU_CONTEXT_RESET).
> -
> -DK_CXLFLASH_MANAGE_LUN
> -----------------------
> -    This ioctl is used to switch a LUN from a mode where it is available
> -    for file-system access (legacy), to a mode where it is set aside for
> -    exclusive user space access (superpipe). In case a LUN is visible
> -    across multiple ports and adapters, this ioctl is used to uniquely
> -    identify each LUN by its World Wide Node Name (WWNN).
> -
> -
> -CXL Flash Driver Host IOCTLs
> -============================
> -
> -    Each host adapter instance that is supported by the cxlflash driver
> -    has a special character device associated with it to enable a set of
> -    host management function. These character devices are hosted in a
> -    class dedicated for cxlflash and can be accessed via `/dev/cxlflash/*`.
> -
> -    Applications can be written to perform various functions using the
> -    host ioctl APIs below.
> -
> -    The structure definitions for these IOCTLs are available in:
> -    uapi/scsi/cxlflash_ioctl.h
> -
> -HT_CXLFLASH_LUN_PROVISION
> --------------------------
> -    This ioctl is used to create and delete persistent LUNs on cxlflash
> -    devices that lack an external LUN management interface. It is only
> -    valid when used with AFUs that support the LUN provision capability.
> -
> -    When sufficient space is available, LUNs can be created by specifying
> -    the target port to host the LUN and a desired size in 4K blocks. Upon
> -    success, the LUN ID and WWID of the created LUN will be returned and
> -    the SCSI bus can be scanned to detect the change in LUN topology. Note
> -    that partial allocations are not supported. Should a creation fail due
> -    to a space issue, the target port can be queried for its current LUN
> -    geometry.
> -
> -    To remove a LUN, the device must first be disassociated from the Linux
> -    SCSI subsystem. The LUN deletion can then be initiated by specifying a
> -    target port and LUN ID. Upon success, the LUN geometry associated with
> -    the port will be updated to reflect new number of provisioned LUNs and
> -    available capacity.
> -
> -    To query the LUN geometry of a port, the target port is specified and
> -    upon success, the following information is presented:
> -
> -        - Maximum number of provisioned LUNs allowed for the port
> -        - Current number of provisioned LUNs for the port
> -        - Maximum total capacity of provisioned LUNs for the port (4K blocks)
> -        - Current total capacity of provisioned LUNs for the port (4K blocks)
> -
> -    With this information, the number of available LUNs and capacity can be
> -    can be calculated.
> -
> -HT_CXLFLASH_AFU_DEBUG
> ----------------------
> -    This ioctl is used to debug AFUs by supporting a command pass-through
> -    interface. It is only valid when used with AFUs that support the AFU
> -    debug capability.
> -
> -    With exception of buffer management, AFU debug commands are opaque to
> -    cxlflash and treated as pass-through. For debug commands that do require
> -    data transfer, the user supplies an adequately sized data buffer and must
> -    specify the data transfer direction with respect to the host. There is a
> -    maximum transfer size of 256K imposed. Note that partial read completions
> -    are not supported - when errors are experienced with a host read data
> -    transfer, the data buffer is not copied back to the user.
> diff --git a/Documentation/arch/powerpc/index.rst b/Documentation/arch/powerpc/index.rst
> index 9749f6dc258f..995268530f21 100644
> --- a/Documentation/arch/powerpc/index.rst
> +++ b/Documentation/arch/powerpc/index.rst
> @@ -13,7 +13,6 @@ powerpc
>       cpu_families
>       cpu_features
>       cxl
> -    cxlflash
>       dawr-power9
>       dexcr
>       dscr
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index 6d1465315df3..efe133c50615 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -373,7 +373,7 @@ Code  Seq#    Include File                                           Comments
>   0xC0  00-0F  linux/usb/iowarrior.h
>   0xCA  00-0F  uapi/misc/cxl.h
>   0xCA  10-2F  uapi/misc/ocxl.h
> -0xCA  80-BF  uapi/scsi/cxlflash_ioctl.h
> +0xCA  80-BF  uapi/scsi/cxlflash_ioctl.h                              Dead since 6.14
>   0xCB  00-1F                                                          CBM serial IEC bus in development:
>                                                                        <mailto:michael.klein@puffin.lb.shuttle.de>
>   0xCC  00-0F  drivers/misc/ibmvmc.h                                   pseries VMC driver
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 896a307fa065..f1171fe71e4e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6318,15 +6318,6 @@ F:	drivers/misc/cxl/
>   F:	include/misc/cxl*
>   F:	include/uapi/misc/cxl.h
>   
> -CXLFLASH (IBM Coherent Accelerator Processor Interface CAPI Flash) SCSI DRIVER
> -M:	Manoj N. Kumar <manoj@linux.ibm.com>
> -M:	Uma Krishnan <ukrishn@linux.ibm.com>
> -L:	linux-scsi@vger.kernel.org
> -S:	Obsolete
> -F:	Documentation/arch/powerpc/cxlflash.rst
> -F:	drivers/scsi/cxlflash/
> -F:	include/uapi/scsi/cxlflash_ioctl.h
> -
>   CYBERPRO FB DRIVER
>   M:	Russell King <linux@armlinux.org.uk>
>   L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
> index 37c24ffea65c..c749d376159a 100644
> --- a/drivers/scsi/Kconfig
> +++ b/drivers/scsi/Kconfig
> @@ -336,7 +336,6 @@ source "drivers/scsi/cxgbi/Kconfig"
>   source "drivers/scsi/bnx2i/Kconfig"
>   source "drivers/scsi/bnx2fc/Kconfig"
>   source "drivers/scsi/be2iscsi/Kconfig"
> -source "drivers/scsi/cxlflash/Kconfig"
>   
>   config SGIWD93_SCSI
>   	tristate "SGI WD93C93 SCSI Driver"
> diff --git a/drivers/scsi/Makefile b/drivers/scsi/Makefile
> index 1313ddf2fd1a..16de3e41f94c 100644
> --- a/drivers/scsi/Makefile
> +++ b/drivers/scsi/Makefile
> @@ -96,7 +96,6 @@ obj-$(CONFIG_SCSI_SYM53C8XX_2)	+= sym53c8xx_2/
>   obj-$(CONFIG_SCSI_ZALON)	+= zalon7xx.o
>   obj-$(CONFIG_SCSI_DC395x)	+= dc395x.o
>   obj-$(CONFIG_SCSI_AM53C974)	+= esp_scsi.o	am53c974.o
> -obj-$(CONFIG_CXLFLASH)		+= cxlflash/
>   obj-$(CONFIG_MEGARAID_LEGACY)	+= megaraid.o
>   obj-$(CONFIG_MEGARAID_NEWGEN)	+= megaraid/
>   obj-$(CONFIG_MEGARAID_SAS)	+= megaraid/
> diff --git a/drivers/scsi/cxlflash/Kconfig b/drivers/scsi/cxlflash/Kconfig
> deleted file mode 100644
> index c424d36e89a6..000000000000
> --- a/drivers/scsi/cxlflash/Kconfig
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0-only
> -#
> -# IBM CXL-attached Flash Accelerator SCSI Driver
> -#
> -
> -config CXLFLASH
> -	tristate "Support for IBM CAPI Flash (DEPRECATED)"
> -	depends on PCI && SCSI && (CXL || OCXL) && EEH
> -	select IRQ_POLL
> -	help
> -	  The cxlflash driver is deprecated and will be removed in a future
> -	  kernel release.
> -
> -	  Allows CAPI Accelerated IO to Flash
> -	  If unsure, say N.
> diff --git a/drivers/scsi/cxlflash/Makefile b/drivers/scsi/cxlflash/Makefile
> deleted file mode 100644
> index fd2f0dd9daf9..000000000000
> --- a/drivers/scsi/cxlflash/Makefile
> +++ /dev/null
> @@ -1,5 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0-only
> -obj-$(CONFIG_CXLFLASH) += cxlflash.o
> -cxlflash-y += main.o superpipe.o lunmgt.o vlun.o
> -cxlflash-$(CONFIG_CXL) += cxl_hw.o
> -cxlflash-$(CONFIG_OCXL) += ocxl_hw.o
> diff --git a/drivers/scsi/cxlflash/backend.h b/drivers/scsi/cxlflash/backend.h
> deleted file mode 100644
> index 181e0445ed42..000000000000
> --- a/drivers/scsi/cxlflash/backend.h
> +++ /dev/null
> @@ -1,48 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * CXL Flash Device Driver
> - *
> - * Written by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>, IBM Corporation
> - *             Uma Krishnan <ukrishn@linux.vnet.ibm.com>, IBM Corporation
> - *
> - * Copyright (C) 2018 IBM Corporation
> - */
> -
> -#ifndef _CXLFLASH_BACKEND_H
> -#define _CXLFLASH_BACKEND_H
> -
> -extern const struct cxlflash_backend_ops cxlflash_cxl_ops;
> -extern const struct cxlflash_backend_ops cxlflash_ocxl_ops;
> -
> -struct cxlflash_backend_ops {
> -	struct module *module;
> -	void __iomem * (*psa_map)(void *ctx_cookie);
> -	void (*psa_unmap)(void __iomem *addr);
> -	int (*process_element)(void *ctx_cookie);
> -	int (*map_afu_irq)(void *ctx_cookie, int num, irq_handler_t handler,
> -			   void *cookie, char *name);
> -	void (*unmap_afu_irq)(void *ctx_cookie, int num, void *cookie);
> -	u64 (*get_irq_objhndl)(void *ctx_cookie, int irq);
> -	int (*start_context)(void *ctx_cookie);
> -	int (*stop_context)(void *ctx_cookie);
> -	int (*afu_reset)(void *ctx_cookie);
> -	void (*set_master)(void *ctx_cookie);
> -	void * (*get_context)(struct pci_dev *dev, void *afu_cookie);
> -	void * (*dev_context_init)(struct pci_dev *dev, void *afu_cookie);
> -	int (*release_context)(void *ctx_cookie);
> -	void (*perst_reloads_same_image)(void *afu_cookie, bool image);
> -	ssize_t (*read_adapter_vpd)(struct pci_dev *dev, void *buf,
> -				    size_t count);
> -	int (*allocate_afu_irqs)(void *ctx_cookie, int num);
> -	void (*free_afu_irqs)(void *ctx_cookie);
> -	void * (*create_afu)(struct pci_dev *dev);
> -	void (*destroy_afu)(void *afu_cookie);
> -	struct file * (*get_fd)(void *ctx_cookie, struct file_operations *fops,
> -				int *fd);
> -	void * (*fops_get_context)(struct file *file);
> -	int (*start_work)(void *ctx_cookie, u64 irqs);
> -	int (*fd_mmap)(struct file *file, struct vm_area_struct *vm);
> -	int (*fd_release)(struct inode *inode, struct file *file);
> -};
> -
> -#endif /* _CXLFLASH_BACKEND_H */
> diff --git a/drivers/scsi/cxlflash/common.h b/drivers/scsi/cxlflash/common.h
> deleted file mode 100644
> index de6229e27b48..000000000000
> --- a/drivers/scsi/cxlflash/common.h
> +++ /dev/null
> @@ -1,340 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * CXL Flash Device Driver
> - *
> - * Written by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>, IBM Corporation
> - *             Matthew R. Ochs <mrochs@linux.vnet.ibm.com>, IBM Corporation
> - *
> - * Copyright (C) 2015 IBM Corporation
> - */
> -
> -#ifndef _CXLFLASH_COMMON_H
> -#define _CXLFLASH_COMMON_H
> -
> -#include <linux/async.h>
> -#include <linux/cdev.h>
> -#include <linux/irq_poll.h>
> -#include <linux/list.h>
> -#include <linux/rwsem.h>
> -#include <linux/types.h>
> -#include <scsi/scsi.h>
> -#include <scsi/scsi_cmnd.h>
> -#include <scsi/scsi_device.h>
> -
> -#include "backend.h"
> -
> -extern const struct file_operations cxlflash_cxl_fops;
> -
> -#define MAX_CONTEXT	CXLFLASH_MAX_CONTEXT	/* num contexts per afu */
> -#define MAX_FC_PORTS	CXLFLASH_MAX_FC_PORTS	/* max ports per AFU */
> -#define LEGACY_FC_PORTS	2			/* legacy ports per AFU */
> -
> -#define CHAN2PORTBANK(_x)	((_x) >> ilog2(CXLFLASH_NUM_FC_PORTS_PER_BANK))
> -#define CHAN2BANKPORT(_x)	((_x) & (CXLFLASH_NUM_FC_PORTS_PER_BANK - 1))
> -
> -#define CHAN2PORTMASK(_x)	(1 << (_x))	/* channel to port mask */
> -#define PORTMASK2CHAN(_x)	(ilog2((_x)))	/* port mask to channel */
> -#define PORTNUM2CHAN(_x)	((_x) - 1)	/* port number to channel */
> -
> -#define CXLFLASH_BLOCK_SIZE	4096		/* 4K blocks */
> -#define CXLFLASH_MAX_XFER_SIZE	16777216	/* 16MB transfer */
> -#define CXLFLASH_MAX_SECTORS	(CXLFLASH_MAX_XFER_SIZE/512)	/* SCSI wants
> -								 * max_sectors
> -								 * in units of
> -								 * 512 byte
> -								 * sectors
> -								 */
> -
> -#define MAX_RHT_PER_CONTEXT (PAGE_SIZE / sizeof(struct sisl_rht_entry))
> -
> -/* AFU command retry limit */
> -#define MC_RETRY_CNT	5	/* Sufficient for SCSI and certain AFU errors */
> -
> -/* Command management definitions */
> -#define CXLFLASH_MAX_CMDS               256
> -#define CXLFLASH_MAX_CMDS_PER_LUN       CXLFLASH_MAX_CMDS
> -
> -/* RRQ for master issued cmds */
> -#define NUM_RRQ_ENTRY                   CXLFLASH_MAX_CMDS
> -
> -/* SQ for master issued cmds */
> -#define NUM_SQ_ENTRY			CXLFLASH_MAX_CMDS
> -
> -/* Hardware queue definitions */
> -#define CXLFLASH_DEF_HWQS		1
> -#define CXLFLASH_MAX_HWQS		8
> -#define PRIMARY_HWQ			0
> -
> -
> -static inline void check_sizes(void)
> -{
> -	BUILD_BUG_ON_NOT_POWER_OF_2(CXLFLASH_NUM_FC_PORTS_PER_BANK);
> -	BUILD_BUG_ON_NOT_POWER_OF_2(CXLFLASH_MAX_CMDS);
> -}
> -
> -/* AFU defines a fixed size of 4K for command buffers (borrow 4K page define) */
> -#define CMD_BUFSIZE     SIZE_4K
> -
> -enum cxlflash_lr_state {
> -	LINK_RESET_INVALID,
> -	LINK_RESET_REQUIRED,
> -	LINK_RESET_COMPLETE
> -};
> -
> -enum cxlflash_init_state {
> -	INIT_STATE_NONE,
> -	INIT_STATE_PCI,
> -	INIT_STATE_AFU,
> -	INIT_STATE_SCSI,
> -	INIT_STATE_CDEV
> -};
> -
> -enum cxlflash_state {
> -	STATE_PROBING,	/* Initial state during probe */
> -	STATE_PROBED,	/* Temporary state, probe completed but EEH occurred */
> -	STATE_NORMAL,	/* Normal running state, everything good */
> -	STATE_RESET,	/* Reset state, trying to reset/recover */
> -	STATE_FAILTERM	/* Failed/terminating state, error out users/threads */
> -};
> -
> -enum cxlflash_hwq_mode {
> -	HWQ_MODE_RR,	/* Roundrobin (default) */
> -	HWQ_MODE_TAG,	/* Distribute based on block MQ tag */
> -	HWQ_MODE_CPU,	/* CPU affinity */
> -	MAX_HWQ_MODE
> -};
> -
> -/*
> - * Each context has its own set of resource handles that is visible
> - * only from that context.
> - */
> -
> -struct cxlflash_cfg {
> -	struct afu *afu;
> -
> -	const struct cxlflash_backend_ops *ops;
> -	struct pci_dev *dev;
> -	struct pci_device_id *dev_id;
> -	struct Scsi_Host *host;
> -	int num_fc_ports;
> -	struct cdev cdev;
> -	struct device *chardev;
> -
> -	ulong cxlflash_regs_pci;
> -
> -	struct work_struct work_q;
> -	enum cxlflash_init_state init_state;
> -	enum cxlflash_lr_state lr_state;
> -	int lr_port;
> -	atomic_t scan_host_needed;
> -
> -	void *afu_cookie;
> -
> -	atomic_t recovery_threads;
> -	struct mutex ctx_recovery_mutex;
> -	struct mutex ctx_tbl_list_mutex;
> -	struct rw_semaphore ioctl_rwsem;
> -	struct ctx_info *ctx_tbl[MAX_CONTEXT];
> -	struct list_head ctx_err_recovery; /* contexts w/ recovery pending */
> -	struct file_operations cxl_fops;
> -
> -	/* Parameters that are LUN table related */
> -	int last_lun_index[MAX_FC_PORTS];
> -	int promote_lun_index;
> -	struct list_head lluns; /* list of llun_info structs */
> -
> -	wait_queue_head_t tmf_waitq;
> -	spinlock_t tmf_slock;
> -	bool tmf_active;
> -	bool ws_unmap;		/* Write-same unmap supported */
> -	wait_queue_head_t reset_waitq;
> -	enum cxlflash_state state;
> -	async_cookie_t async_reset_cookie;
> -};
> -
> -struct afu_cmd {
> -	struct sisl_ioarcb rcb;	/* IOARCB (cache line aligned) */
> -	struct sisl_ioasa sa;	/* IOASA must follow IOARCB */
> -	struct afu *parent;
> -	struct scsi_cmnd *scp;
> -	struct completion cevent;
> -	struct list_head queue;
> -	u32 hwq_index;
> -
> -	u8 cmd_tmf:1,
> -	   cmd_aborted:1;
> -
> -	struct list_head list;	/* Pending commands link */
> -
> -	/* As per the SISLITE spec the IOARCB EA has to be 16-byte aligned.
> -	 * However for performance reasons the IOARCB/IOASA should be
> -	 * cache line aligned.
> -	 */
> -} __aligned(cache_line_size());
> -
> -static inline struct afu_cmd *sc_to_afuc(struct scsi_cmnd *sc)
> -{
> -	return PTR_ALIGN(scsi_cmd_priv(sc), __alignof__(struct afu_cmd));
> -}
> -
> -static inline struct afu_cmd *sc_to_afuci(struct scsi_cmnd *sc)
> -{
> -	struct afu_cmd *afuc = sc_to_afuc(sc);
> -
> -	INIT_LIST_HEAD(&afuc->queue);
> -	return afuc;
> -}
> -
> -static inline struct afu_cmd *sc_to_afucz(struct scsi_cmnd *sc)
> -{
> -	struct afu_cmd *afuc = sc_to_afuc(sc);
> -
> -	memset(afuc, 0, sizeof(*afuc));
> -	return sc_to_afuci(sc);
> -}
> -
> -struct hwq {
> -	/* Stuff requiring alignment go first. */
> -	struct sisl_ioarcb sq[NUM_SQ_ENTRY];		/* 16K SQ */
> -	u64 rrq_entry[NUM_RRQ_ENTRY];			/* 2K RRQ */
> -
> -	/* Beware of alignment till here. Preferably introduce new
> -	 * fields after this point
> -	 */
> -	struct afu *afu;
> -	void *ctx_cookie;
> -	struct sisl_host_map __iomem *host_map;		/* MC host map */
> -	struct sisl_ctrl_map __iomem *ctrl_map;		/* MC control map */
> -	ctx_hndl_t ctx_hndl;	/* master's context handle */
> -	u32 index;		/* Index of this hwq */
> -	int num_irqs;		/* Number of interrupts requested for context */
> -	struct list_head pending_cmds;	/* Commands pending completion */
> -
> -	atomic_t hsq_credits;
> -	spinlock_t hsq_slock;	/* Hardware send queue lock */
> -	struct sisl_ioarcb *hsq_start;
> -	struct sisl_ioarcb *hsq_end;
> -	struct sisl_ioarcb *hsq_curr;
> -	spinlock_t hrrq_slock;
> -	u64 *hrrq_start;
> -	u64 *hrrq_end;
> -	u64 *hrrq_curr;
> -	bool toggle;
> -	bool hrrq_online;
> -
> -	s64 room;
> -
> -	struct irq_poll irqpoll;
> -} __aligned(cache_line_size());
> -
> -struct afu {
> -	struct hwq hwqs[CXLFLASH_MAX_HWQS];
> -	int (*send_cmd)(struct afu *afu, struct afu_cmd *cmd);
> -	int (*context_reset)(struct hwq *hwq);
> -
> -	/* AFU HW */
> -	struct cxlflash_afu_map __iomem *afu_map;	/* entire MMIO map */
> -
> -	atomic_t cmds_active;	/* Number of currently active AFU commands */
> -	struct mutex sync_active;	/* Mutex to serialize AFU commands */
> -	u64 hb;
> -	u32 internal_lun;	/* User-desired LUN mode for this AFU */
> -
> -	u32 num_hwqs;		/* Number of hardware queues */
> -	u32 desired_hwqs;	/* Desired h/w queues, effective on AFU reset */
> -	enum cxlflash_hwq_mode hwq_mode; /* Steering mode for h/w queues */
> -	u32 hwq_rr_count;	/* Count to distribute traffic for roundrobin */
> -
> -	char version[16];
> -	u64 interface_version;
> -
> -	u32 irqpoll_weight;
> -	struct cxlflash_cfg *parent; /* Pointer back to parent cxlflash_cfg */
> -};
> -
> -static inline struct hwq *get_hwq(struct afu *afu, u32 index)
> -{
> -	WARN_ON(index >= CXLFLASH_MAX_HWQS);
> -
> -	return &afu->hwqs[index];
> -}
> -
> -static inline bool afu_is_irqpoll_enabled(struct afu *afu)
> -{
> -	return !!afu->irqpoll_weight;
> -}
> -
> -static inline bool afu_has_cap(struct afu *afu, u64 cap)
> -{
> -	u64 afu_cap = afu->interface_version >> SISL_INTVER_CAP_SHIFT;
> -
> -	return afu_cap & cap;
> -}
> -
> -static inline bool afu_is_ocxl_lisn(struct afu *afu)
> -{
> -	return afu_has_cap(afu, SISL_INTVER_CAP_OCXL_LISN);
> -}
> -
> -static inline bool afu_is_afu_debug(struct afu *afu)
> -{
> -	return afu_has_cap(afu, SISL_INTVER_CAP_AFU_DEBUG);
> -}
> -
> -static inline bool afu_is_lun_provision(struct afu *afu)
> -{
> -	return afu_has_cap(afu, SISL_INTVER_CAP_LUN_PROVISION);
> -}
> -
> -static inline bool afu_is_sq_cmd_mode(struct afu *afu)
> -{
> -	return afu_has_cap(afu, SISL_INTVER_CAP_SQ_CMD_MODE);
> -}
> -
> -static inline bool afu_is_ioarrin_cmd_mode(struct afu *afu)
> -{
> -	return afu_has_cap(afu, SISL_INTVER_CAP_IOARRIN_CMD_MODE);
> -}
> -
> -static inline u64 lun_to_lunid(u64 lun)
> -{
> -	__be64 lun_id;
> -
> -	int_to_scsilun(lun, (struct scsi_lun *)&lun_id);
> -	return be64_to_cpu(lun_id);
> -}
> -
> -static inline struct fc_port_bank __iomem *get_fc_port_bank(
> -					    struct cxlflash_cfg *cfg, int i)
> -{
> -	struct afu *afu = cfg->afu;
> -
> -	return &afu->afu_map->global.bank[CHAN2PORTBANK(i)];
> -}
> -
> -static inline __be64 __iomem *get_fc_port_regs(struct cxlflash_cfg *cfg, int i)
> -{
> -	struct fc_port_bank __iomem *fcpb = get_fc_port_bank(cfg, i);
> -
> -	return &fcpb->fc_port_regs[CHAN2BANKPORT(i)][0];
> -}
> -
> -static inline __be64 __iomem *get_fc_port_luns(struct cxlflash_cfg *cfg, int i)
> -{
> -	struct fc_port_bank __iomem *fcpb = get_fc_port_bank(cfg, i);
> -
> -	return &fcpb->fc_port_luns[CHAN2BANKPORT(i)][0];
> -}
> -
> -int cxlflash_afu_sync(struct afu *afu, ctx_hndl_t c, res_hndl_t r, u8 mode);
> -void cxlflash_list_init(void);
> -void cxlflash_term_global_luns(void);
> -void cxlflash_free_errpage(void);
> -int cxlflash_ioctl(struct scsi_device *sdev, unsigned int cmd,
> -		   void __user *arg);
> -void cxlflash_stop_term_user_contexts(struct cxlflash_cfg *cfg);
> -int cxlflash_mark_contexts_error(struct cxlflash_cfg *cfg);
> -void cxlflash_term_local_luns(struct cxlflash_cfg *cfg);
> -void cxlflash_restore_luntable(struct cxlflash_cfg *cfg);
> -
> -#endif /* ifndef _CXLFLASH_COMMON_H */
> diff --git a/drivers/scsi/cxlflash/cxl_hw.c b/drivers/scsi/cxlflash/cxl_hw.c
> deleted file mode 100644
> index b814130f3f5c..000000000000
> --- a/drivers/scsi/cxlflash/cxl_hw.c
> +++ /dev/null
> @@ -1,177 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * CXL Flash Device Driver
> - *
> - * Written by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>, IBM Corporation
> - *             Uma Krishnan <ukrishn@linux.vnet.ibm.com>, IBM Corporation
> - *
> - * Copyright (C) 2018 IBM Corporation
> - */
> -
> -#include <misc/cxl.h>
> -
> -#include "backend.h"
> -
> -/*
> - * The following routines map the cxlflash backend operations to existing CXL
> - * kernel API function and are largely simple shims that provide an abstraction
> - * for converting generic context and AFU cookies into cxl_context or cxl_afu
> - * pointers.
> - */
> -
> -static void __iomem *cxlflash_psa_map(void *ctx_cookie)
> -{
> -	return cxl_psa_map(ctx_cookie);
> -}
> -
> -static void cxlflash_psa_unmap(void __iomem *addr)
> -{
> -	cxl_psa_unmap(addr);
> -}
> -
> -static int cxlflash_process_element(void *ctx_cookie)
> -{
> -	return cxl_process_element(ctx_cookie);
> -}
> -
> -static int cxlflash_map_afu_irq(void *ctx_cookie, int num,
> -				irq_handler_t handler, void *cookie, char *name)
> -{
> -	return cxl_map_afu_irq(ctx_cookie, num, handler, cookie, name);
> -}
> -
> -static void cxlflash_unmap_afu_irq(void *ctx_cookie, int num, void *cookie)
> -{
> -	cxl_unmap_afu_irq(ctx_cookie, num, cookie);
> -}
> -
> -static u64 cxlflash_get_irq_objhndl(void *ctx_cookie, int irq)
> -{
> -	/* Dummy fop for cxl */
> -	return 0;
> -}
> -
> -static int cxlflash_start_context(void *ctx_cookie)
> -{
> -	return cxl_start_context(ctx_cookie, 0, NULL);
> -}
> -
> -static int cxlflash_stop_context(void *ctx_cookie)
> -{
> -	return cxl_stop_context(ctx_cookie);
> -}
> -
> -static int cxlflash_afu_reset(void *ctx_cookie)
> -{
> -	return cxl_afu_reset(ctx_cookie);
> -}
> -
> -static void cxlflash_set_master(void *ctx_cookie)
> -{
> -	cxl_set_master(ctx_cookie);
> -}
> -
> -static void *cxlflash_get_context(struct pci_dev *dev, void *afu_cookie)
> -{
> -	return cxl_get_context(dev);
> -}
> -
> -static void *cxlflash_dev_context_init(struct pci_dev *dev, void *afu_cookie)
> -{
> -	return cxl_dev_context_init(dev);
> -}
> -
> -static int cxlflash_release_context(void *ctx_cookie)
> -{
> -	return cxl_release_context(ctx_cookie);
> -}
> -
> -static void cxlflash_perst_reloads_same_image(void *afu_cookie, bool image)
> -{
> -	cxl_perst_reloads_same_image(afu_cookie, image);
> -}
> -
> -static ssize_t cxlflash_read_adapter_vpd(struct pci_dev *dev,
> -					 void *buf, size_t count)
> -{
> -	return cxl_read_adapter_vpd(dev, buf, count);
> -}
> -
> -static int cxlflash_allocate_afu_irqs(void *ctx_cookie, int num)
> -{
> -	return cxl_allocate_afu_irqs(ctx_cookie, num);
> -}
> -
> -static void cxlflash_free_afu_irqs(void *ctx_cookie)
> -{
> -	cxl_free_afu_irqs(ctx_cookie);
> -}
> -
> -static void *cxlflash_create_afu(struct pci_dev *dev)
> -{
> -	return cxl_pci_to_afu(dev);
> -}
> -
> -static void cxlflash_destroy_afu(void *afu)
> -{
> -	/* Dummy fop for cxl */
> -}
> -
> -static struct file *cxlflash_get_fd(void *ctx_cookie,
> -				    struct file_operations *fops, int *fd)
> -{
> -	return cxl_get_fd(ctx_cookie, fops, fd);
> -}
> -
> -static void *cxlflash_fops_get_context(struct file *file)
> -{
> -	return cxl_fops_get_context(file);
> -}
> -
> -static int cxlflash_start_work(void *ctx_cookie, u64 irqs)
> -{
> -	struct cxl_ioctl_start_work work = { 0 };
> -
> -	work.num_interrupts = irqs;
> -	work.flags = CXL_START_WORK_NUM_IRQS;
> -
> -	return cxl_start_work(ctx_cookie, &work);
> -}
> -
> -static int cxlflash_fd_mmap(struct file *file, struct vm_area_struct *vm)
> -{
> -	return cxl_fd_mmap(file, vm);
> -}
> -
> -static int cxlflash_fd_release(struct inode *inode, struct file *file)
> -{
> -	return cxl_fd_release(inode, file);
> -}
> -
> -const struct cxlflash_backend_ops cxlflash_cxl_ops = {
> -	.module			= THIS_MODULE,
> -	.psa_map		= cxlflash_psa_map,
> -	.psa_unmap		= cxlflash_psa_unmap,
> -	.process_element	= cxlflash_process_element,
> -	.map_afu_irq		= cxlflash_map_afu_irq,
> -	.unmap_afu_irq		= cxlflash_unmap_afu_irq,
> -	.get_irq_objhndl	= cxlflash_get_irq_objhndl,
> -	.start_context		= cxlflash_start_context,
> -	.stop_context		= cxlflash_stop_context,
> -	.afu_reset		= cxlflash_afu_reset,
> -	.set_master		= cxlflash_set_master,
> -	.get_context		= cxlflash_get_context,
> -	.dev_context_init	= cxlflash_dev_context_init,
> -	.release_context	= cxlflash_release_context,
> -	.perst_reloads_same_image = cxlflash_perst_reloads_same_image,
> -	.read_adapter_vpd	= cxlflash_read_adapter_vpd,
> -	.allocate_afu_irqs	= cxlflash_allocate_afu_irqs,
> -	.free_afu_irqs		= cxlflash_free_afu_irqs,
> -	.create_afu		= cxlflash_create_afu,
> -	.destroy_afu		= cxlflash_destroy_afu,
> -	.get_fd			= cxlflash_get_fd,
> -	.fops_get_context	= cxlflash_fops_get_context,
> -	.start_work		= cxlflash_start_work,
> -	.fd_mmap		= cxlflash_fd_mmap,
> -	.fd_release		= cxlflash_fd_release,
> -};
> diff --git a/drivers/scsi/cxlflash/lunmgt.c b/drivers/scsi/cxlflash/lunmgt.c
> deleted file mode 100644
> index 962c797fda07..000000000000
> --- a/drivers/scsi/cxlflash/lunmgt.c
> +++ /dev/null
> @@ -1,278 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * CXL Flash Device Driver
> - *
> - * Written by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>, IBM Corporation
> - *             Matthew R. Ochs <mrochs@linux.vnet.ibm.com>, IBM Corporation
> - *
> - * Copyright (C) 2015 IBM Corporation
> - */
> -
> -#include <linux/unaligned.h>
> -
> -#include <linux/interrupt.h>
> -#include <linux/pci.h>
> -
> -#include <scsi/scsi_host.h>
> -#include <uapi/scsi/cxlflash_ioctl.h>
> -
> -#include "sislite.h"
> -#include "common.h"
> -#include "vlun.h"
> -#include "superpipe.h"
> -
> -/**
> - * create_local() - allocate and initialize a local LUN information structure
> - * @sdev:	SCSI device associated with LUN.
> - * @wwid:	World Wide Node Name for LUN.
> - *
> - * Return: Allocated local llun_info structure on success, NULL on failure
> - */
> -static struct llun_info *create_local(struct scsi_device *sdev, u8 *wwid)
> -{
> -	struct cxlflash_cfg *cfg = shost_priv(sdev->host);
> -	struct device *dev = &cfg->dev->dev;
> -	struct llun_info *lli = NULL;
> -
> -	lli = kzalloc(sizeof(*lli), GFP_KERNEL);
> -	if (unlikely(!lli)) {
> -		dev_err(dev, "%s: could not allocate lli\n", __func__);
> -		goto out;
> -	}
> -
> -	lli->sdev = sdev;
> -	lli->host_no = sdev->host->host_no;
> -	lli->in_table = false;
> -
> -	memcpy(lli->wwid, wwid, DK_CXLFLASH_MANAGE_LUN_WWID_LEN);
> -out:
> -	return lli;
> -}
> -
> -/**
> - * create_global() - allocate and initialize a global LUN information structure
> - * @sdev:	SCSI device associated with LUN.
> - * @wwid:	World Wide Node Name for LUN.
> - *
> - * Return: Allocated global glun_info structure on success, NULL on failure
> - */
> -static struct glun_info *create_global(struct scsi_device *sdev, u8 *wwid)
> -{
> -	struct cxlflash_cfg *cfg = shost_priv(sdev->host);
> -	struct device *dev = &cfg->dev->dev;
> -	struct glun_info *gli = NULL;
> -
> -	gli = kzalloc(sizeof(*gli), GFP_KERNEL);
> -	if (unlikely(!gli)) {
> -		dev_err(dev, "%s: could not allocate gli\n", __func__);
> -		goto out;
> -	}
> -
> -	mutex_init(&gli->mutex);
> -	memcpy(gli->wwid, wwid, DK_CXLFLASH_MANAGE_LUN_WWID_LEN);
> -out:
> -	return gli;
> -}
> -
> -/**
> - * lookup_local() - find a local LUN information structure by WWID
> - * @cfg:	Internal structure associated with the host.
> - * @wwid:	WWID associated with LUN.
> - *
> - * Return: Found local lun_info structure on success, NULL on failure
> - */
> -static struct llun_info *lookup_local(struct cxlflash_cfg *cfg, u8 *wwid)
> -{
> -	struct llun_info *lli, *temp;
> -
> -	list_for_each_entry_safe(lli, temp, &cfg->lluns, list)
> -		if (!memcmp(lli->wwid, wwid, DK_CXLFLASH_MANAGE_LUN_WWID_LEN))
> -			return lli;
> -
> -	return NULL;
> -}
> -
> -/**
> - * lookup_global() - find a global LUN information structure by WWID
> - * @wwid:	WWID associated with LUN.
> - *
> - * Return: Found global lun_info structure on success, NULL on failure
> - */
> -static struct glun_info *lookup_global(u8 *wwid)
> -{
> -	struct glun_info *gli, *temp;
> -
> -	list_for_each_entry_safe(gli, temp, &global.gluns, list)
> -		if (!memcmp(gli->wwid, wwid, DK_CXLFLASH_MANAGE_LUN_WWID_LEN))
> -			return gli;
> -
> -	return NULL;
> -}
> -
> -/**
> - * find_and_create_lun() - find or create a local LUN information structure
> - * @sdev:	SCSI device associated with LUN.
> - * @wwid:	WWID associated with LUN.
> - *
> - * The LUN is kept both in a local list (per adapter) and in a global list
> - * (across all adapters). Certain attributes of the LUN are local to the
> - * adapter (such as index, port selection mask, etc.).
> - *
> - * The block allocation map is shared across all adapters (i.e. associated
> - * wih the global list). Since different attributes are associated with
> - * the per adapter and global entries, allocate two separate structures for each
> - * LUN (one local, one global).
> - *
> - * Keep a pointer back from the local to the global entry.
> - *
> - * This routine assumes the caller holds the global mutex.
> - *
> - * Return: Found/Allocated local lun_info structure on success, NULL on failure
> - */
> -static struct llun_info *find_and_create_lun(struct scsi_device *sdev, u8 *wwid)
> -{
> -	struct cxlflash_cfg *cfg = shost_priv(sdev->host);
> -	struct device *dev = &cfg->dev->dev;
> -	struct llun_info *lli = NULL;
> -	struct glun_info *gli = NULL;
> -
> -	if (unlikely(!wwid))
> -		goto out;
> -
> -	lli = lookup_local(cfg, wwid);
> -	if (lli)
> -		goto out;
> -
> -	lli = create_local(sdev, wwid);
> -	if (unlikely(!lli))
> -		goto out;
> -
> -	gli = lookup_global(wwid);
> -	if (gli) {
> -		lli->parent = gli;
> -		list_add(&lli->list, &cfg->lluns);
> -		goto out;
> -	}
> -
> -	gli = create_global(sdev, wwid);
> -	if (unlikely(!gli)) {
> -		kfree(lli);
> -		lli = NULL;
> -		goto out;
> -	}
> -
> -	lli->parent = gli;
> -	list_add(&lli->list, &cfg->lluns);
> -
> -	list_add(&gli->list, &global.gluns);
> -
> -out:
> -	dev_dbg(dev, "%s: returning lli=%p, gli=%p\n", __func__, lli, gli);
> -	return lli;
> -}
> -
> -/**
> - * cxlflash_term_local_luns() - Delete all entries from local LUN list, free.
> - * @cfg:	Internal structure associated with the host.
> - */
> -void cxlflash_term_local_luns(struct cxlflash_cfg *cfg)
> -{
> -	struct llun_info *lli, *temp;
> -
> -	mutex_lock(&global.mutex);
> -	list_for_each_entry_safe(lli, temp, &cfg->lluns, list) {
> -		list_del(&lli->list);
> -		kfree(lli);
> -	}
> -	mutex_unlock(&global.mutex);
> -}
> -
> -/**
> - * cxlflash_list_init() - initializes the global LUN list
> - */
> -void cxlflash_list_init(void)
> -{
> -	INIT_LIST_HEAD(&global.gluns);
> -	mutex_init(&global.mutex);
> -	global.err_page = NULL;
> -}
> -
> -/**
> - * cxlflash_term_global_luns() - frees resources associated with global LUN list
> - */
> -void cxlflash_term_global_luns(void)
> -{
> -	struct glun_info *gli, *temp;
> -
> -	mutex_lock(&global.mutex);
> -	list_for_each_entry_safe(gli, temp, &global.gluns, list) {
> -		list_del(&gli->list);
> -		cxlflash_ba_terminate(&gli->blka.ba_lun);
> -		kfree(gli);
> -	}
> -	mutex_unlock(&global.mutex);
> -}
> -
> -/**
> - * cxlflash_manage_lun() - handles LUN management activities
> - * @sdev:	SCSI device associated with LUN.
> - * @arg:	Manage ioctl data structure.
> - *
> - * This routine is used to notify the driver about a LUN's WWID and associate
> - * SCSI devices (sdev) with a global LUN instance. Additionally it serves to
> - * change a LUN's operating mode: legacy or superpipe.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -int cxlflash_manage_lun(struct scsi_device *sdev, void *arg)
> -{
> -	struct dk_cxlflash_manage_lun *manage = arg;
> -	struct cxlflash_cfg *cfg = shost_priv(sdev->host);
> -	struct device *dev = &cfg->dev->dev;
> -	struct llun_info *lli = NULL;
> -	int rc = 0;
> -	u64 flags = manage->hdr.flags;
> -	u32 chan = sdev->channel;
> -
> -	mutex_lock(&global.mutex);
> -	lli = find_and_create_lun(sdev, manage->wwid);
> -	dev_dbg(dev, "%s: WWID=%016llx%016llx, flags=%016llx lli=%p\n",
> -		__func__, get_unaligned_be64(&manage->wwid[0]),
> -		get_unaligned_be64(&manage->wwid[8]), manage->hdr.flags, lli);
> -	if (unlikely(!lli)) {
> -		rc = -ENOMEM;
> -		goto out;
> -	}
> -
> -	if (flags & DK_CXLFLASH_MANAGE_LUN_ENABLE_SUPERPIPE) {
> -		/*
> -		 * Update port selection mask based upon channel, store off LUN
> -		 * in unpacked, AFU-friendly format, and hang LUN reference in
> -		 * the sdev.
> -		 */
> -		lli->port_sel |= CHAN2PORTMASK(chan);
> -		lli->lun_id[chan] = lun_to_lunid(sdev->lun);
> -		sdev->hostdata = lli;
> -	} else if (flags & DK_CXLFLASH_MANAGE_LUN_DISABLE_SUPERPIPE) {
> -		if (lli->parent->mode != MODE_NONE)
> -			rc = -EBUSY;
> -		else {
> -			/*
> -			 * Clean up local LUN for this port and reset table
> -			 * tracking when no more references exist.
> -			 */
> -			sdev->hostdata = NULL;
> -			lli->port_sel &= ~CHAN2PORTMASK(chan);
> -			if (lli->port_sel == 0U)
> -				lli->in_table = false;
> -		}
> -	}
> -
> -	dev_dbg(dev, "%s: port_sel=%08x chan=%u lun_id=%016llx\n",
> -		__func__, lli->port_sel, chan, lli->lun_id[chan]);
> -
> -out:
> -	mutex_unlock(&global.mutex);
> -	dev_dbg(dev, "%s: returning rc=%d\n", __func__, rc);
> -	return rc;
> -}
> diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
> deleted file mode 100644
> index ae626e389c8b..000000000000
> --- a/drivers/scsi/cxlflash/main.c
> +++ /dev/null
> @@ -1,3970 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * CXL Flash Device Driver
> - *
> - * Written by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>, IBM Corporation
> - *             Matthew R. Ochs <mrochs@linux.vnet.ibm.com>, IBM Corporation
> - *
> - * Copyright (C) 2015 IBM Corporation
> - */
> -
> -#include <linux/delay.h>
> -#include <linux/list.h>
> -#include <linux/module.h>
> -#include <linux/pci.h>
> -
> -#include <linux/unaligned.h>
> -
> -#include <scsi/scsi_cmnd.h>
> -#include <scsi/scsi_host.h>
> -#include <uapi/scsi/cxlflash_ioctl.h>
> -
> -#include "main.h"
> -#include "sislite.h"
> -#include "common.h"
> -
> -MODULE_DESCRIPTION(CXLFLASH_ADAPTER_NAME);
> -MODULE_AUTHOR("Manoj N. Kumar <manoj@linux.vnet.ibm.com>");
> -MODULE_AUTHOR("Matthew R. Ochs <mrochs@linux.vnet.ibm.com>");
> -MODULE_LICENSE("GPL");
> -
> -static char *cxlflash_devnode(const struct device *dev, umode_t *mode);
> -static const struct class cxlflash_class = {
> -	.name = "cxlflash",
> -	.devnode = cxlflash_devnode,
> -};
> -
> -static u32 cxlflash_major;
> -static DECLARE_BITMAP(cxlflash_minor, CXLFLASH_MAX_ADAPTERS);
> -
> -/**
> - * process_cmd_err() - command error handler
> - * @cmd:	AFU command that experienced the error.
> - * @scp:	SCSI command associated with the AFU command in error.
> - *
> - * Translates error bits from AFU command to SCSI command results.
> - */
> -static void process_cmd_err(struct afu_cmd *cmd, struct scsi_cmnd *scp)
> -{
> -	struct afu *afu = cmd->parent;
> -	struct cxlflash_cfg *cfg = afu->parent;
> -	struct device *dev = &cfg->dev->dev;
> -	struct sisl_ioasa *ioasa;
> -	u32 resid;
> -
> -	ioasa = &(cmd->sa);
> -
> -	if (ioasa->rc.flags & SISL_RC_FLAGS_UNDERRUN) {
> -		resid = ioasa->resid;
> -		scsi_set_resid(scp, resid);
> -		dev_dbg(dev, "%s: cmd underrun cmd = %p scp = %p, resid = %d\n",
> -			__func__, cmd, scp, resid);
> -	}
> -
> -	if (ioasa->rc.flags & SISL_RC_FLAGS_OVERRUN) {
> -		dev_dbg(dev, "%s: cmd underrun cmd = %p scp = %p\n",
> -			__func__, cmd, scp);
> -		scp->result = (DID_ERROR << 16);
> -	}
> -
> -	dev_dbg(dev, "%s: cmd failed afu_rc=%02x scsi_rc=%02x fc_rc=%02x "
> -		"afu_extra=%02x scsi_extra=%02x fc_extra=%02x\n", __func__,
> -		ioasa->rc.afu_rc, ioasa->rc.scsi_rc, ioasa->rc.fc_rc,
> -		ioasa->afu_extra, ioasa->scsi_extra, ioasa->fc_extra);
> -
> -	if (ioasa->rc.scsi_rc) {
> -		/* We have a SCSI status */
> -		if (ioasa->rc.flags & SISL_RC_FLAGS_SENSE_VALID) {
> -			memcpy(scp->sense_buffer, ioasa->sense_data,
> -			       SISL_SENSE_DATA_LEN);
> -			scp->result = ioasa->rc.scsi_rc;
> -		} else
> -			scp->result = ioasa->rc.scsi_rc | (DID_ERROR << 16);
> -	}
> -
> -	/*
> -	 * We encountered an error. Set scp->result based on nature
> -	 * of error.
> -	 */
> -	if (ioasa->rc.fc_rc) {
> -		/* We have an FC status */
> -		switch (ioasa->rc.fc_rc) {
> -		case SISL_FC_RC_LINKDOWN:
> -			scp->result = (DID_REQUEUE << 16);
> -			break;
> -		case SISL_FC_RC_RESID:
> -			/* This indicates an FCP resid underrun */
> -			if (!(ioasa->rc.flags & SISL_RC_FLAGS_OVERRUN)) {
> -				/* If the SISL_RC_FLAGS_OVERRUN flag was set,
> -				 * then we will handle this error else where.
> -				 * If not then we must handle it here.
> -				 * This is probably an AFU bug.
> -				 */
> -				scp->result = (DID_ERROR << 16);
> -			}
> -			break;
> -		case SISL_FC_RC_RESIDERR:
> -			/* Resid mismatch between adapter and device */
> -		case SISL_FC_RC_TGTABORT:
> -		case SISL_FC_RC_ABORTOK:
> -		case SISL_FC_RC_ABORTFAIL:
> -		case SISL_FC_RC_NOLOGI:
> -		case SISL_FC_RC_ABORTPEND:
> -		case SISL_FC_RC_WRABORTPEND:
> -		case SISL_FC_RC_NOEXP:
> -		case SISL_FC_RC_INUSE:
> -			scp->result = (DID_ERROR << 16);
> -			break;
> -		}
> -	}
> -
> -	if (ioasa->rc.afu_rc) {
> -		/* We have an AFU error */
> -		switch (ioasa->rc.afu_rc) {
> -		case SISL_AFU_RC_NO_CHANNELS:
> -			scp->result = (DID_NO_CONNECT << 16);
> -			break;
> -		case SISL_AFU_RC_DATA_DMA_ERR:
> -			switch (ioasa->afu_extra) {
> -			case SISL_AFU_DMA_ERR_PAGE_IN:
> -				/* Retry */
> -				scp->result = (DID_IMM_RETRY << 16);
> -				break;
> -			case SISL_AFU_DMA_ERR_INVALID_EA:
> -			default:
> -				scp->result = (DID_ERROR << 16);
> -			}
> -			break;
> -		case SISL_AFU_RC_OUT_OF_DATA_BUFS:
> -			/* Retry */
> -			scp->result = (DID_ERROR << 16);
> -			break;
> -		default:
> -			scp->result = (DID_ERROR << 16);
> -		}
> -	}
> -}
> -
> -/**
> - * cmd_complete() - command completion handler
> - * @cmd:	AFU command that has completed.
> - *
> - * For SCSI commands this routine prepares and submits commands that have
> - * either completed or timed out to the SCSI stack. For internal commands
> - * (TMF or AFU), this routine simply notifies the originator that the
> - * command has completed.
> - */
> -static void cmd_complete(struct afu_cmd *cmd)
> -{
> -	struct scsi_cmnd *scp;
> -	ulong lock_flags;
> -	struct afu *afu = cmd->parent;
> -	struct cxlflash_cfg *cfg = afu->parent;
> -	struct device *dev = &cfg->dev->dev;
> -	struct hwq *hwq = get_hwq(afu, cmd->hwq_index);
> -
> -	spin_lock_irqsave(&hwq->hsq_slock, lock_flags);
> -	list_del(&cmd->list);
> -	spin_unlock_irqrestore(&hwq->hsq_slock, lock_flags);
> -
> -	if (cmd->scp) {
> -		scp = cmd->scp;
> -		if (unlikely(cmd->sa.ioasc))
> -			process_cmd_err(cmd, scp);
> -		else
> -			scp->result = (DID_OK << 16);
> -
> -		dev_dbg_ratelimited(dev, "%s:scp=%p result=%08x ioasc=%08x\n",
> -				    __func__, scp, scp->result, cmd->sa.ioasc);
> -		scsi_done(scp);
> -	} else if (cmd->cmd_tmf) {
> -		spin_lock_irqsave(&cfg->tmf_slock, lock_flags);
> -		cfg->tmf_active = false;
> -		wake_up_all_locked(&cfg->tmf_waitq);
> -		spin_unlock_irqrestore(&cfg->tmf_slock, lock_flags);
> -	} else
> -		complete(&cmd->cevent);
> -}
> -
> -/**
> - * flush_pending_cmds() - flush all pending commands on this hardware queue
> - * @hwq:	Hardware queue to flush.
> - *
> - * The hardware send queue lock associated with this hardware queue must be
> - * held when calling this routine.
> - */
> -static void flush_pending_cmds(struct hwq *hwq)
> -{
> -	struct cxlflash_cfg *cfg = hwq->afu->parent;
> -	struct afu_cmd *cmd, *tmp;
> -	struct scsi_cmnd *scp;
> -	ulong lock_flags;
> -
> -	list_for_each_entry_safe(cmd, tmp, &hwq->pending_cmds, list) {
> -		/* Bypass command when on a doneq, cmd_complete() will handle */
> -		if (!list_empty(&cmd->queue))
> -			continue;
> -
> -		list_del(&cmd->list);
> -
> -		if (cmd->scp) {
> -			scp = cmd->scp;
> -			scp->result = (DID_IMM_RETRY << 16);
> -			scsi_done(scp);
> -		} else {
> -			cmd->cmd_aborted = true;
> -
> -			if (cmd->cmd_tmf) {
> -				spin_lock_irqsave(&cfg->tmf_slock, lock_flags);
> -				cfg->tmf_active = false;
> -				wake_up_all_locked(&cfg->tmf_waitq);
> -				spin_unlock_irqrestore(&cfg->tmf_slock,
> -						       lock_flags);
> -			} else
> -				complete(&cmd->cevent);
> -		}
> -	}
> -}
> -
> -/**
> - * context_reset() - reset context via specified register
> - * @hwq:	Hardware queue owning the context to be reset.
> - * @reset_reg:	MMIO register to perform reset.
> - *
> - * When the reset is successful, the SISLite specification guarantees that
> - * the AFU has aborted all currently pending I/O. Accordingly, these commands
> - * must be flushed.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int context_reset(struct hwq *hwq, __be64 __iomem *reset_reg)
> -{
> -	struct cxlflash_cfg *cfg = hwq->afu->parent;
> -	struct device *dev = &cfg->dev->dev;
> -	int rc = -ETIMEDOUT;
> -	int nretry = 0;
> -	u64 val = 0x1;
> -	ulong lock_flags;
> -
> -	dev_dbg(dev, "%s: hwq=%p\n", __func__, hwq);
> -
> -	spin_lock_irqsave(&hwq->hsq_slock, lock_flags);
> -
> -	writeq_be(val, reset_reg);
> -	do {
> -		val = readq_be(reset_reg);
> -		if ((val & 0x1) == 0x0) {
> -			rc = 0;
> -			break;
> -		}
> -
> -		/* Double delay each time */
> -		udelay(1 << nretry);
> -	} while (nretry++ < MC_ROOM_RETRY_CNT);
> -
> -	if (!rc)
> -		flush_pending_cmds(hwq);
> -
> -	spin_unlock_irqrestore(&hwq->hsq_slock, lock_flags);
> -
> -	dev_dbg(dev, "%s: returning rc=%d, val=%016llx nretry=%d\n",
> -		__func__, rc, val, nretry);
> -	return rc;
> -}
> -
> -/**
> - * context_reset_ioarrin() - reset context via IOARRIN register
> - * @hwq:	Hardware queue owning the context to be reset.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int context_reset_ioarrin(struct hwq *hwq)
> -{
> -	return context_reset(hwq, &hwq->host_map->ioarrin);
> -}
> -
> -/**
> - * context_reset_sq() - reset context via SQ_CONTEXT_RESET register
> - * @hwq:	Hardware queue owning the context to be reset.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int context_reset_sq(struct hwq *hwq)
> -{
> -	return context_reset(hwq, &hwq->host_map->sq_ctx_reset);
> -}
> -
> -/**
> - * send_cmd_ioarrin() - sends an AFU command via IOARRIN register
> - * @afu:	AFU associated with the host.
> - * @cmd:	AFU command to send.
> - *
> - * Return:
> - *	0 on success, SCSI_MLQUEUE_HOST_BUSY on failure
> - */
> -static int send_cmd_ioarrin(struct afu *afu, struct afu_cmd *cmd)
> -{
> -	struct cxlflash_cfg *cfg = afu->parent;
> -	struct device *dev = &cfg->dev->dev;
> -	struct hwq *hwq = get_hwq(afu, cmd->hwq_index);
> -	int rc = 0;
> -	s64 room;
> -	ulong lock_flags;
> -
> -	/*
> -	 * To avoid the performance penalty of MMIO, spread the update of
> -	 * 'room' over multiple commands.
> -	 */
> -	spin_lock_irqsave(&hwq->hsq_slock, lock_flags);
> -	if (--hwq->room < 0) {
> -		room = readq_be(&hwq->host_map->cmd_room);
> -		if (room <= 0) {
> -			dev_dbg_ratelimited(dev, "%s: no cmd_room to send "
> -					    "0x%02X, room=0x%016llX\n",
> -					    __func__, cmd->rcb.cdb[0], room);
> -			hwq->room = 0;
> -			rc = SCSI_MLQUEUE_HOST_BUSY;
> -			goto out;
> -		}
> -		hwq->room = room - 1;
> -	}
> -
> -	list_add(&cmd->list, &hwq->pending_cmds);
> -	writeq_be((u64)&cmd->rcb, &hwq->host_map->ioarrin);
> -out:
> -	spin_unlock_irqrestore(&hwq->hsq_slock, lock_flags);
> -	dev_dbg_ratelimited(dev, "%s: cmd=%p len=%u ea=%016llx rc=%d\n",
> -		__func__, cmd, cmd->rcb.data_len, cmd->rcb.data_ea, rc);
> -	return rc;
> -}
> -
> -/**
> - * send_cmd_sq() - sends an AFU command via SQ ring
> - * @afu:	AFU associated with the host.
> - * @cmd:	AFU command to send.
> - *
> - * Return:
> - *	0 on success, SCSI_MLQUEUE_HOST_BUSY on failure
> - */
> -static int send_cmd_sq(struct afu *afu, struct afu_cmd *cmd)
> -{
> -	struct cxlflash_cfg *cfg = afu->parent;
> -	struct device *dev = &cfg->dev->dev;
> -	struct hwq *hwq = get_hwq(afu, cmd->hwq_index);
> -	int rc = 0;
> -	int newval;
> -	ulong lock_flags;
> -
> -	newval = atomic_dec_if_positive(&hwq->hsq_credits);
> -	if (newval <= 0) {
> -		rc = SCSI_MLQUEUE_HOST_BUSY;
> -		goto out;
> -	}
> -
> -	cmd->rcb.ioasa = &cmd->sa;
> -
> -	spin_lock_irqsave(&hwq->hsq_slock, lock_flags);
> -
> -	*hwq->hsq_curr = cmd->rcb;
> -	if (hwq->hsq_curr < hwq->hsq_end)
> -		hwq->hsq_curr++;
> -	else
> -		hwq->hsq_curr = hwq->hsq_start;
> -
> -	list_add(&cmd->list, &hwq->pending_cmds);
> -	writeq_be((u64)hwq->hsq_curr, &hwq->host_map->sq_tail);
> -
> -	spin_unlock_irqrestore(&hwq->hsq_slock, lock_flags);
> -out:
> -	dev_dbg(dev, "%s: cmd=%p len=%u ea=%016llx ioasa=%p rc=%d curr=%p "
> -	       "head=%016llx tail=%016llx\n", __func__, cmd, cmd->rcb.data_len,
> -	       cmd->rcb.data_ea, cmd->rcb.ioasa, rc, hwq->hsq_curr,
> -	       readq_be(&hwq->host_map->sq_head),
> -	       readq_be(&hwq->host_map->sq_tail));
> -	return rc;
> -}
> -
> -/**
> - * wait_resp() - polls for a response or timeout to a sent AFU command
> - * @afu:	AFU associated with the host.
> - * @cmd:	AFU command that was sent.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int wait_resp(struct afu *afu, struct afu_cmd *cmd)
> -{
> -	struct cxlflash_cfg *cfg = afu->parent;
> -	struct device *dev = &cfg->dev->dev;
> -	int rc = 0;
> -	ulong timeout = msecs_to_jiffies(cmd->rcb.timeout * 2 * 1000);
> -
> -	timeout = wait_for_completion_timeout(&cmd->cevent, timeout);
> -	if (!timeout)
> -		rc = -ETIMEDOUT;
> -
> -	if (cmd->cmd_aborted)
> -		rc = -EAGAIN;
> -
> -	if (unlikely(cmd->sa.ioasc != 0)) {
> -		dev_err(dev, "%s: cmd %02x failed, ioasc=%08x\n",
> -			__func__, cmd->rcb.cdb[0], cmd->sa.ioasc);
> -		rc = -EIO;
> -	}
> -
> -	return rc;
> -}
> -
> -/**
> - * cmd_to_target_hwq() - selects a target hardware queue for a SCSI command
> - * @host:	SCSI host associated with device.
> - * @scp:	SCSI command to send.
> - * @afu:	SCSI command to send.
> - *
> - * Hashes a command based upon the hardware queue mode.
> - *
> - * Return: Trusted index of target hardware queue
> - */
> -static u32 cmd_to_target_hwq(struct Scsi_Host *host, struct scsi_cmnd *scp,
> -			     struct afu *afu)
> -{
> -	u32 tag;
> -	u32 hwq = 0;
> -
> -	if (afu->num_hwqs == 1)
> -		return 0;
> -
> -	switch (afu->hwq_mode) {
> -	case HWQ_MODE_RR:
> -		hwq = afu->hwq_rr_count++ % afu->num_hwqs;
> -		break;
> -	case HWQ_MODE_TAG:
> -		tag = blk_mq_unique_tag(scsi_cmd_to_rq(scp));
> -		hwq = blk_mq_unique_tag_to_hwq(tag);
> -		break;
> -	case HWQ_MODE_CPU:
> -		hwq = smp_processor_id() % afu->num_hwqs;
> -		break;
> -	default:
> -		WARN_ON_ONCE(1);
> -	}
> -
> -	return hwq;
> -}
> -
> -/**
> - * send_tmf() - sends a Task Management Function (TMF)
> - * @cfg:	Internal structure associated with the host.
> - * @sdev:	SCSI device destined for TMF.
> - * @tmfcmd:	TMF command to send.
> - *
> - * Return:
> - *	0 on success, SCSI_MLQUEUE_HOST_BUSY or -errno on failure
> - */
> -static int send_tmf(struct cxlflash_cfg *cfg, struct scsi_device *sdev,
> -		    u64 tmfcmd)
> -{
> -	struct afu *afu = cfg->afu;
> -	struct afu_cmd *cmd = NULL;
> -	struct device *dev = &cfg->dev->dev;
> -	struct hwq *hwq = get_hwq(afu, PRIMARY_HWQ);
> -	bool needs_deletion = false;
> -	char *buf = NULL;
> -	ulong lock_flags;
> -	int rc = 0;
> -	ulong to;
> -
> -	buf = kzalloc(sizeof(*cmd) + __alignof__(*cmd) - 1, GFP_KERNEL);
> -	if (unlikely(!buf)) {
> -		dev_err(dev, "%s: no memory for command\n", __func__);
> -		rc = -ENOMEM;
> -		goto out;
> -	}
> -
> -	cmd = (struct afu_cmd *)PTR_ALIGN(buf, __alignof__(*cmd));
> -	INIT_LIST_HEAD(&cmd->queue);
> -
> -	/* When Task Management Function is active do not send another */
> -	spin_lock_irqsave(&cfg->tmf_slock, lock_flags);
> -	if (cfg->tmf_active)
> -		wait_event_interruptible_lock_irq(cfg->tmf_waitq,
> -						  !cfg->tmf_active,
> -						  cfg->tmf_slock);
> -	cfg->tmf_active = true;
> -	spin_unlock_irqrestore(&cfg->tmf_slock, lock_flags);
> -
> -	cmd->parent = afu;
> -	cmd->cmd_tmf = true;
> -	cmd->hwq_index = hwq->index;
> -
> -	cmd->rcb.ctx_id = hwq->ctx_hndl;
> -	cmd->rcb.msi = SISL_MSI_RRQ_UPDATED;
> -	cmd->rcb.port_sel = CHAN2PORTMASK(sdev->channel);
> -	cmd->rcb.lun_id = lun_to_lunid(sdev->lun);
> -	cmd->rcb.req_flags = (SISL_REQ_FLAGS_PORT_LUN_ID |
> -			      SISL_REQ_FLAGS_SUP_UNDERRUN |
> -			      SISL_REQ_FLAGS_TMF_CMD);
> -	memcpy(cmd->rcb.cdb, &tmfcmd, sizeof(tmfcmd));
> -
> -	rc = afu->send_cmd(afu, cmd);
> -	if (unlikely(rc)) {
> -		spin_lock_irqsave(&cfg->tmf_slock, lock_flags);
> -		cfg->tmf_active = false;
> -		spin_unlock_irqrestore(&cfg->tmf_slock, lock_flags);
> -		goto out;
> -	}
> -
> -	spin_lock_irqsave(&cfg->tmf_slock, lock_flags);
> -	to = msecs_to_jiffies(5000);
> -	to = wait_event_interruptible_lock_irq_timeout(cfg->tmf_waitq,
> -						       !cfg->tmf_active,
> -						       cfg->tmf_slock,
> -						       to);
> -	if (!to) {
> -		dev_err(dev, "%s: TMF timed out\n", __func__);
> -		rc = -ETIMEDOUT;
> -		needs_deletion = true;
> -	} else if (cmd->cmd_aborted) {
> -		dev_err(dev, "%s: TMF aborted\n", __func__);
> -		rc = -EAGAIN;
> -	} else if (cmd->sa.ioasc) {
> -		dev_err(dev, "%s: TMF failed ioasc=%08x\n",
> -			__func__, cmd->sa.ioasc);
> -		rc = -EIO;
> -	}
> -	cfg->tmf_active = false;
> -	spin_unlock_irqrestore(&cfg->tmf_slock, lock_flags);
> -
> -	if (needs_deletion) {
> -		spin_lock_irqsave(&hwq->hsq_slock, lock_flags);
> -		list_del(&cmd->list);
> -		spin_unlock_irqrestore(&hwq->hsq_slock, lock_flags);
> -	}
> -out:
> -	kfree(buf);
> -	return rc;
> -}
> -
> -/**
> - * cxlflash_driver_info() - information handler for this host driver
> - * @host:	SCSI host associated with device.
> - *
> - * Return: A string describing the device.
> - */
> -static const char *cxlflash_driver_info(struct Scsi_Host *host)
> -{
> -	return CXLFLASH_ADAPTER_NAME;
> -}
> -
> -/**
> - * cxlflash_queuecommand() - sends a mid-layer request
> - * @host:	SCSI host associated with device.
> - * @scp:	SCSI command to send.
> - *
> - * Return: 0 on success, SCSI_MLQUEUE_HOST_BUSY on failure
> - */
> -static int cxlflash_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scp)
> -{
> -	struct cxlflash_cfg *cfg = shost_priv(host);
> -	struct afu *afu = cfg->afu;
> -	struct device *dev = &cfg->dev->dev;
> -	struct afu_cmd *cmd = sc_to_afuci(scp);
> -	struct scatterlist *sg = scsi_sglist(scp);
> -	int hwq_index = cmd_to_target_hwq(host, scp, afu);
> -	struct hwq *hwq = get_hwq(afu, hwq_index);
> -	u16 req_flags = SISL_REQ_FLAGS_SUP_UNDERRUN;
> -	ulong lock_flags;
> -	int rc = 0;
> -
> -	dev_dbg_ratelimited(dev, "%s: (scp=%p) %d/%d/%d/%llu "
> -			    "cdb=(%08x-%08x-%08x-%08x)\n",
> -			    __func__, scp, host->host_no, scp->device->channel,
> -			    scp->device->id, scp->device->lun,
> -			    get_unaligned_be32(&((u32 *)scp->cmnd)[0]),
> -			    get_unaligned_be32(&((u32 *)scp->cmnd)[1]),
> -			    get_unaligned_be32(&((u32 *)scp->cmnd)[2]),
> -			    get_unaligned_be32(&((u32 *)scp->cmnd)[3]));
> -
> -	/*
> -	 * If a Task Management Function is active, wait for it to complete
> -	 * before continuing with regular commands.
> -	 */
> -	spin_lock_irqsave(&cfg->tmf_slock, lock_flags);
> -	if (cfg->tmf_active) {
> -		spin_unlock_irqrestore(&cfg->tmf_slock, lock_flags);
> -		rc = SCSI_MLQUEUE_HOST_BUSY;
> -		goto out;
> -	}
> -	spin_unlock_irqrestore(&cfg->tmf_slock, lock_flags);
> -
> -	switch (cfg->state) {
> -	case STATE_PROBING:
> -	case STATE_PROBED:
> -	case STATE_RESET:
> -		dev_dbg_ratelimited(dev, "%s: device is in reset\n", __func__);
> -		rc = SCSI_MLQUEUE_HOST_BUSY;
> -		goto out;
> -	case STATE_FAILTERM:
> -		dev_dbg_ratelimited(dev, "%s: device has failed\n", __func__);
> -		scp->result = (DID_NO_CONNECT << 16);
> -		scsi_done(scp);
> -		rc = 0;
> -		goto out;
> -	default:
> -		atomic_inc(&afu->cmds_active);
> -		break;
> -	}
> -
> -	if (likely(sg)) {
> -		cmd->rcb.data_len = sg->length;
> -		cmd->rcb.data_ea = (uintptr_t)sg_virt(sg);
> -	}
> -
> -	cmd->scp = scp;
> -	cmd->parent = afu;
> -	cmd->hwq_index = hwq_index;
> -
> -	cmd->sa.ioasc = 0;
> -	cmd->rcb.ctx_id = hwq->ctx_hndl;
> -	cmd->rcb.msi = SISL_MSI_RRQ_UPDATED;
> -	cmd->rcb.port_sel = CHAN2PORTMASK(scp->device->channel);
> -	cmd->rcb.lun_id = lun_to_lunid(scp->device->lun);
> -
> -	if (scp->sc_data_direction == DMA_TO_DEVICE)
> -		req_flags |= SISL_REQ_FLAGS_HOST_WRITE;
> -
> -	cmd->rcb.req_flags = req_flags;
> -	memcpy(cmd->rcb.cdb, scp->cmnd, sizeof(cmd->rcb.cdb));
> -
> -	rc = afu->send_cmd(afu, cmd);
> -	atomic_dec(&afu->cmds_active);
> -out:
> -	return rc;
> -}
> -
> -/**
> - * cxlflash_wait_for_pci_err_recovery() - wait for error recovery during probe
> - * @cfg:	Internal structure associated with the host.
> - */
> -static void cxlflash_wait_for_pci_err_recovery(struct cxlflash_cfg *cfg)
> -{
> -	struct pci_dev *pdev = cfg->dev;
> -
> -	if (pci_channel_offline(pdev))
> -		wait_event_timeout(cfg->reset_waitq,
> -				   !pci_channel_offline(pdev),
> -				   CXLFLASH_PCI_ERROR_RECOVERY_TIMEOUT);
> -}
> -
> -/**
> - * free_mem() - free memory associated with the AFU
> - * @cfg:	Internal structure associated with the host.
> - */
> -static void free_mem(struct cxlflash_cfg *cfg)
> -{
> -	struct afu *afu = cfg->afu;
> -
> -	if (cfg->afu) {
> -		free_pages((ulong)afu, get_order(sizeof(struct afu)));
> -		cfg->afu = NULL;
> -	}
> -}
> -
> -/**
> - * cxlflash_reset_sync() - synchronizing point for asynchronous resets
> - * @cfg:	Internal structure associated with the host.
> - */
> -static void cxlflash_reset_sync(struct cxlflash_cfg *cfg)
> -{
> -	if (cfg->async_reset_cookie == 0)
> -		return;
> -
> -	/* Wait until all async calls prior to this cookie have completed */
> -	async_synchronize_cookie(cfg->async_reset_cookie + 1);
> -	cfg->async_reset_cookie = 0;
> -}
> -
> -/**
> - * stop_afu() - stops the AFU command timers and unmaps the MMIO space
> - * @cfg:	Internal structure associated with the host.
> - *
> - * Safe to call with AFU in a partially allocated/initialized state.
> - *
> - * Cancels scheduled worker threads, waits for any active internal AFU
> - * commands to timeout, disables IRQ polling and then unmaps the MMIO space.
> - */
> -static void stop_afu(struct cxlflash_cfg *cfg)
> -{
> -	struct afu *afu = cfg->afu;
> -	struct hwq *hwq;
> -	int i;
> -
> -	cancel_work_sync(&cfg->work_q);
> -	if (!current_is_async())
> -		cxlflash_reset_sync(cfg);
> -
> -	if (likely(afu)) {
> -		while (atomic_read(&afu->cmds_active))
> -			ssleep(1);
> -
> -		if (afu_is_irqpoll_enabled(afu)) {
> -			for (i = 0; i < afu->num_hwqs; i++) {
> -				hwq = get_hwq(afu, i);
> -
> -				irq_poll_disable(&hwq->irqpoll);
> -			}
> -		}
> -
> -		if (likely(afu->afu_map)) {
> -			cfg->ops->psa_unmap(afu->afu_map);
> -			afu->afu_map = NULL;
> -		}
> -	}
> -}
> -
> -/**
> - * term_intr() - disables all AFU interrupts
> - * @cfg:	Internal structure associated with the host.
> - * @level:	Depth of allocation, where to begin waterfall tear down.
> - * @index:	Index of the hardware queue.
> - *
> - * Safe to call with AFU/MC in partially allocated/initialized state.
> - */
> -static void term_intr(struct cxlflash_cfg *cfg, enum undo_level level,
> -		      u32 index)
> -{
> -	struct afu *afu = cfg->afu;
> -	struct device *dev = &cfg->dev->dev;
> -	struct hwq *hwq;
> -
> -	if (!afu) {
> -		dev_err(dev, "%s: returning with NULL afu\n", __func__);
> -		return;
> -	}
> -
> -	hwq = get_hwq(afu, index);
> -
> -	if (!hwq->ctx_cookie) {
> -		dev_err(dev, "%s: returning with NULL MC\n", __func__);
> -		return;
> -	}
> -
> -	switch (level) {
> -	case UNMAP_THREE:
> -		/* SISL_MSI_ASYNC_ERROR is setup only for the primary HWQ */
> -		if (index == PRIMARY_HWQ)
> -			cfg->ops->unmap_afu_irq(hwq->ctx_cookie, 3, hwq);
> -		fallthrough;
> -	case UNMAP_TWO:
> -		cfg->ops->unmap_afu_irq(hwq->ctx_cookie, 2, hwq);
> -		fallthrough;
> -	case UNMAP_ONE:
> -		cfg->ops->unmap_afu_irq(hwq->ctx_cookie, 1, hwq);
> -		fallthrough;
> -	case FREE_IRQ:
> -		cfg->ops->free_afu_irqs(hwq->ctx_cookie);
> -		fallthrough;
> -	case UNDO_NOOP:
> -		/* No action required */
> -		break;
> -	}
> -}
> -
> -/**
> - * term_mc() - terminates the master context
> - * @cfg:	Internal structure associated with the host.
> - * @index:	Index of the hardware queue.
> - *
> - * Safe to call with AFU/MC in partially allocated/initialized state.
> - */
> -static void term_mc(struct cxlflash_cfg *cfg, u32 index)
> -{
> -	struct afu *afu = cfg->afu;
> -	struct device *dev = &cfg->dev->dev;
> -	struct hwq *hwq;
> -	ulong lock_flags;
> -
> -	if (!afu) {
> -		dev_err(dev, "%s: returning with NULL afu\n", __func__);
> -		return;
> -	}
> -
> -	hwq = get_hwq(afu, index);
> -
> -	if (!hwq->ctx_cookie) {
> -		dev_err(dev, "%s: returning with NULL MC\n", __func__);
> -		return;
> -	}
> -
> -	WARN_ON(cfg->ops->stop_context(hwq->ctx_cookie));
> -	if (index != PRIMARY_HWQ)
> -		WARN_ON(cfg->ops->release_context(hwq->ctx_cookie));
> -	hwq->ctx_cookie = NULL;
> -
> -	spin_lock_irqsave(&hwq->hrrq_slock, lock_flags);
> -	hwq->hrrq_online = false;
> -	spin_unlock_irqrestore(&hwq->hrrq_slock, lock_flags);
> -
> -	spin_lock_irqsave(&hwq->hsq_slock, lock_flags);
> -	flush_pending_cmds(hwq);
> -	spin_unlock_irqrestore(&hwq->hsq_slock, lock_flags);
> -}
> -
> -/**
> - * term_afu() - terminates the AFU
> - * @cfg:	Internal structure associated with the host.
> - *
> - * Safe to call with AFU/MC in partially allocated/initialized state.
> - */
> -static void term_afu(struct cxlflash_cfg *cfg)
> -{
> -	struct device *dev = &cfg->dev->dev;
> -	int k;
> -
> -	/*
> -	 * Tear down is carefully orchestrated to ensure
> -	 * no interrupts can come in when the problem state
> -	 * area is unmapped.
> -	 *
> -	 * 1) Disable all AFU interrupts for each master
> -	 * 2) Unmap the problem state area
> -	 * 3) Stop each master context
> -	 */
> -	for (k = cfg->afu->num_hwqs - 1; k >= 0; k--)
> -		term_intr(cfg, UNMAP_THREE, k);
> -
> -	stop_afu(cfg);
> -
> -	for (k = cfg->afu->num_hwqs - 1; k >= 0; k--)
> -		term_mc(cfg, k);
> -
> -	dev_dbg(dev, "%s: returning\n", __func__);
> -}
> -
> -/**
> - * notify_shutdown() - notifies device of pending shutdown
> - * @cfg:	Internal structure associated with the host.
> - * @wait:	Whether to wait for shutdown processing to complete.
> - *
> - * This function will notify the AFU that the adapter is being shutdown
> - * and will wait for shutdown processing to complete if wait is true.
> - * This notification should flush pending I/Os to the device and halt
> - * further I/Os until the next AFU reset is issued and device restarted.
> - */
> -static void notify_shutdown(struct cxlflash_cfg *cfg, bool wait)
> -{
> -	struct afu *afu = cfg->afu;
> -	struct device *dev = &cfg->dev->dev;
> -	struct dev_dependent_vals *ddv;
> -	__be64 __iomem *fc_port_regs;
> -	u64 reg, status;
> -	int i, retry_cnt = 0;
> -
> -	ddv = (struct dev_dependent_vals *)cfg->dev_id->driver_data;
> -	if (!(ddv->flags & CXLFLASH_NOTIFY_SHUTDOWN))
> -		return;
> -
> -	if (!afu || !afu->afu_map) {
> -		dev_dbg(dev, "%s: Problem state area not mapped\n", __func__);
> -		return;
> -	}
> -
> -	/* Notify AFU */
> -	for (i = 0; i < cfg->num_fc_ports; i++) {
> -		fc_port_regs = get_fc_port_regs(cfg, i);
> -
> -		reg = readq_be(&fc_port_regs[FC_CONFIG2 / 8]);
> -		reg |= SISL_FC_SHUTDOWN_NORMAL;
> -		writeq_be(reg, &fc_port_regs[FC_CONFIG2 / 8]);
> -	}
> -
> -	if (!wait)
> -		return;
> -
> -	/* Wait up to 1.5 seconds for shutdown processing to complete */
> -	for (i = 0; i < cfg->num_fc_ports; i++) {
> -		fc_port_regs = get_fc_port_regs(cfg, i);
> -		retry_cnt = 0;
> -
> -		while (true) {
> -			status = readq_be(&fc_port_regs[FC_STATUS / 8]);
> -			if (status & SISL_STATUS_SHUTDOWN_COMPLETE)
> -				break;
> -			if (++retry_cnt >= MC_RETRY_CNT) {
> -				dev_dbg(dev, "%s: port %d shutdown processing "
> -					"not yet completed\n", __func__, i);
> -				break;
> -			}
> -			msleep(100 * retry_cnt);
> -		}
> -	}
> -}
> -
> -/**
> - * cxlflash_get_minor() - gets the first available minor number
> - *
> - * Return: Unique minor number that can be used to create the character device.
> - */
> -static int cxlflash_get_minor(void)
> -{
> -	int minor;
> -	long bit;
> -
> -	bit = find_first_zero_bit(cxlflash_minor, CXLFLASH_MAX_ADAPTERS);
> -	if (bit >= CXLFLASH_MAX_ADAPTERS)
> -		return -1;
> -
> -	minor = bit & MINORMASK;
> -	set_bit(minor, cxlflash_minor);
> -	return minor;
> -}
> -
> -/**
> - * cxlflash_put_minor() - releases the minor number
> - * @minor:	Minor number that is no longer needed.
> - */
> -static void cxlflash_put_minor(int minor)
> -{
> -	clear_bit(minor, cxlflash_minor);
> -}
> -
> -/**
> - * cxlflash_release_chrdev() - release the character device for the host
> - * @cfg:	Internal structure associated with the host.
> - */
> -static void cxlflash_release_chrdev(struct cxlflash_cfg *cfg)
> -{
> -	device_unregister(cfg->chardev);
> -	cfg->chardev = NULL;
> -	cdev_del(&cfg->cdev);
> -	cxlflash_put_minor(MINOR(cfg->cdev.dev));
> -}
> -
> -/**
> - * cxlflash_remove() - PCI entry point to tear down host
> - * @pdev:	PCI device associated with the host.
> - *
> - * Safe to use as a cleanup in partially allocated/initialized state. Note that
> - * the reset_waitq is flushed as part of the stop/termination of user contexts.
> - */
> -static void cxlflash_remove(struct pci_dev *pdev)
> -{
> -	struct cxlflash_cfg *cfg = pci_get_drvdata(pdev);
> -	struct device *dev = &pdev->dev;
> -	ulong lock_flags;
> -
> -	if (!pci_is_enabled(pdev)) {
> -		dev_dbg(dev, "%s: Device is disabled\n", __func__);
> -		return;
> -	}
> -
> -	/* Yield to running recovery threads before continuing with remove */
> -	wait_event(cfg->reset_waitq, cfg->state != STATE_RESET &&
> -				     cfg->state != STATE_PROBING);
> -	spin_lock_irqsave(&cfg->tmf_slock, lock_flags);
> -	if (cfg->tmf_active)
> -		wait_event_interruptible_lock_irq(cfg->tmf_waitq,
> -						  !cfg->tmf_active,
> -						  cfg->tmf_slock);
> -	spin_unlock_irqrestore(&cfg->tmf_slock, lock_flags);
> -
> -	/* Notify AFU and wait for shutdown processing to complete */
> -	notify_shutdown(cfg, true);
> -
> -	cfg->state = STATE_FAILTERM;
> -	cxlflash_stop_term_user_contexts(cfg);
> -
> -	switch (cfg->init_state) {
> -	case INIT_STATE_CDEV:
> -		cxlflash_release_chrdev(cfg);
> -		fallthrough;
> -	case INIT_STATE_SCSI:
> -		cxlflash_term_local_luns(cfg);
> -		scsi_remove_host(cfg->host);
> -		fallthrough;
> -	case INIT_STATE_AFU:
> -		term_afu(cfg);
> -		fallthrough;
> -	case INIT_STATE_PCI:
> -		cfg->ops->destroy_afu(cfg->afu_cookie);
> -		pci_disable_device(pdev);
> -		fallthrough;
> -	case INIT_STATE_NONE:
> -		free_mem(cfg);
> -		scsi_host_put(cfg->host);
> -		break;
> -	}
> -
> -	dev_dbg(dev, "%s: returning\n", __func__);
> -}
> -
> -/**
> - * alloc_mem() - allocates the AFU and its command pool
> - * @cfg:	Internal structure associated with the host.
> - *
> - * A partially allocated state remains on failure.
> - *
> - * Return:
> - *	0 on success
> - *	-ENOMEM on failure to allocate memory
> - */
> -static int alloc_mem(struct cxlflash_cfg *cfg)
> -{
> -	int rc = 0;
> -	struct device *dev = &cfg->dev->dev;
> -
> -	/* AFU is ~28k, i.e. only one 64k page or up to seven 4k pages */
> -	cfg->afu = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
> -					    get_order(sizeof(struct afu)));
> -	if (unlikely(!cfg->afu)) {
> -		dev_err(dev, "%s: cannot get %d free pages\n",
> -			__func__, get_order(sizeof(struct afu)));
> -		rc = -ENOMEM;
> -		goto out;
> -	}
> -	cfg->afu->parent = cfg;
> -	cfg->afu->desired_hwqs = CXLFLASH_DEF_HWQS;
> -	cfg->afu->afu_map = NULL;
> -out:
> -	return rc;
> -}
> -
> -/**
> - * init_pci() - initializes the host as a PCI device
> - * @cfg:	Internal structure associated with the host.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int init_pci(struct cxlflash_cfg *cfg)
> -{
> -	struct pci_dev *pdev = cfg->dev;
> -	struct device *dev = &cfg->dev->dev;
> -	int rc = 0;
> -
> -	rc = pci_enable_device(pdev);
> -	if (rc || pci_channel_offline(pdev)) {
> -		if (pci_channel_offline(pdev)) {
> -			cxlflash_wait_for_pci_err_recovery(cfg);
> -			rc = pci_enable_device(pdev);
> -		}
> -
> -		if (rc) {
> -			dev_err(dev, "%s: Cannot enable adapter\n", __func__);
> -			cxlflash_wait_for_pci_err_recovery(cfg);
> -			goto out;
> -		}
> -	}
> -
> -out:
> -	dev_dbg(dev, "%s: returning rc=%d\n", __func__, rc);
> -	return rc;
> -}
> -
> -/**
> - * init_scsi() - adds the host to the SCSI stack and kicks off host scan
> - * @cfg:	Internal structure associated with the host.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int init_scsi(struct cxlflash_cfg *cfg)
> -{
> -	struct pci_dev *pdev = cfg->dev;
> -	struct device *dev = &cfg->dev->dev;
> -	int rc = 0;
> -
> -	rc = scsi_add_host(cfg->host, &pdev->dev);
> -	if (rc) {
> -		dev_err(dev, "%s: scsi_add_host failed rc=%d\n", __func__, rc);
> -		goto out;
> -	}
> -
> -	scsi_scan_host(cfg->host);
> -
> -out:
> -	dev_dbg(dev, "%s: returning rc=%d\n", __func__, rc);
> -	return rc;
> -}
> -
> -/**
> - * set_port_online() - transitions the specified host FC port to online state
> - * @fc_regs:	Top of MMIO region defined for specified port.
> - *
> - * The provided MMIO region must be mapped prior to call. Online state means
> - * that the FC link layer has synced, completed the handshaking process, and
> - * is ready for login to start.
> - */
> -static void set_port_online(__be64 __iomem *fc_regs)
> -{
> -	u64 cmdcfg;
> -
> -	cmdcfg = readq_be(&fc_regs[FC_MTIP_CMDCONFIG / 8]);
> -	cmdcfg &= (~FC_MTIP_CMDCONFIG_OFFLINE);	/* clear OFF_LINE */
> -	cmdcfg |= (FC_MTIP_CMDCONFIG_ONLINE);	/* set ON_LINE */
> -	writeq_be(cmdcfg, &fc_regs[FC_MTIP_CMDCONFIG / 8]);
> -}
> -
> -/**
> - * set_port_offline() - transitions the specified host FC port to offline state
> - * @fc_regs:	Top of MMIO region defined for specified port.
> - *
> - * The provided MMIO region must be mapped prior to call.
> - */
> -static void set_port_offline(__be64 __iomem *fc_regs)
> -{
> -	u64 cmdcfg;
> -
> -	cmdcfg = readq_be(&fc_regs[FC_MTIP_CMDCONFIG / 8]);
> -	cmdcfg &= (~FC_MTIP_CMDCONFIG_ONLINE);	/* clear ON_LINE */
> -	cmdcfg |= (FC_MTIP_CMDCONFIG_OFFLINE);	/* set OFF_LINE */
> -	writeq_be(cmdcfg, &fc_regs[FC_MTIP_CMDCONFIG / 8]);
> -}
> -
> -/**
> - * wait_port_online() - waits for the specified host FC port come online
> - * @fc_regs:	Top of MMIO region defined for specified port.
> - * @delay_us:	Number of microseconds to delay between reading port status.
> - * @nretry:	Number of cycles to retry reading port status.
> - *
> - * The provided MMIO region must be mapped prior to call. This will timeout
> - * when the cable is not plugged in.
> - *
> - * Return:
> - *	TRUE (1) when the specified port is online
> - *	FALSE (0) when the specified port fails to come online after timeout
> - */
> -static bool wait_port_online(__be64 __iomem *fc_regs, u32 delay_us, u32 nretry)
> -{
> -	u64 status;
> -
> -	WARN_ON(delay_us < 1000);
> -
> -	do {
> -		msleep(delay_us / 1000);
> -		status = readq_be(&fc_regs[FC_MTIP_STATUS / 8]);
> -		if (status == U64_MAX)
> -			nretry /= 2;
> -	} while ((status & FC_MTIP_STATUS_MASK) != FC_MTIP_STATUS_ONLINE &&
> -		 nretry--);
> -
> -	return ((status & FC_MTIP_STATUS_MASK) == FC_MTIP_STATUS_ONLINE);
> -}
> -
> -/**
> - * wait_port_offline() - waits for the specified host FC port go offline
> - * @fc_regs:	Top of MMIO region defined for specified port.
> - * @delay_us:	Number of microseconds to delay between reading port status.
> - * @nretry:	Number of cycles to retry reading port status.
> - *
> - * The provided MMIO region must be mapped prior to call.
> - *
> - * Return:
> - *	TRUE (1) when the specified port is offline
> - *	FALSE (0) when the specified port fails to go offline after timeout
> - */
> -static bool wait_port_offline(__be64 __iomem *fc_regs, u32 delay_us, u32 nretry)
> -{
> -	u64 status;
> -
> -	WARN_ON(delay_us < 1000);
> -
> -	do {
> -		msleep(delay_us / 1000);
> -		status = readq_be(&fc_regs[FC_MTIP_STATUS / 8]);
> -		if (status == U64_MAX)
> -			nretry /= 2;
> -	} while ((status & FC_MTIP_STATUS_MASK) != FC_MTIP_STATUS_OFFLINE &&
> -		 nretry--);
> -
> -	return ((status & FC_MTIP_STATUS_MASK) == FC_MTIP_STATUS_OFFLINE);
> -}
> -
> -/**
> - * afu_set_wwpn() - configures the WWPN for the specified host FC port
> - * @afu:	AFU associated with the host that owns the specified FC port.
> - * @port:	Port number being configured.
> - * @fc_regs:	Top of MMIO region defined for specified port.
> - * @wwpn:	The world-wide-port-number previously discovered for port.
> - *
> - * The provided MMIO region must be mapped prior to call. As part of the
> - * sequence to configure the WWPN, the port is toggled offline and then back
> - * online. This toggling action can cause this routine to delay up to a few
> - * seconds. When configured to use the internal LUN feature of the AFU, a
> - * failure to come online is overridden.
> - */
> -static void afu_set_wwpn(struct afu *afu, int port, __be64 __iomem *fc_regs,
> -			 u64 wwpn)
> -{
> -	struct cxlflash_cfg *cfg = afu->parent;
> -	struct device *dev = &cfg->dev->dev;
> -
> -	set_port_offline(fc_regs);
> -	if (!wait_port_offline(fc_regs, FC_PORT_STATUS_RETRY_INTERVAL_US,
> -			       FC_PORT_STATUS_RETRY_CNT)) {
> -		dev_dbg(dev, "%s: wait on port %d to go offline timed out\n",
> -			__func__, port);
> -	}
> -
> -	writeq_be(wwpn, &fc_regs[FC_PNAME / 8]);
> -
> -	set_port_online(fc_regs);
> -	if (!wait_port_online(fc_regs, FC_PORT_STATUS_RETRY_INTERVAL_US,
> -			      FC_PORT_STATUS_RETRY_CNT)) {
> -		dev_dbg(dev, "%s: wait on port %d to go online timed out\n",
> -			__func__, port);
> -	}
> -}
> -
> -/**
> - * afu_link_reset() - resets the specified host FC port
> - * @afu:	AFU associated with the host that owns the specified FC port.
> - * @port:	Port number being configured.
> - * @fc_regs:	Top of MMIO region defined for specified port.
> - *
> - * The provided MMIO region must be mapped prior to call. The sequence to
> - * reset the port involves toggling it offline and then back online. This
> - * action can cause this routine to delay up to a few seconds. An effort
> - * is made to maintain link with the device by switching to host to use
> - * the alternate port exclusively while the reset takes place.
> - * failure to come online is overridden.
> - */
> -static void afu_link_reset(struct afu *afu, int port, __be64 __iomem *fc_regs)
> -{
> -	struct cxlflash_cfg *cfg = afu->parent;
> -	struct device *dev = &cfg->dev->dev;
> -	u64 port_sel;
> -
> -	/* first switch the AFU to the other links, if any */
> -	port_sel = readq_be(&afu->afu_map->global.regs.afu_port_sel);
> -	port_sel &= ~(1ULL << port);
> -	writeq_be(port_sel, &afu->afu_map->global.regs.afu_port_sel);
> -	cxlflash_afu_sync(afu, 0, 0, AFU_GSYNC);
> -
> -	set_port_offline(fc_regs);
> -	if (!wait_port_offline(fc_regs, FC_PORT_STATUS_RETRY_INTERVAL_US,
> -			       FC_PORT_STATUS_RETRY_CNT))
> -		dev_err(dev, "%s: wait on port %d to go offline timed out\n",
> -			__func__, port);
> -
> -	set_port_online(fc_regs);
> -	if (!wait_port_online(fc_regs, FC_PORT_STATUS_RETRY_INTERVAL_US,
> -			      FC_PORT_STATUS_RETRY_CNT))
> -		dev_err(dev, "%s: wait on port %d to go online timed out\n",
> -			__func__, port);
> -
> -	/* switch back to include this port */
> -	port_sel |= (1ULL << port);
> -	writeq_be(port_sel, &afu->afu_map->global.regs.afu_port_sel);
> -	cxlflash_afu_sync(afu, 0, 0, AFU_GSYNC);
> -
> -	dev_dbg(dev, "%s: returning port_sel=%016llx\n", __func__, port_sel);
> -}
> -
> -/**
> - * afu_err_intr_init() - clears and initializes the AFU for error interrupts
> - * @afu:	AFU associated with the host.
> - */
> -static void afu_err_intr_init(struct afu *afu)
> -{
> -	struct cxlflash_cfg *cfg = afu->parent;
> -	__be64 __iomem *fc_port_regs;
> -	int i;
> -	struct hwq *hwq = get_hwq(afu, PRIMARY_HWQ);
> -	u64 reg;
> -
> -	/* global async interrupts: AFU clears afu_ctrl on context exit
> -	 * if async interrupts were sent to that context. This prevents
> -	 * the AFU form sending further async interrupts when
> -	 * there is
> -	 * nobody to receive them.
> -	 */
> -
> -	/* mask all */
> -	writeq_be(-1ULL, &afu->afu_map->global.regs.aintr_mask);
> -	/* set LISN# to send and point to primary master context */
> -	reg = ((u64) (((hwq->ctx_hndl << 8) | SISL_MSI_ASYNC_ERROR)) << 40);
> -
> -	if (afu->internal_lun)
> -		reg |= 1;	/* Bit 63 indicates local lun */
> -	writeq_be(reg, &afu->afu_map->global.regs.afu_ctrl);
> -	/* clear all */
> -	writeq_be(-1ULL, &afu->afu_map->global.regs.aintr_clear);
> -	/* unmask bits that are of interest */
> -	/* note: afu can send an interrupt after this step */
> -	writeq_be(SISL_ASTATUS_MASK, &afu->afu_map->global.regs.aintr_mask);
> -	/* clear again in case a bit came on after previous clear but before */
> -	/* unmask */
> -	writeq_be(-1ULL, &afu->afu_map->global.regs.aintr_clear);
> -
> -	/* Clear/Set internal lun bits */
> -	fc_port_regs = get_fc_port_regs(cfg, 0);
> -	reg = readq_be(&fc_port_regs[FC_CONFIG2 / 8]);
> -	reg &= SISL_FC_INTERNAL_MASK;
> -	if (afu->internal_lun)
> -		reg |= ((u64)(afu->internal_lun - 1) << SISL_FC_INTERNAL_SHIFT);
> -	writeq_be(reg, &fc_port_regs[FC_CONFIG2 / 8]);
> -
> -	/* now clear FC errors */
> -	for (i = 0; i < cfg->num_fc_ports; i++) {
> -		fc_port_regs = get_fc_port_regs(cfg, i);
> -
> -		writeq_be(0xFFFFFFFFU, &fc_port_regs[FC_ERROR / 8]);
> -		writeq_be(0, &fc_port_regs[FC_ERRCAP / 8]);
> -	}
> -
> -	/* sync interrupts for master's IOARRIN write */
> -	/* note that unlike asyncs, there can be no pending sync interrupts */
> -	/* at this time (this is a fresh context and master has not written */
> -	/* IOARRIN yet), so there is nothing to clear. */
> -
> -	/* set LISN#, it is always sent to the context that wrote IOARRIN */
> -	for (i = 0; i < afu->num_hwqs; i++) {
> -		hwq = get_hwq(afu, i);
> -
> -		reg = readq_be(&hwq->host_map->ctx_ctrl);
> -		WARN_ON((reg & SISL_CTX_CTRL_LISN_MASK) != 0);
> -		reg |= SISL_MSI_SYNC_ERROR;
> -		writeq_be(reg, &hwq->host_map->ctx_ctrl);
> -		writeq_be(SISL_ISTATUS_MASK, &hwq->host_map->intr_mask);
> -	}
> -}
> -
> -/**
> - * cxlflash_sync_err_irq() - interrupt handler for synchronous errors
> - * @irq:	Interrupt number.
> - * @data:	Private data provided at interrupt registration, the AFU.
> - *
> - * Return: Always return IRQ_HANDLED.
> - */
> -static irqreturn_t cxlflash_sync_err_irq(int irq, void *data)
> -{
> -	struct hwq *hwq = (struct hwq *)data;
> -	struct cxlflash_cfg *cfg = hwq->afu->parent;
> -	struct device *dev = &cfg->dev->dev;
> -	u64 reg;
> -	u64 reg_unmasked;
> -
> -	reg = readq_be(&hwq->host_map->intr_status);
> -	reg_unmasked = (reg & SISL_ISTATUS_UNMASK);
> -
> -	if (reg_unmasked == 0UL) {
> -		dev_err(dev, "%s: spurious interrupt, intr_status=%016llx\n",
> -			__func__, reg);
> -		goto cxlflash_sync_err_irq_exit;
> -	}
> -
> -	dev_err(dev, "%s: unexpected interrupt, intr_status=%016llx\n",
> -		__func__, reg);
> -
> -	writeq_be(reg_unmasked, &hwq->host_map->intr_clear);
> -
> -cxlflash_sync_err_irq_exit:
> -	return IRQ_HANDLED;
> -}
> -
> -/**
> - * process_hrrq() - process the read-response queue
> - * @hwq:	HWQ associated with the host.
> - * @doneq:	Queue of commands harvested from the RRQ.
> - * @budget:	Threshold of RRQ entries to process.
> - *
> - * This routine must be called holding the disabled RRQ spin lock.
> - *
> - * Return: The number of entries processed.
> - */
> -static int process_hrrq(struct hwq *hwq, struct list_head *doneq, int budget)
> -{
> -	struct afu *afu = hwq->afu;
> -	struct afu_cmd *cmd;
> -	struct sisl_ioasa *ioasa;
> -	struct sisl_ioarcb *ioarcb;
> -	bool toggle = hwq->toggle;
> -	int num_hrrq = 0;
> -	u64 entry,
> -	    *hrrq_start = hwq->hrrq_start,
> -	    *hrrq_end = hwq->hrrq_end,
> -	    *hrrq_curr = hwq->hrrq_curr;
> -
> -	/* Process ready RRQ entries up to the specified budget (if any) */
> -	while (true) {
> -		entry = *hrrq_curr;
> -
> -		if ((entry & SISL_RESP_HANDLE_T_BIT) != toggle)
> -			break;
> -
> -		entry &= ~SISL_RESP_HANDLE_T_BIT;
> -
> -		if (afu_is_sq_cmd_mode(afu)) {
> -			ioasa = (struct sisl_ioasa *)entry;
> -			cmd = container_of(ioasa, struct afu_cmd, sa);
> -		} else {
> -			ioarcb = (struct sisl_ioarcb *)entry;
> -			cmd = container_of(ioarcb, struct afu_cmd, rcb);
> -		}
> -
> -		list_add_tail(&cmd->queue, doneq);
> -
> -		/* Advance to next entry or wrap and flip the toggle bit */
> -		if (hrrq_curr < hrrq_end)
> -			hrrq_curr++;
> -		else {
> -			hrrq_curr = hrrq_start;
> -			toggle ^= SISL_RESP_HANDLE_T_BIT;
> -		}
> -
> -		atomic_inc(&hwq->hsq_credits);
> -		num_hrrq++;
> -
> -		if (budget > 0 && num_hrrq >= budget)
> -			break;
> -	}
> -
> -	hwq->hrrq_curr = hrrq_curr;
> -	hwq->toggle = toggle;
> -
> -	return num_hrrq;
> -}
> -
> -/**
> - * process_cmd_doneq() - process a queue of harvested RRQ commands
> - * @doneq:	Queue of completed commands.
> - *
> - * Note that upon return the queue can no longer be trusted.
> - */
> -static void process_cmd_doneq(struct list_head *doneq)
> -{
> -	struct afu_cmd *cmd, *tmp;
> -
> -	WARN_ON(list_empty(doneq));
> -
> -	list_for_each_entry_safe(cmd, tmp, doneq, queue)
> -		cmd_complete(cmd);
> -}
> -
> -/**
> - * cxlflash_irqpoll() - process a queue of harvested RRQ commands
> - * @irqpoll:	IRQ poll structure associated with queue to poll.
> - * @budget:	Threshold of RRQ entries to process per poll.
> - *
> - * Return: The number of entries processed.
> - */
> -static int cxlflash_irqpoll(struct irq_poll *irqpoll, int budget)
> -{
> -	struct hwq *hwq = container_of(irqpoll, struct hwq, irqpoll);
> -	unsigned long hrrq_flags;
> -	LIST_HEAD(doneq);
> -	int num_entries = 0;
> -
> -	spin_lock_irqsave(&hwq->hrrq_slock, hrrq_flags);
> -
> -	num_entries = process_hrrq(hwq, &doneq, budget);
> -	if (num_entries < budget)
> -		irq_poll_complete(irqpoll);
> -
> -	spin_unlock_irqrestore(&hwq->hrrq_slock, hrrq_flags);
> -
> -	process_cmd_doneq(&doneq);
> -	return num_entries;
> -}
> -
> -/**
> - * cxlflash_rrq_irq() - interrupt handler for read-response queue (normal path)
> - * @irq:	Interrupt number.
> - * @data:	Private data provided at interrupt registration, the AFU.
> - *
> - * Return: IRQ_HANDLED or IRQ_NONE when no ready entries found.
> - */
> -static irqreturn_t cxlflash_rrq_irq(int irq, void *data)
> -{
> -	struct hwq *hwq = (struct hwq *)data;
> -	struct afu *afu = hwq->afu;
> -	unsigned long hrrq_flags;
> -	LIST_HEAD(doneq);
> -	int num_entries = 0;
> -
> -	spin_lock_irqsave(&hwq->hrrq_slock, hrrq_flags);
> -
> -	/* Silently drop spurious interrupts when queue is not online */
> -	if (!hwq->hrrq_online) {
> -		spin_unlock_irqrestore(&hwq->hrrq_slock, hrrq_flags);
> -		return IRQ_HANDLED;
> -	}
> -
> -	if (afu_is_irqpoll_enabled(afu)) {
> -		irq_poll_sched(&hwq->irqpoll);
> -		spin_unlock_irqrestore(&hwq->hrrq_slock, hrrq_flags);
> -		return IRQ_HANDLED;
> -	}
> -
> -	num_entries = process_hrrq(hwq, &doneq, -1);
> -	spin_unlock_irqrestore(&hwq->hrrq_slock, hrrq_flags);
> -
> -	if (num_entries == 0)
> -		return IRQ_NONE;
> -
> -	process_cmd_doneq(&doneq);
> -	return IRQ_HANDLED;
> -}
> -
> -/*
> - * Asynchronous interrupt information table
> - *
> - * NOTE:
> - *	- Order matters here as this array is indexed by bit position.
> - *
> - *	- The checkpatch script considers the BUILD_SISL_ASTATUS_FC_PORT macro
> - *	  as complex and complains due to a lack of parentheses/braces.
> - */
> -#define ASTATUS_FC(_a, _b, _c, _d)					 \
> -	{ SISL_ASTATUS_FC##_a##_##_b, _c, _a, (_d) }
> -
> -#define BUILD_SISL_ASTATUS_FC_PORT(_a)					 \
> -	ASTATUS_FC(_a, LINK_UP, "link up", 0),				 \
> -	ASTATUS_FC(_a, LINK_DN, "link down", 0),			 \
> -	ASTATUS_FC(_a, LOGI_S, "login succeeded", SCAN_HOST),		 \
> -	ASTATUS_FC(_a, LOGI_F, "login failed", CLR_FC_ERROR),		 \
> -	ASTATUS_FC(_a, LOGI_R, "login timed out, retrying", LINK_RESET), \
> -	ASTATUS_FC(_a, CRC_T, "CRC threshold exceeded", LINK_RESET),	 \
> -	ASTATUS_FC(_a, LOGO, "target initiated LOGO", 0),		 \
> -	ASTATUS_FC(_a, OTHER, "other error", CLR_FC_ERROR | LINK_RESET)
> -
> -static const struct asyc_intr_info ainfo[] = {
> -	BUILD_SISL_ASTATUS_FC_PORT(1),
> -	BUILD_SISL_ASTATUS_FC_PORT(0),
> -	BUILD_SISL_ASTATUS_FC_PORT(3),
> -	BUILD_SISL_ASTATUS_FC_PORT(2)
> -};
> -
> -/**
> - * cxlflash_async_err_irq() - interrupt handler for asynchronous errors
> - * @irq:	Interrupt number.
> - * @data:	Private data provided at interrupt registration, the AFU.
> - *
> - * Return: Always return IRQ_HANDLED.
> - */
> -static irqreturn_t cxlflash_async_err_irq(int irq, void *data)
> -{
> -	struct hwq *hwq = (struct hwq *)data;
> -	struct afu *afu = hwq->afu;
> -	struct cxlflash_cfg *cfg = afu->parent;
> -	struct device *dev = &cfg->dev->dev;
> -	const struct asyc_intr_info *info;
> -	struct sisl_global_map __iomem *global = &afu->afu_map->global;
> -	__be64 __iomem *fc_port_regs;
> -	u64 reg_unmasked;
> -	u64 reg;
> -	u64 bit;
> -	u8 port;
> -
> -	reg = readq_be(&global->regs.aintr_status);
> -	reg_unmasked = (reg & SISL_ASTATUS_UNMASK);
> -
> -	if (unlikely(reg_unmasked == 0)) {
> -		dev_err(dev, "%s: spurious interrupt, aintr_status=%016llx\n",
> -			__func__, reg);
> -		goto out;
> -	}
> -
> -	/* FYI, it is 'okay' to clear AFU status before FC_ERROR */
> -	writeq_be(reg_unmasked, &global->regs.aintr_clear);
> -
> -	/* Check each bit that is on */
> -	for_each_set_bit(bit, (ulong *)&reg_unmasked, BITS_PER_LONG) {
> -		if (unlikely(bit >= ARRAY_SIZE(ainfo))) {
> -			WARN_ON_ONCE(1);
> -			continue;
> -		}
> -
> -		info = &ainfo[bit];
> -		if (unlikely(info->status != 1ULL << bit)) {
> -			WARN_ON_ONCE(1);
> -			continue;
> -		}
> -
> -		port = info->port;
> -		fc_port_regs = get_fc_port_regs(cfg, port);
> -
> -		dev_err(dev, "%s: FC Port %d -> %s, fc_status=%016llx\n",
> -			__func__, port, info->desc,
> -		       readq_be(&fc_port_regs[FC_STATUS / 8]));
> -
> -		/*
> -		 * Do link reset first, some OTHER errors will set FC_ERROR
> -		 * again if cleared before or w/o a reset
> -		 */
> -		if (info->action & LINK_RESET) {
> -			dev_err(dev, "%s: FC Port %d: resetting link\n",
> -				__func__, port);
> -			cfg->lr_state = LINK_RESET_REQUIRED;
> -			cfg->lr_port = port;
> -			schedule_work(&cfg->work_q);
> -		}
> -
> -		if (info->action & CLR_FC_ERROR) {
> -			reg = readq_be(&fc_port_regs[FC_ERROR / 8]);
> -
> -			/*
> -			 * Since all errors are unmasked, FC_ERROR and FC_ERRCAP
> -			 * should be the same and tracing one is sufficient.
> -			 */
> -
> -			dev_err(dev, "%s: fc %d: clearing fc_error=%016llx\n",
> -				__func__, port, reg);
> -
> -			writeq_be(reg, &fc_port_regs[FC_ERROR / 8]);
> -			writeq_be(0, &fc_port_regs[FC_ERRCAP / 8]);
> -		}
> -
> -		if (info->action & SCAN_HOST) {
> -			atomic_inc(&cfg->scan_host_needed);
> -			schedule_work(&cfg->work_q);
> -		}
> -	}
> -
> -out:
> -	return IRQ_HANDLED;
> -}
> -
> -/**
> - * read_vpd() - obtains the WWPNs from VPD
> - * @cfg:	Internal structure associated with the host.
> - * @wwpn:	Array of size MAX_FC_PORTS to pass back WWPNs
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int read_vpd(struct cxlflash_cfg *cfg, u64 wwpn[])
> -{
> -	struct device *dev = &cfg->dev->dev;
> -	struct pci_dev *pdev = cfg->dev;
> -	int i, k, rc = 0;
> -	unsigned int kw_size;
> -	ssize_t vpd_size;
> -	char vpd_data[CXLFLASH_VPD_LEN];
> -	char tmp_buf[WWPN_BUF_LEN] = { 0 };
> -	const struct dev_dependent_vals *ddv = (struct dev_dependent_vals *)
> -						cfg->dev_id->driver_data;
> -	const bool wwpn_vpd_required = ddv->flags & CXLFLASH_WWPN_VPD_REQUIRED;
> -	const char *wwpn_vpd_tags[MAX_FC_PORTS] = { "V5", "V6", "V7", "V8" };
> -
> -	/* Get the VPD data from the device */
> -	vpd_size = cfg->ops->read_adapter_vpd(pdev, vpd_data, sizeof(vpd_data));
> -	if (unlikely(vpd_size <= 0)) {
> -		dev_err(dev, "%s: Unable to read VPD (size = %ld)\n",
> -			__func__, vpd_size);
> -		rc = -ENODEV;
> -		goto out;
> -	}
> -
> -	/*
> -	 * Find the offset of the WWPN tag within the read only
> -	 * VPD data and validate the found field (partials are
> -	 * no good to us). Convert the ASCII data to an integer
> -	 * value. Note that we must copy to a temporary buffer
> -	 * because the conversion service requires that the ASCII
> -	 * string be terminated.
> -	 *
> -	 * Allow for WWPN not being found for all devices, setting
> -	 * the returned WWPN to zero when not found. Notify with a
> -	 * log error for cards that should have had WWPN keywords
> -	 * in the VPD - cards requiring WWPN will not have their
> -	 * ports programmed and operate in an undefined state.
> -	 */
> -	for (k = 0; k < cfg->num_fc_ports; k++) {
> -		i = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size,
> -						 wwpn_vpd_tags[k], &kw_size);
> -		if (i == -ENOENT) {
> -			if (wwpn_vpd_required)
> -				dev_err(dev, "%s: Port %d WWPN not found\n",
> -					__func__, k);
> -			wwpn[k] = 0ULL;
> -			continue;
> -		}
> -
> -		if (i < 0 || kw_size != WWPN_LEN) {
> -			dev_err(dev, "%s: Port %d WWPN incomplete or bad VPD\n",
> -				__func__, k);
> -			rc = -ENODEV;
> -			goto out;
> -		}
> -
> -		memcpy(tmp_buf, &vpd_data[i], WWPN_LEN);
> -		rc = kstrtoul(tmp_buf, WWPN_LEN, (ulong *)&wwpn[k]);
> -		if (unlikely(rc)) {
> -			dev_err(dev, "%s: WWPN conversion failed for port %d\n",
> -				__func__, k);
> -			rc = -ENODEV;
> -			goto out;
> -		}
> -
> -		dev_dbg(dev, "%s: wwpn%d=%016llx\n", __func__, k, wwpn[k]);
> -	}
> -
> -out:
> -	dev_dbg(dev, "%s: returning rc=%d\n", __func__, rc);
> -	return rc;
> -}
> -
> -/**
> - * init_pcr() - initialize the provisioning and control registers
> - * @cfg:	Internal structure associated with the host.
> - *
> - * Also sets up fast access to the mapped registers and initializes AFU
> - * command fields that never change.
> - */
> -static void init_pcr(struct cxlflash_cfg *cfg)
> -{
> -	struct afu *afu = cfg->afu;
> -	struct sisl_ctrl_map __iomem *ctrl_map;
> -	struct hwq *hwq;
> -	void *cookie;
> -	int i;
> -
> -	for (i = 0; i < MAX_CONTEXT; i++) {
> -		ctrl_map = &afu->afu_map->ctrls[i].ctrl;
> -		/* Disrupt any clients that could be running */
> -		/* e.g. clients that survived a master restart */
> -		writeq_be(0, &ctrl_map->rht_start);
> -		writeq_be(0, &ctrl_map->rht_cnt_id);
> -		writeq_be(0, &ctrl_map->ctx_cap);
> -	}
> -
> -	/* Copy frequently used fields into hwq */
> -	for (i = 0; i < afu->num_hwqs; i++) {
> -		hwq = get_hwq(afu, i);
> -		cookie = hwq->ctx_cookie;
> -
> -		hwq->ctx_hndl = (u16) cfg->ops->process_element(cookie);
> -		hwq->host_map = &afu->afu_map->hosts[hwq->ctx_hndl].host;
> -		hwq->ctrl_map = &afu->afu_map->ctrls[hwq->ctx_hndl].ctrl;
> -
> -		/* Program the Endian Control for the master context */
> -		writeq_be(SISL_ENDIAN_CTRL, &hwq->host_map->endian_ctrl);
> -	}
> -}
> -
> -/**
> - * init_global() - initialize AFU global registers
> - * @cfg:	Internal structure associated with the host.
> - */
> -static int init_global(struct cxlflash_cfg *cfg)
> -{
> -	struct afu *afu = cfg->afu;
> -	struct device *dev = &cfg->dev->dev;
> -	struct hwq *hwq;
> -	struct sisl_host_map __iomem *hmap;
> -	__be64 __iomem *fc_port_regs;
> -	u64 wwpn[MAX_FC_PORTS];	/* wwpn of AFU ports */
> -	int i = 0, num_ports = 0;
> -	int rc = 0;
> -	int j;
> -	void *ctx;
> -	u64 reg;
> -
> -	rc = read_vpd(cfg, &wwpn[0]);
> -	if (rc) {
> -		dev_err(dev, "%s: could not read vpd rc=%d\n", __func__, rc);
> -		goto out;
> -	}
> -
> -	/* Set up RRQ and SQ in HWQ for master issued cmds */
> -	for (i = 0; i < afu->num_hwqs; i++) {
> -		hwq = get_hwq(afu, i);
> -		hmap = hwq->host_map;
> -
> -		writeq_be((u64) hwq->hrrq_start, &hmap->rrq_start);
> -		writeq_be((u64) hwq->hrrq_end, &hmap->rrq_end);
> -		hwq->hrrq_online = true;
> -
> -		if (afu_is_sq_cmd_mode(afu)) {
> -			writeq_be((u64)hwq->hsq_start, &hmap->sq_start);
> -			writeq_be((u64)hwq->hsq_end, &hmap->sq_end);
> -		}
> -	}
> -
> -	/* AFU configuration */
> -	reg = readq_be(&afu->afu_map->global.regs.afu_config);
> -	reg |= SISL_AFUCONF_AR_ALL|SISL_AFUCONF_ENDIAN;
> -	/* enable all auto retry options and control endianness */
> -	/* leave others at default: */
> -	/* CTX_CAP write protected, mbox_r does not clear on read and */
> -	/* checker on if dual afu */
> -	writeq_be(reg, &afu->afu_map->global.regs.afu_config);
> -
> -	/* Global port select: select either port */
> -	if (afu->internal_lun) {
> -		/* Only use port 0 */
> -		writeq_be(PORT0, &afu->afu_map->global.regs.afu_port_sel);
> -		num_ports = 0;
> -	} else {
> -		writeq_be(PORT_MASK(cfg->num_fc_ports),
> -			  &afu->afu_map->global.regs.afu_port_sel);
> -		num_ports = cfg->num_fc_ports;
> -	}
> -
> -	for (i = 0; i < num_ports; i++) {
> -		fc_port_regs = get_fc_port_regs(cfg, i);
> -
> -		/* Unmask all errors (but they are still masked at AFU) */
> -		writeq_be(0, &fc_port_regs[FC_ERRMSK / 8]);
> -		/* Clear CRC error cnt & set a threshold */
> -		(void)readq_be(&fc_port_regs[FC_CNT_CRCERR / 8]);
> -		writeq_be(MC_CRC_THRESH, &fc_port_regs[FC_CRC_THRESH / 8]);
> -
> -		/* Set WWPNs. If already programmed, wwpn[i] is 0 */
> -		if (wwpn[i] != 0)
> -			afu_set_wwpn(afu, i, &fc_port_regs[0], wwpn[i]);
> -		/* Programming WWPN back to back causes additional
> -		 * offline/online transitions and a PLOGI
> -		 */
> -		msleep(100);
> -	}
> -
> -	if (afu_is_ocxl_lisn(afu)) {
> -		/* Set up the LISN effective address for each master */
> -		for (i = 0; i < afu->num_hwqs; i++) {
> -			hwq = get_hwq(afu, i);
> -			ctx = hwq->ctx_cookie;
> -
> -			for (j = 0; j < hwq->num_irqs; j++) {
> -				reg = cfg->ops->get_irq_objhndl(ctx, j);
> -				writeq_be(reg, &hwq->ctrl_map->lisn_ea[j]);
> -			}
> -
> -			reg = hwq->ctx_hndl;
> -			writeq_be(SISL_LISN_PASID(reg, reg),
> -				  &hwq->ctrl_map->lisn_pasid[0]);
> -			writeq_be(SISL_LISN_PASID(0UL, reg),
> -				  &hwq->ctrl_map->lisn_pasid[1]);
> -		}
> -	}
> -
> -	/* Set up master's own CTX_CAP to allow real mode, host translation */
> -	/* tables, afu cmds and read/write GSCSI cmds. */
> -	/* First, unlock ctx_cap write by reading mbox */
> -	for (i = 0; i < afu->num_hwqs; i++) {
> -		hwq = get_hwq(afu, i);
> -
> -		(void)readq_be(&hwq->ctrl_map->mbox_r);	/* unlock ctx_cap */
> -		writeq_be((SISL_CTX_CAP_REAL_MODE | SISL_CTX_CAP_HOST_XLATE |
> -			SISL_CTX_CAP_READ_CMD | SISL_CTX_CAP_WRITE_CMD |
> -			SISL_CTX_CAP_AFU_CMD | SISL_CTX_CAP_GSCSI_CMD),
> -			&hwq->ctrl_map->ctx_cap);
> -	}
> -
> -	/*
> -	 * Determine write-same unmap support for host by evaluating the unmap
> -	 * sector support bit of the context control register associated with
> -	 * the primary hardware queue. Note that while this status is reflected
> -	 * in a context register, the outcome can be assumed to be host-wide.
> -	 */
> -	hwq = get_hwq(afu, PRIMARY_HWQ);
> -	reg = readq_be(&hwq->host_map->ctx_ctrl);
> -	if (reg & SISL_CTX_CTRL_UNMAP_SECTOR)
> -		cfg->ws_unmap = true;
> -
> -	/* Initialize heartbeat */
> -	afu->hb = readq_be(&afu->afu_map->global.regs.afu_hb);
> -out:
> -	return rc;
> -}
> -
> -/**
> - * start_afu() - initializes and starts the AFU
> - * @cfg:	Internal structure associated with the host.
> - */
> -static int start_afu(struct cxlflash_cfg *cfg)
> -{
> -	struct afu *afu = cfg->afu;
> -	struct device *dev = &cfg->dev->dev;
> -	struct hwq *hwq;
> -	int rc = 0;
> -	int i;
> -
> -	init_pcr(cfg);
> -
> -	/* Initialize each HWQ */
> -	for (i = 0; i < afu->num_hwqs; i++) {
> -		hwq = get_hwq(afu, i);
> -
> -		/* After an AFU reset, RRQ entries are stale, clear them */
> -		memset(&hwq->rrq_entry, 0, sizeof(hwq->rrq_entry));
> -
> -		/* Initialize RRQ pointers */
> -		hwq->hrrq_start = &hwq->rrq_entry[0];
> -		hwq->hrrq_end = &hwq->rrq_entry[NUM_RRQ_ENTRY - 1];
> -		hwq->hrrq_curr = hwq->hrrq_start;
> -		hwq->toggle = 1;
> -
> -		/* Initialize spin locks */
> -		spin_lock_init(&hwq->hrrq_slock);
> -		spin_lock_init(&hwq->hsq_slock);
> -
> -		/* Initialize SQ */
> -		if (afu_is_sq_cmd_mode(afu)) {
> -			memset(&hwq->sq, 0, sizeof(hwq->sq));
> -			hwq->hsq_start = &hwq->sq[0];
> -			hwq->hsq_end = &hwq->sq[NUM_SQ_ENTRY - 1];
> -			hwq->hsq_curr = hwq->hsq_start;
> -
> -			atomic_set(&hwq->hsq_credits, NUM_SQ_ENTRY - 1);
> -		}
> -
> -		/* Initialize IRQ poll */
> -		if (afu_is_irqpoll_enabled(afu))
> -			irq_poll_init(&hwq->irqpoll, afu->irqpoll_weight,
> -				      cxlflash_irqpoll);
> -
> -	}
> -
> -	rc = init_global(cfg);
> -
> -	dev_dbg(dev, "%s: returning rc=%d\n", __func__, rc);
> -	return rc;
> -}
> -
> -/**
> - * init_intr() - setup interrupt handlers for the master context
> - * @cfg:	Internal structure associated with the host.
> - * @hwq:	Hardware queue to initialize.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static enum undo_level init_intr(struct cxlflash_cfg *cfg,
> -				 struct hwq *hwq)
> -{
> -	struct device *dev = &cfg->dev->dev;
> -	void *ctx = hwq->ctx_cookie;
> -	int rc = 0;
> -	enum undo_level level = UNDO_NOOP;
> -	bool is_primary_hwq = (hwq->index == PRIMARY_HWQ);
> -	int num_irqs = hwq->num_irqs;
> -
> -	rc = cfg->ops->allocate_afu_irqs(ctx, num_irqs);
> -	if (unlikely(rc)) {
> -		dev_err(dev, "%s: allocate_afu_irqs failed rc=%d\n",
> -			__func__, rc);
> -		level = UNDO_NOOP;
> -		goto out;
> -	}
> -
> -	rc = cfg->ops->map_afu_irq(ctx, 1, cxlflash_sync_err_irq, hwq,
> -				   "SISL_MSI_SYNC_ERROR");
> -	if (unlikely(rc <= 0)) {
> -		dev_err(dev, "%s: SISL_MSI_SYNC_ERROR map failed\n", __func__);
> -		level = FREE_IRQ;
> -		goto out;
> -	}
> -
> -	rc = cfg->ops->map_afu_irq(ctx, 2, cxlflash_rrq_irq, hwq,
> -				   "SISL_MSI_RRQ_UPDATED");
> -	if (unlikely(rc <= 0)) {
> -		dev_err(dev, "%s: SISL_MSI_RRQ_UPDATED map failed\n", __func__);
> -		level = UNMAP_ONE;
> -		goto out;
> -	}
> -
> -	/* SISL_MSI_ASYNC_ERROR is setup only for the primary HWQ */
> -	if (!is_primary_hwq)
> -		goto out;
> -
> -	rc = cfg->ops->map_afu_irq(ctx, 3, cxlflash_async_err_irq, hwq,
> -				   "SISL_MSI_ASYNC_ERROR");
> -	if (unlikely(rc <= 0)) {
> -		dev_err(dev, "%s: SISL_MSI_ASYNC_ERROR map failed\n", __func__);
> -		level = UNMAP_TWO;
> -		goto out;
> -	}
> -out:
> -	return level;
> -}
> -
> -/**
> - * init_mc() - create and register as the master context
> - * @cfg:	Internal structure associated with the host.
> - * @index:	HWQ Index of the master context.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int init_mc(struct cxlflash_cfg *cfg, u32 index)
> -{
> -	void *ctx;
> -	struct device *dev = &cfg->dev->dev;
> -	struct hwq *hwq = get_hwq(cfg->afu, index);
> -	int rc = 0;
> -	int num_irqs;
> -	enum undo_level level;
> -
> -	hwq->afu = cfg->afu;
> -	hwq->index = index;
> -	INIT_LIST_HEAD(&hwq->pending_cmds);
> -
> -	if (index == PRIMARY_HWQ) {
> -		ctx = cfg->ops->get_context(cfg->dev, cfg->afu_cookie);
> -		num_irqs = 3;
> -	} else {
> -		ctx = cfg->ops->dev_context_init(cfg->dev, cfg->afu_cookie);
> -		num_irqs = 2;
> -	}
> -	if (IS_ERR_OR_NULL(ctx)) {
> -		rc = -ENOMEM;
> -		goto err1;
> -	}
> -
> -	WARN_ON(hwq->ctx_cookie);
> -	hwq->ctx_cookie = ctx;
> -	hwq->num_irqs = num_irqs;
> -
> -	/* Set it up as a master with the CXL */
> -	cfg->ops->set_master(ctx);
> -
> -	/* Reset AFU when initializing primary context */
> -	if (index == PRIMARY_HWQ) {
> -		rc = cfg->ops->afu_reset(ctx);
> -		if (unlikely(rc)) {
> -			dev_err(dev, "%s: AFU reset failed rc=%d\n",
> -				      __func__, rc);
> -			goto err1;
> -		}
> -	}
> -
> -	level = init_intr(cfg, hwq);
> -	if (unlikely(level)) {
> -		dev_err(dev, "%s: interrupt init failed rc=%d\n", __func__, rc);
> -		goto err2;
> -	}
> -
> -	/* Finally, activate the context by starting it */
> -	rc = cfg->ops->start_context(hwq->ctx_cookie);
> -	if (unlikely(rc)) {
> -		dev_err(dev, "%s: start context failed rc=%d\n", __func__, rc);
> -		level = UNMAP_THREE;
> -		goto err2;
> -	}
> -
> -out:
> -	dev_dbg(dev, "%s: returning rc=%d\n", __func__, rc);
> -	return rc;
> -err2:
> -	term_intr(cfg, level, index);
> -	if (index != PRIMARY_HWQ)
> -		cfg->ops->release_context(ctx);
> -err1:
> -	hwq->ctx_cookie = NULL;
> -	goto out;
> -}
> -
> -/**
> - * get_num_afu_ports() - determines and configures the number of AFU ports
> - * @cfg:	Internal structure associated with the host.
> - *
> - * This routine determines the number of AFU ports by converting the global
> - * port selection mask. The converted value is only valid following an AFU
> - * reset (explicit or power-on). This routine must be invoked shortly after
> - * mapping as other routines are dependent on the number of ports during the
> - * initialization sequence.
> - *
> - * To support legacy AFUs that might not have reflected an initial global
> - * port mask (value read is 0), default to the number of ports originally
> - * supported by the cxlflash driver (2) before hardware with other port
> - * offerings was introduced.
> - */
> -static void get_num_afu_ports(struct cxlflash_cfg *cfg)
> -{
> -	struct afu *afu = cfg->afu;
> -	struct device *dev = &cfg->dev->dev;
> -	u64 port_mask;
> -	int num_fc_ports = LEGACY_FC_PORTS;
> -
> -	port_mask = readq_be(&afu->afu_map->global.regs.afu_port_sel);
> -	if (port_mask != 0ULL)
> -		num_fc_ports = min(ilog2(port_mask) + 1, MAX_FC_PORTS);
> -
> -	dev_dbg(dev, "%s: port_mask=%016llx num_fc_ports=%d\n",
> -		__func__, port_mask, num_fc_ports);
> -
> -	cfg->num_fc_ports = num_fc_ports;
> -	cfg->host->max_channel = PORTNUM2CHAN(num_fc_ports);
> -}
> -
> -/**
> - * init_afu() - setup as master context and start AFU
> - * @cfg:	Internal structure associated with the host.
> - *
> - * This routine is a higher level of control for configuring the
> - * AFU on probe and reset paths.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int init_afu(struct cxlflash_cfg *cfg)
> -{
> -	u64 reg;
> -	int rc = 0;
> -	struct afu *afu = cfg->afu;
> -	struct device *dev = &cfg->dev->dev;
> -	struct hwq *hwq;
> -	int i;
> -
> -	cfg->ops->perst_reloads_same_image(cfg->afu_cookie, true);
> -
> -	mutex_init(&afu->sync_active);
> -	afu->num_hwqs = afu->desired_hwqs;
> -	for (i = 0; i < afu->num_hwqs; i++) {
> -		rc = init_mc(cfg, i);
> -		if (rc) {
> -			dev_err(dev, "%s: init_mc failed rc=%d index=%d\n",
> -				__func__, rc, i);
> -			goto err1;
> -		}
> -	}
> -
> -	/* Map the entire MMIO space of the AFU using the first context */
> -	hwq = get_hwq(afu, PRIMARY_HWQ);
> -	afu->afu_map = cfg->ops->psa_map(hwq->ctx_cookie);
> -	if (!afu->afu_map) {
> -		dev_err(dev, "%s: psa_map failed\n", __func__);
> -		rc = -ENOMEM;
> -		goto err1;
> -	}
> -
> -	/* No byte reverse on reading afu_version or string will be backwards */
> -	reg = readq(&afu->afu_map->global.regs.afu_version);
> -	memcpy(afu->version, &reg, sizeof(reg));
> -	afu->interface_version =
> -	    readq_be(&afu->afu_map->global.regs.interface_version);
> -	if ((afu->interface_version + 1) == 0) {
> -		dev_err(dev, "Back level AFU, please upgrade. AFU version %s "
> -			"interface version %016llx\n", afu->version,
> -		       afu->interface_version);
> -		rc = -EINVAL;
> -		goto err1;
> -	}
> -
> -	if (afu_is_sq_cmd_mode(afu)) {
> -		afu->send_cmd = send_cmd_sq;
> -		afu->context_reset = context_reset_sq;
> -	} else {
> -		afu->send_cmd = send_cmd_ioarrin;
> -		afu->context_reset = context_reset_ioarrin;
> -	}
> -
> -	dev_dbg(dev, "%s: afu_ver=%s interface_ver=%016llx\n", __func__,
> -		afu->version, afu->interface_version);
> -
> -	get_num_afu_ports(cfg);
> -
> -	rc = start_afu(cfg);
> -	if (rc) {
> -		dev_err(dev, "%s: start_afu failed, rc=%d\n", __func__, rc);
> -		goto err1;
> -	}
> -
> -	afu_err_intr_init(cfg->afu);
> -	for (i = 0; i < afu->num_hwqs; i++) {
> -		hwq = get_hwq(afu, i);
> -
> -		hwq->room = readq_be(&hwq->host_map->cmd_room);
> -	}
> -
> -	/* Restore the LUN mappings */
> -	cxlflash_restore_luntable(cfg);
> -out:
> -	dev_dbg(dev, "%s: returning rc=%d\n", __func__, rc);
> -	return rc;
> -
> -err1:
> -	for (i = afu->num_hwqs - 1; i >= 0; i--) {
> -		term_intr(cfg, UNMAP_THREE, i);
> -		term_mc(cfg, i);
> -	}
> -	goto out;
> -}
> -
> -/**
> - * afu_reset() - resets the AFU
> - * @cfg:	Internal structure associated with the host.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int afu_reset(struct cxlflash_cfg *cfg)
> -{
> -	struct device *dev = &cfg->dev->dev;
> -	int rc = 0;
> -
> -	/* Stop the context before the reset. Since the context is
> -	 * no longer available restart it after the reset is complete
> -	 */
> -	term_afu(cfg);
> -
> -	rc = init_afu(cfg);
> -
> -	dev_dbg(dev, "%s: returning rc=%d\n", __func__, rc);
> -	return rc;
> -}
> -
> -/**
> - * drain_ioctls() - wait until all currently executing ioctls have completed
> - * @cfg:	Internal structure associated with the host.
> - *
> - * Obtain write access to read/write semaphore that wraps ioctl
> - * handling to 'drain' ioctls currently executing.
> - */
> -static void drain_ioctls(struct cxlflash_cfg *cfg)
> -{
> -	down_write(&cfg->ioctl_rwsem);
> -	up_write(&cfg->ioctl_rwsem);
> -}
> -
> -/**
> - * cxlflash_async_reset_host() - asynchronous host reset handler
> - * @data:	Private data provided while scheduling reset.
> - * @cookie:	Cookie that can be used for checkpointing.
> - */
> -static void cxlflash_async_reset_host(void *data, async_cookie_t cookie)
> -{
> -	struct cxlflash_cfg *cfg = data;
> -	struct device *dev = &cfg->dev->dev;
> -	int rc = 0;
> -
> -	if (cfg->state != STATE_RESET) {
> -		dev_dbg(dev, "%s: Not performing a reset, state=%d\n",
> -			__func__, cfg->state);
> -		goto out;
> -	}
> -
> -	drain_ioctls(cfg);
> -	cxlflash_mark_contexts_error(cfg);
> -	rc = afu_reset(cfg);
> -	if (rc)
> -		cfg->state = STATE_FAILTERM;
> -	else
> -		cfg->state = STATE_NORMAL;
> -	wake_up_all(&cfg->reset_waitq);
> -
> -out:
> -	scsi_unblock_requests(cfg->host);
> -}
> -
> -/**
> - * cxlflash_schedule_async_reset() - schedule an asynchronous host reset
> - * @cfg:	Internal structure associated with the host.
> - */
> -static void cxlflash_schedule_async_reset(struct cxlflash_cfg *cfg)
> -{
> -	struct device *dev = &cfg->dev->dev;
> -
> -	if (cfg->state != STATE_NORMAL) {
> -		dev_dbg(dev, "%s: Not performing reset state=%d\n",
> -			__func__, cfg->state);
> -		return;
> -	}
> -
> -	cfg->state = STATE_RESET;
> -	scsi_block_requests(cfg->host);
> -	cfg->async_reset_cookie = async_schedule(cxlflash_async_reset_host,
> -						 cfg);
> -}
> -
> -/**
> - * send_afu_cmd() - builds and sends an internal AFU command
> - * @afu:	AFU associated with the host.
> - * @rcb:	Pre-populated IOARCB describing command to send.
> - *
> - * The AFU can only take one internal AFU command at a time. This limitation is
> - * enforced by using a mutex to provide exclusive access to the AFU during the
> - * operation. This design point requires calling threads to not be on interrupt
> - * context due to the possibility of sleeping during concurrent AFU operations.
> - *
> - * The command status is optionally passed back to the caller when the caller
> - * populates the IOASA field of the IOARCB with a pointer to an IOASA structure.
> - *
> - * Return:
> - *	0 on success, -errno on failure
> - */
> -static int send_afu_cmd(struct afu *afu, struct sisl_ioarcb *rcb)
> -{
> -	struct cxlflash_cfg *cfg = afu->parent;
> -	struct device *dev = &cfg->dev->dev;
> -	struct afu_cmd *cmd = NULL;
> -	struct hwq *hwq = get_hwq(afu, PRIMARY_HWQ);
> -	ulong lock_flags;
> -	char *buf = NULL;
> -	int rc = 0;
> -	int nretry = 0;
> -
> -	if (cfg->state != STATE_NORMAL) {
> -		dev_dbg(dev, "%s: Sync not required state=%u\n",
> -			__func__, cfg->state);
> -		return 0;
> -	}
> -
> -	mutex_lock(&afu->sync_active);
> -	atomic_inc(&afu->cmds_active);
> -	buf = kmalloc(sizeof(*cmd) + __alignof__(*cmd) - 1, GFP_KERNEL);
> -	if (unlikely(!buf)) {
> -		dev_err(dev, "%s: no memory for command\n", __func__);
> -		rc = -ENOMEM;
> -		goto out;
> -	}
> -
> -	cmd = (struct afu_cmd *)PTR_ALIGN(buf, __alignof__(*cmd));
> -
> -retry:
> -	memset(cmd, 0, sizeof(*cmd));
> -	memcpy(&cmd->rcb, rcb, sizeof(*rcb));
> -	INIT_LIST_HEAD(&cmd->queue);
> -	init_completion(&cmd->cevent);
> -	cmd->parent = afu;
> -	cmd->hwq_index = hwq->index;
> -	cmd->rcb.ctx_id = hwq->ctx_hndl;
> -
> -	dev_dbg(dev, "%s: afu=%p cmd=%p type=%02x nretry=%d\n",
> -		__func__, afu, cmd, cmd->rcb.cdb[0], nretry);
> -
> -	rc = afu->send_cmd(afu, cmd);
> -	if (unlikely(rc)) {
> -		rc = -ENOBUFS;
> -		goto out;
> -	}
> -
> -	rc = wait_resp(afu, cmd);
> -	switch (rc) {
> -	case -ETIMEDOUT:
> -		rc = afu->context_reset(hwq);
> -		if (rc) {
> -			/* Delete the command from pending_cmds list */
> -			spin_lock_irqsave(&hwq->hsq_slock, lock_flags);
> -			list_del(&cmd->list);
> -			spin_unlock_irqrestore(&hwq->hsq_slock, lock_flags);
> -
> -			cxlflash_schedule_async_reset(cfg);
> -			break;
> -		}
> -		fallthrough;	/* to retry */
> -	case -EAGAIN:
> -		if (++nretry < 2)
> -			goto retry;
> -		fallthrough;	/* to exit */
> -	default:
> -		break;
> -	}
> -
> -	if (rcb->ioasa)
> -		*rcb->ioasa = cmd->sa;
> -out:
> -	atomic_dec(&afu->cmds_active);
> -	mutex_unlock(&afu->sync_active);
> -	kfree(buf);
> -	dev_dbg(dev, "%s: returning rc=%d\n", __func__, rc);
> -	return rc;
> -}
> -
> -/**
> - * cxlflash_afu_sync() - builds and sends an AFU sync command
> - * @afu:	AFU associated with the host.
> - * @ctx:	Identifies context requesting sync.
> - * @res:	Identifies resource requesting sync.
> - * @mode:	Type of sync to issue (lightweight, heavyweight, global).
> - *
> - * AFU sync operations are only necessary and allowed when the device is
> - * operating normally. When not operating normally, sync requests can occur as
> - * part of cleaning up resources associated with an adapter prior to removal.
> - * In this scenario, these requests are simply ignored (safe due to the AFU
> - * going away).
> - *
> - * Return:
> - *	0 on success, -errno on failure
> - */
> -int cxlflash_afu_sync(struct afu *afu, ctx_hndl_t ctx, res_hndl_t res, u8 mode)
> -{
> -	struct cxlflash_cfg *cfg = afu->parent;
> -	struct device *dev = &cfg->dev->dev;
> -	struct sisl_ioarcb rcb = { 0 };
> -
> -	dev_dbg(dev, "%s: afu=%p ctx=%u res=%u mode=%u\n",
> -		__func__, afu, ctx, res, mode);
> -
> -	rcb.req_flags = SISL_REQ_FLAGS_AFU_CMD;
> -	rcb.msi = SISL_MSI_RRQ_UPDATED;
> -	rcb.timeout = MC_AFU_SYNC_TIMEOUT;
> -
> -	rcb.cdb[0] = SISL_AFU_CMD_SYNC;
> -	rcb.cdb[1] = mode;
> -	put_unaligned_be16(ctx, &rcb.cdb[2]);
> -	put_unaligned_be32(res, &rcb.cdb[4]);
> -
> -	return send_afu_cmd(afu, &rcb);
> -}
> -
> -/**
> - * cxlflash_eh_abort_handler() - abort a SCSI command
> - * @scp:	SCSI command to abort.
> - *
> - * CXL Flash devices do not support a single command abort. Reset the context
> - * as per SISLite specification. Flush any pending commands in the hardware
> - * queue before the reset.
> - *
> - * Return: SUCCESS/FAILED as defined in scsi/scsi.h
> - */
> -static int cxlflash_eh_abort_handler(struct scsi_cmnd *scp)
> -{
> -	int rc = FAILED;
> -	struct Scsi_Host *host = scp->device->host;
> -	struct cxlflash_cfg *cfg = shost_priv(host);
> -	struct afu_cmd *cmd = sc_to_afuc(scp);
> -	struct device *dev = &cfg->dev->dev;
> -	struct afu *afu = cfg->afu;
> -	struct hwq *hwq = get_hwq(afu, cmd->hwq_index);
> -
> -	dev_dbg(dev, "%s: (scp=%p) %d/%d/%d/%llu "
> -		"cdb=(%08x-%08x-%08x-%08x)\n", __func__, scp, host->host_no,
> -		scp->device->channel, scp->device->id, scp->device->lun,
> -		get_unaligned_be32(&((u32 *)scp->cmnd)[0]),
> -		get_unaligned_be32(&((u32 *)scp->cmnd)[1]),
> -		get_unaligned_be32(&((u32 *)scp->cmnd)[2]),
> -		get_unaligned_be32(&((u32 *)scp->cmnd)[3]));
> -
> -	/* When the state is not normal, another reset/reload is in progress.
> -	 * Return failed and the mid-layer will invoke host reset handler.
> -	 */
> -	if (cfg->state != STATE_NORMAL) {
> -		dev_dbg(dev, "%s: Invalid state for abort, state=%d\n",
> -			__func__, cfg->state);
> -		goto out;
> -	}
> -
> -	rc = afu->context_reset(hwq);
> -	if (unlikely(rc))
> -		goto out;
> -
> -	rc = SUCCESS;
> -
> -out:
> -	dev_dbg(dev, "%s: returning rc=%d\n", __func__, rc);
> -	return rc;
> -}
> -
> -/**
> - * cxlflash_eh_device_reset_handler() - reset a single LUN
> - * @scp:	SCSI command to send.
> - *
> - * Return:
> - *	SUCCESS as defined in scsi/scsi.h
> - *	FAILED as defined in scsi/scsi.h
> - */
> -static int cxlflash_eh_device_reset_handler(struct scsi_cmnd *scp)
> -{
> -	int rc = SUCCESS;
> -	struct scsi_device *sdev = scp->device;
> -	struct Scsi_Host *host = sdev->host;
> -	struct cxlflash_cfg *cfg = shost_priv(host);
> -	struct device *dev = &cfg->dev->dev;
> -	int rcr = 0;
> -
> -	dev_dbg(dev, "%s: %d/%d/%d/%llu\n", __func__,
> -		host->host_no, sdev->channel, sdev->id, sdev->lun);
> -retry:
> -	switch (cfg->state) {
> -	case STATE_NORMAL:
> -		rcr = send_tmf(cfg, sdev, TMF_LUN_RESET);
> -		if (unlikely(rcr))
> -			rc = FAILED;
> -		break;
> -	case STATE_RESET:
> -		wait_event(cfg->reset_waitq, cfg->state != STATE_RESET);
> -		goto retry;
> -	default:
> -		rc = FAILED;
> -		break;
> -	}
> -
> -	dev_dbg(dev, "%s: returning rc=%d\n", __func__, rc);
> -	return rc;
> -}
> -
> -/**
> - * cxlflash_eh_host_reset_handler() - reset the host adapter
> - * @scp:	SCSI command from stack identifying host.
> - *
> - * Following a reset, the state is evaluated again in case an EEH occurred
> - * during the reset. In such a scenario, the host reset will either yield
> - * until the EEH recovery is complete or return success or failure based
> - * upon the current device state.
> - *
> - * Return:
> - *	SUCCESS as defined in scsi/scsi.h
> - *	FAILED as defined in scsi/scsi.h
> - */
> -static int cxlflash_eh_host_reset_handler(struct scsi_cmnd *scp)
> -{
> -	int rc = SUCCESS;
> -	int rcr = 0;
> -	struct Scsi_Host *host = scp->device->host;
> -	struct cxlflash_cfg *cfg = shost_priv(host);
> -	struct device *dev = &cfg->dev->dev;
> -
> -	dev_dbg(dev, "%s: %d\n", __func__, host->host_no);
> -
> -	switch (cfg->state) {
> -	case STATE_NORMAL:
> -		cfg->state = STATE_RESET;
> -		drain_ioctls(cfg);
> -		cxlflash_mark_contexts_error(cfg);
> -		rcr = afu_reset(cfg);
> -		if (rcr) {
> -			rc = FAILED;
> -			cfg->state = STATE_FAILTERM;
> -		} else
> -			cfg->state = STATE_NORMAL;
> -		wake_up_all(&cfg->reset_waitq);
> -		ssleep(1);
> -		fallthrough;
> -	case STATE_RESET:
> -		wait_event(cfg->reset_waitq, cfg->state != STATE_RESET);
> -		if (cfg->state == STATE_NORMAL)
> -			break;
> -		fallthrough;
> -	default:
> -		rc = FAILED;
> -		break;
> -	}
> -
> -	dev_dbg(dev, "%s: returning rc=%d\n", __func__, rc);
> -	return rc;
> -}
> -
> -/**
> - * cxlflash_change_queue_depth() - change the queue depth for the device
> - * @sdev:	SCSI device destined for queue depth change.
> - * @qdepth:	Requested queue depth value to set.
> - *
> - * The requested queue depth is capped to the maximum supported value.
> - *
> - * Return: The actual queue depth set.
> - */
> -static int cxlflash_change_queue_depth(struct scsi_device *sdev, int qdepth)
> -{
> -
> -	if (qdepth > CXLFLASH_MAX_CMDS_PER_LUN)
> -		qdepth = CXLFLASH_MAX_CMDS_PER_LUN;
> -
> -	scsi_change_queue_depth(sdev, qdepth);
> -	return sdev->queue_depth;
> -}
> -
> -/**
> - * cxlflash_show_port_status() - queries and presents the current port status
> - * @port:	Desired port for status reporting.
> - * @cfg:	Internal structure associated with the host.
> - * @buf:	Buffer of length PAGE_SIZE to report back port status in ASCII.
> - *
> - * Return: The size of the ASCII string returned in @buf or -EINVAL.
> - */
> -static ssize_t cxlflash_show_port_status(u32 port,
> -					 struct cxlflash_cfg *cfg,
> -					 char *buf)
> -{
> -	struct device *dev = &cfg->dev->dev;
> -	char *disp_status;
> -	u64 status;
> -	__be64 __iomem *fc_port_regs;
> -
> -	WARN_ON(port >= MAX_FC_PORTS);
> -
> -	if (port >= cfg->num_fc_ports) {
> -		dev_info(dev, "%s: Port %d not supported on this card.\n",
> -			__func__, port);
> -		return -EINVAL;
> -	}
> -
> -	fc_port_regs = get_fc_port_regs(cfg, port);
> -	status = readq_be(&fc_port_regs[FC_MTIP_STATUS / 8]);
> -	status &= FC_MTIP_STATUS_MASK;
> -
> -	if (status == FC_MTIP_STATUS_ONLINE)
> -		disp_status = "online";
> -	else if (status == FC_MTIP_STATUS_OFFLINE)
> -		disp_status = "offline";
> -	else
> -		disp_status = "unknown";
> -
> -	return scnprintf(buf, PAGE_SIZE, "%s\n", disp_status);
> -}
> -
> -/**
> - * port0_show() - queries and presents the current status of port 0
> - * @dev:	Generic device associated with the host owning the port.
> - * @attr:	Device attribute representing the port.
> - * @buf:	Buffer of length PAGE_SIZE to report back port status in ASCII.
> - *
> - * Return: The size of the ASCII string returned in @buf.
> - */
> -static ssize_t port0_show(struct device *dev,
> -			  struct device_attribute *attr,
> -			  char *buf)
> -{
> -	struct cxlflash_cfg *cfg = shost_priv(class_to_shost(dev));
> -
> -	return cxlflash_show_port_status(0, cfg, buf);
> -}
> -
> -/**
> - * port1_show() - queries and presents the current status of port 1
> - * @dev:	Generic device associated with the host owning the port.
> - * @attr:	Device attribute representing the port.
> - * @buf:	Buffer of length PAGE_SIZE to report back port status in ASCII.
> - *
> - * Return: The size of the ASCII string returned in @buf.
> - */
> -static ssize_t port1_show(struct device *dev,
> -			  struct device_attribute *attr,
> -			  char *buf)
> -{
> -	struct cxlflash_cfg *cfg = shost_priv(class_to_shost(dev));
> -
> -	return cxlflash_show_port_status(1, cfg, buf);
> -}
> -
> -/**
> - * port2_show() - queries and presents the current status of port 2
> - * @dev:	Generic device associated with the host owning the port.
> - * @attr:	Device attribute representing the port.
> - * @buf:	Buffer of length PAGE_SIZE to report back port status in ASCII.
> - *
> - * Return: The size of the ASCII string returned in @buf.
> - */
> -static ssize_t port2_show(struct device *dev,
> -			  struct device_attribute *attr,
> -			  char *buf)
> -{
> -	struct cxlflash_cfg *cfg = shost_priv(class_to_shost(dev));
> -
> -	return cxlflash_show_port_status(2, cfg, buf);
> -}
> -
> -/**
> - * port3_show() - queries and presents the current status of port 3
> - * @dev:	Generic device associated with the host owning the port.
> - * @attr:	Device attribute representing the port.
> - * @buf:	Buffer of length PAGE_SIZE to report back port status in ASCII.
> - *
> - * Return: The size of the ASCII string returned in @buf.
> - */
> -static ssize_t port3_show(struct device *dev,
> -			  struct device_attribute *attr,
> -			  char *buf)
> -{
> -	struct cxlflash_cfg *cfg = shost_priv(class_to_shost(dev));
> -
> -	return cxlflash_show_port_status(3, cfg, buf);
> -}
> -
> -/**
> - * lun_mode_show() - presents the current LUN mode of the host
> - * @dev:	Generic device associated with the host.
> - * @attr:	Device attribute representing the LUN mode.
> - * @buf:	Buffer of length PAGE_SIZE to report back the LUN mode in ASCII.
> - *
> - * Return: The size of the ASCII string returned in @buf.
> - */
> -static ssize_t lun_mode_show(struct device *dev,
> -			     struct device_attribute *attr, char *buf)
> -{
> -	struct cxlflash_cfg *cfg = shost_priv(class_to_shost(dev));
> -	struct afu *afu = cfg->afu;
> -
> -	return scnprintf(buf, PAGE_SIZE, "%u\n", afu->internal_lun);
> -}
> -
> -/**
> - * lun_mode_store() - sets the LUN mode of the host
> - * @dev:	Generic device associated with the host.
> - * @attr:	Device attribute representing the LUN mode.
> - * @buf:	Buffer of length PAGE_SIZE containing the LUN mode in ASCII.
> - * @count:	Length of data resizing in @buf.
> - *
> - * The CXL Flash AFU supports a dummy LUN mode where the external
> - * links and storage are not required. Space on the FPGA is used
> - * to create 1 or 2 small LUNs which are presented to the system
> - * as if they were a normal storage device. This feature is useful
> - * during development and also provides manufacturing with a way
> - * to test the AFU without an actual device.
> - *
> - * 0 = external LUN[s] (default)
> - * 1 = internal LUN (1 x 64K, 512B blocks, id 0)
> - * 2 = internal LUN (1 x 64K, 4K blocks, id 0)
> - * 3 = internal LUN (2 x 32K, 512B blocks, ids 0,1)
> - * 4 = internal LUN (2 x 32K, 4K blocks, ids 0,1)
> - *
> - * Return: The size of the ASCII string returned in @buf.
> - */
> -static ssize_t lun_mode_store(struct device *dev,
> -			      struct device_attribute *attr,
> -			      const char *buf, size_t count)
> -{
> -	struct Scsi_Host *shost = class_to_shost(dev);
> -	struct cxlflash_cfg *cfg = shost_priv(shost);
> -	struct afu *afu = cfg->afu;
> -	int rc;
> -	u32 lun_mode;
> -
> -	rc = kstrtouint(buf, 10, &lun_mode);
> -	if (!rc && (lun_mode < 5) && (lun_mode != afu->internal_lun)) {
> -		afu->internal_lun = lun_mode;
> -
> -		/*
> -		 * When configured for internal LUN, there is only one channel,
> -		 * channel number 0, else there will be one less than the number
> -		 * of fc ports for this card.
> -		 */
> -		if (afu->internal_lun)
> -			shost->max_channel = 0;
> -		else
> -			shost->max_channel = PORTNUM2CHAN(cfg->num_fc_ports);
> -
> -		afu_reset(cfg);
> -		scsi_scan_host(cfg->host);
> -	}
> -
> -	return count;
> -}
> -
> -/**
> - * ioctl_version_show() - presents the current ioctl version of the host
> - * @dev:	Generic device associated with the host.
> - * @attr:	Device attribute representing the ioctl version.
> - * @buf:	Buffer of length PAGE_SIZE to report back the ioctl version.
> - *
> - * Return: The size of the ASCII string returned in @buf.
> - */
> -static ssize_t ioctl_version_show(struct device *dev,
> -				  struct device_attribute *attr, char *buf)
> -{
> -	ssize_t bytes = 0;
> -
> -	bytes = scnprintf(buf, PAGE_SIZE,
> -			  "disk: %u\n", DK_CXLFLASH_VERSION_0);
> -	bytes += scnprintf(buf + bytes, PAGE_SIZE - bytes,
> -			   "host: %u\n", HT_CXLFLASH_VERSION_0);
> -
> -	return bytes;
> -}
> -
> -/**
> - * cxlflash_show_port_lun_table() - queries and presents the port LUN table
> - * @port:	Desired port for status reporting.
> - * @cfg:	Internal structure associated with the host.
> - * @buf:	Buffer of length PAGE_SIZE to report back port status in ASCII.
> - *
> - * Return: The size of the ASCII string returned in @buf or -EINVAL.
> - */
> -static ssize_t cxlflash_show_port_lun_table(u32 port,
> -					    struct cxlflash_cfg *cfg,
> -					    char *buf)
> -{
> -	struct device *dev = &cfg->dev->dev;
> -	__be64 __iomem *fc_port_luns;
> -	int i;
> -	ssize_t bytes = 0;
> -
> -	WARN_ON(port >= MAX_FC_PORTS);
> -
> -	if (port >= cfg->num_fc_ports) {
> -		dev_info(dev, "%s: Port %d not supported on this card.\n",
> -			__func__, port);
> -		return -EINVAL;
> -	}
> -
> -	fc_port_luns = get_fc_port_luns(cfg, port);
> -
> -	for (i = 0; i < CXLFLASH_NUM_VLUNS; i++)
> -		bytes += scnprintf(buf + bytes, PAGE_SIZE - bytes,
> -				   "%03d: %016llx\n",
> -				   i, readq_be(&fc_port_luns[i]));
> -	return bytes;
> -}
> -
> -/**
> - * port0_lun_table_show() - presents the current LUN table of port 0
> - * @dev:	Generic device associated with the host owning the port.
> - * @attr:	Device attribute representing the port.
> - * @buf:	Buffer of length PAGE_SIZE to report back port status in ASCII.
> - *
> - * Return: The size of the ASCII string returned in @buf.
> - */
> -static ssize_t port0_lun_table_show(struct device *dev,
> -				    struct device_attribute *attr,
> -				    char *buf)
> -{
> -	struct cxlflash_cfg *cfg = shost_priv(class_to_shost(dev));
> -
> -	return cxlflash_show_port_lun_table(0, cfg, buf);
> -}
> -
> -/**
> - * port1_lun_table_show() - presents the current LUN table of port 1
> - * @dev:	Generic device associated with the host owning the port.
> - * @attr:	Device attribute representing the port.
> - * @buf:	Buffer of length PAGE_SIZE to report back port status in ASCII.
> - *
> - * Return: The size of the ASCII string returned in @buf.
> - */
> -static ssize_t port1_lun_table_show(struct device *dev,
> -				    struct device_attribute *attr,
> -				    char *buf)
> -{
> -	struct cxlflash_cfg *cfg = shost_priv(class_to_shost(dev));
> -
> -	return cxlflash_show_port_lun_table(1, cfg, buf);
> -}
> -
> -/**
> - * port2_lun_table_show() - presents the current LUN table of port 2
> - * @dev:	Generic device associated with the host owning the port.
> - * @attr:	Device attribute representing the port.
> - * @buf:	Buffer of length PAGE_SIZE to report back port status in ASCII.
> - *
> - * Return: The size of the ASCII string returned in @buf.
> - */
> -static ssize_t port2_lun_table_show(struct device *dev,
> -				    struct device_attribute *attr,
> -				    char *buf)
> -{
> -	struct cxlflash_cfg *cfg = shost_priv(class_to_shost(dev));
> -
> -	return cxlflash_show_port_lun_table(2, cfg, buf);
> -}
> -
> -/**
> - * port3_lun_table_show() - presents the current LUN table of port 3
> - * @dev:	Generic device associated with the host owning the port.
> - * @attr:	Device attribute representing the port.
> - * @buf:	Buffer of length PAGE_SIZE to report back port status in ASCII.
> - *
> - * Return: The size of the ASCII string returned in @buf.
> - */
> -static ssize_t port3_lun_table_show(struct device *dev,
> -				    struct device_attribute *attr,
> -				    char *buf)
> -{
> -	struct cxlflash_cfg *cfg = shost_priv(class_to_shost(dev));
> -
> -	return cxlflash_show_port_lun_table(3, cfg, buf);
> -}
> -
> -/**
> - * irqpoll_weight_show() - presents the current IRQ poll weight for the host
> - * @dev:	Generic device associated with the host.
> - * @attr:	Device attribute representing the IRQ poll weight.
> - * @buf:	Buffer of length PAGE_SIZE to report back the current IRQ poll
> - *		weight in ASCII.
> - *
> - * An IRQ poll weight of 0 indicates polling is disabled.
> - *
> - * Return: The size of the ASCII string returned in @buf.
> - */
> -static ssize_t irqpoll_weight_show(struct device *dev,
> -				   struct device_attribute *attr, char *buf)
> -{
> -	struct cxlflash_cfg *cfg = shost_priv(class_to_shost(dev));
> -	struct afu *afu = cfg->afu;
> -
> -	return scnprintf(buf, PAGE_SIZE, "%u\n", afu->irqpoll_weight);
> -}
> -
> -/**
> - * irqpoll_weight_store() - sets the current IRQ poll weight for the host
> - * @dev:	Generic device associated with the host.
> - * @attr:	Device attribute representing the IRQ poll weight.
> - * @buf:	Buffer of length PAGE_SIZE containing the desired IRQ poll
> - *		weight in ASCII.
> - * @count:	Length of data resizing in @buf.
> - *
> - * An IRQ poll weight of 0 indicates polling is disabled.
> - *
> - * Return: The size of the ASCII string returned in @buf.
> - */
> -static ssize_t irqpoll_weight_store(struct device *dev,
> -				    struct device_attribute *attr,
> -				    const char *buf, size_t count)
> -{
> -	struct cxlflash_cfg *cfg = shost_priv(class_to_shost(dev));
> -	struct device *cfgdev = &cfg->dev->dev;
> -	struct afu *afu = cfg->afu;
> -	struct hwq *hwq;
> -	u32 weight;
> -	int rc, i;
> -
> -	rc = kstrtouint(buf, 10, &weight);
> -	if (rc)
> -		return -EINVAL;
> -
> -	if (weight > 256) {
> -		dev_info(cfgdev,
> -			 "Invalid IRQ poll weight. It must be 256 or less.\n");
> -		return -EINVAL;
> -	}
> -
> -	if (weight == afu->irqpoll_weight) {
> -		dev_info(cfgdev,
> -			 "Current IRQ poll weight has the same weight.\n");
> -		return -EINVAL;
> -	}
> -
> -	if (afu_is_irqpoll_enabled(afu)) {
> -		for (i = 0; i < afu->num_hwqs; i++) {
> -			hwq = get_hwq(afu, i);
> -
> -			irq_poll_disable(&hwq->irqpoll);
> -		}
> -	}
> -
> -	afu->irqpoll_weight = weight;
> -
> -	if (weight > 0) {
> -		for (i = 0; i < afu->num_hwqs; i++) {
> -			hwq = get_hwq(afu, i);
> -
> -			irq_poll_init(&hwq->irqpoll, weight, cxlflash_irqpoll);
> -		}
> -	}
> -
> -	return count;
> -}
> -
> -/**
> - * num_hwqs_show() - presents the number of hardware queues for the host
> - * @dev:	Generic device associated with the host.
> - * @attr:	Device attribute representing the number of hardware queues.
> - * @buf:	Buffer of length PAGE_SIZE to report back the number of hardware
> - *		queues in ASCII.
> - *
> - * Return: The size of the ASCII string returned in @buf.
> - */
> -static ssize_t num_hwqs_show(struct device *dev,
> -			     struct device_attribute *attr, char *buf)
> -{
> -	struct cxlflash_cfg *cfg = shost_priv(class_to_shost(dev));
> -	struct afu *afu = cfg->afu;
> -
> -	return scnprintf(buf, PAGE_SIZE, "%u\n", afu->num_hwqs);
> -}
> -
> -/**
> - * num_hwqs_store() - sets the number of hardware queues for the host
> - * @dev:	Generic device associated with the host.
> - * @attr:	Device attribute representing the number of hardware queues.
> - * @buf:	Buffer of length PAGE_SIZE containing the number of hardware
> - *		queues in ASCII.
> - * @count:	Length of data resizing in @buf.
> - *
> - * n > 0: num_hwqs = n
> - * n = 0: num_hwqs = num_online_cpus()
> - * n < 0: num_online_cpus() / abs(n)
> - *
> - * Return: The size of the ASCII string returned in @buf.
> - */
> -static ssize_t num_hwqs_store(struct device *dev,
> -			      struct device_attribute *attr,
> -			      const char *buf, size_t count)
> -{
> -	struct cxlflash_cfg *cfg = shost_priv(class_to_shost(dev));
> -	struct afu *afu = cfg->afu;
> -	int rc;
> -	int nhwqs, num_hwqs;
> -
> -	rc = kstrtoint(buf, 10, &nhwqs);
> -	if (rc)
> -		return -EINVAL;
> -
> -	if (nhwqs >= 1)
> -		num_hwqs = nhwqs;
> -	else if (nhwqs == 0)
> -		num_hwqs = num_online_cpus();
> -	else
> -		num_hwqs = num_online_cpus() / abs(nhwqs);
> -
> -	afu->desired_hwqs = min(num_hwqs, CXLFLASH_MAX_HWQS);
> -	WARN_ON_ONCE(afu->desired_hwqs == 0);
> -
> -retry:
> -	switch (cfg->state) {
> -	case STATE_NORMAL:
> -		cfg->state = STATE_RESET;
> -		drain_ioctls(cfg);
> -		cxlflash_mark_contexts_error(cfg);
> -		rc = afu_reset(cfg);
> -		if (rc)
> -			cfg->state = STATE_FAILTERM;
> -		else
> -			cfg->state = STATE_NORMAL;
> -		wake_up_all(&cfg->reset_waitq);
> -		break;
> -	case STATE_RESET:
> -		wait_event(cfg->reset_waitq, cfg->state != STATE_RESET);
> -		if (cfg->state == STATE_NORMAL)
> -			goto retry;
> -		fallthrough;
> -	default:
> -		/* Ideally should not happen */
> -		dev_err(dev, "%s: Device is not ready, state=%d\n",
> -			__func__, cfg->state);
> -		break;
> -	}
> -
> -	return count;
> -}
> -
> -static const char *hwq_mode_name[MAX_HWQ_MODE] = { "rr", "tag", "cpu" };
> -
> -/**
> - * hwq_mode_show() - presents the HWQ steering mode for the host
> - * @dev:	Generic device associated with the host.
> - * @attr:	Device attribute representing the HWQ steering mode.
> - * @buf:	Buffer of length PAGE_SIZE to report back the HWQ steering mode
> - *		as a character string.
> - *
> - * Return: The size of the ASCII string returned in @buf.
> - */
> -static ssize_t hwq_mode_show(struct device *dev,
> -			     struct device_attribute *attr, char *buf)
> -{
> -	struct cxlflash_cfg *cfg = shost_priv(class_to_shost(dev));
> -	struct afu *afu = cfg->afu;
> -
> -	return scnprintf(buf, PAGE_SIZE, "%s\n", hwq_mode_name[afu->hwq_mode]);
> -}
> -
> -/**
> - * hwq_mode_store() - sets the HWQ steering mode for the host
> - * @dev:	Generic device associated with the host.
> - * @attr:	Device attribute representing the HWQ steering mode.
> - * @buf:	Buffer of length PAGE_SIZE containing the HWQ steering mode
> - *		as a character string.
> - * @count:	Length of data resizing in @buf.
> - *
> - * rr = Round-Robin
> - * tag = Block MQ Tagging
> - * cpu = CPU Affinity
> - *
> - * Return: The size of the ASCII string returned in @buf.
> - */
> -static ssize_t hwq_mode_store(struct device *dev,
> -			      struct device_attribute *attr,
> -			      const char *buf, size_t count)
> -{
> -	struct Scsi_Host *shost = class_to_shost(dev);
> -	struct cxlflash_cfg *cfg = shost_priv(shost);
> -	struct device *cfgdev = &cfg->dev->dev;
> -	struct afu *afu = cfg->afu;
> -	int i;
> -	u32 mode = MAX_HWQ_MODE;
> -
> -	for (i = 0; i < MAX_HWQ_MODE; i++) {
> -		if (!strncmp(hwq_mode_name[i], buf, strlen(hwq_mode_name[i]))) {
> -			mode = i;
> -			break;
> -		}
> -	}
> -
> -	if (mode >= MAX_HWQ_MODE) {
> -		dev_info(cfgdev, "Invalid HWQ steering mode.\n");
> -		return -EINVAL;
> -	}
> -
> -	afu->hwq_mode = mode;
> -
> -	return count;
> -}
> -
> -/**
> - * mode_show() - presents the current mode of the device
> - * @dev:	Generic device associated with the device.
> - * @attr:	Device attribute representing the device mode.
> - * @buf:	Buffer of length PAGE_SIZE to report back the dev mode in ASCII.
> - *
> - * Return: The size of the ASCII string returned in @buf.
> - */
> -static ssize_t mode_show(struct device *dev,
> -			 struct device_attribute *attr, char *buf)
> -{
> -	struct scsi_device *sdev = to_scsi_device(dev);
> -
> -	return scnprintf(buf, PAGE_SIZE, "%s\n",
> -			 sdev->hostdata ? "superpipe" : "legacy");
> -}
> -
> -/*
> - * Host attributes
> - */
> -static DEVICE_ATTR_RO(port0);
> -static DEVICE_ATTR_RO(port1);
> -static DEVICE_ATTR_RO(port2);
> -static DEVICE_ATTR_RO(port3);
> -static DEVICE_ATTR_RW(lun_mode);
> -static DEVICE_ATTR_RO(ioctl_version);
> -static DEVICE_ATTR_RO(port0_lun_table);
> -static DEVICE_ATTR_RO(port1_lun_table);
> -static DEVICE_ATTR_RO(port2_lun_table);
> -static DEVICE_ATTR_RO(port3_lun_table);
> -static DEVICE_ATTR_RW(irqpoll_weight);
> -static DEVICE_ATTR_RW(num_hwqs);
> -static DEVICE_ATTR_RW(hwq_mode);
> -
> -static struct attribute *cxlflash_host_attrs[] = {
> -	&dev_attr_port0.attr,
> -	&dev_attr_port1.attr,
> -	&dev_attr_port2.attr,
> -	&dev_attr_port3.attr,
> -	&dev_attr_lun_mode.attr,
> -	&dev_attr_ioctl_version.attr,
> -	&dev_attr_port0_lun_table.attr,
> -	&dev_attr_port1_lun_table.attr,
> -	&dev_attr_port2_lun_table.attr,
> -	&dev_attr_port3_lun_table.attr,
> -	&dev_attr_irqpoll_weight.attr,
> -	&dev_attr_num_hwqs.attr,
> -	&dev_attr_hwq_mode.attr,
> -	NULL
> -};
> -
> -ATTRIBUTE_GROUPS(cxlflash_host);
> -
> -/*
> - * Device attributes
> - */
> -static DEVICE_ATTR_RO(mode);
> -
> -static struct attribute *cxlflash_dev_attrs[] = {
> -	&dev_attr_mode.attr,
> -	NULL
> -};
> -
> -ATTRIBUTE_GROUPS(cxlflash_dev);
> -
> -/*
> - * Host template
> - */
> -static struct scsi_host_template driver_template = {
> -	.module = THIS_MODULE,
> -	.name = CXLFLASH_ADAPTER_NAME,
> -	.info = cxlflash_driver_info,
> -	.ioctl = cxlflash_ioctl,
> -	.proc_name = CXLFLASH_NAME,
> -	.queuecommand = cxlflash_queuecommand,
> -	.eh_abort_handler = cxlflash_eh_abort_handler,
> -	.eh_device_reset_handler = cxlflash_eh_device_reset_handler,
> -	.eh_host_reset_handler = cxlflash_eh_host_reset_handler,
> -	.change_queue_depth = cxlflash_change_queue_depth,
> -	.cmd_per_lun = CXLFLASH_MAX_CMDS_PER_LUN,
> -	.can_queue = CXLFLASH_MAX_CMDS,
> -	.cmd_size = sizeof(struct afu_cmd) + __alignof__(struct afu_cmd) - 1,
> -	.this_id = -1,
> -	.sg_tablesize = 1,	/* No scatter gather support */
> -	.max_sectors = CXLFLASH_MAX_SECTORS,
> -	.shost_groups = cxlflash_host_groups,
> -	.sdev_groups = cxlflash_dev_groups,
> -};
> -
> -/*
> - * Device dependent values
> - */
> -static struct dev_dependent_vals dev_corsa_vals = { CXLFLASH_MAX_SECTORS,
> -					CXLFLASH_WWPN_VPD_REQUIRED };
> -static struct dev_dependent_vals dev_flash_gt_vals = { CXLFLASH_MAX_SECTORS,
> -					CXLFLASH_NOTIFY_SHUTDOWN };
> -static struct dev_dependent_vals dev_briard_vals = { CXLFLASH_MAX_SECTORS,
> -					(CXLFLASH_NOTIFY_SHUTDOWN |
> -					CXLFLASH_OCXL_DEV) };
> -
> -/*
> - * PCI device binding table
> - */
> -static const struct pci_device_id cxlflash_pci_table[] = {
> -	{PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_CORSA,
> -	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, (kernel_ulong_t)&dev_corsa_vals},
> -	{PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_FLASH_GT,
> -	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, (kernel_ulong_t)&dev_flash_gt_vals},
> -	{PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_BRIARD,
> -	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, (kernel_ulong_t)&dev_briard_vals},
> -	{}
> -};
> -
> -MODULE_DEVICE_TABLE(pci, cxlflash_pci_table);
> -
> -/**
> - * cxlflash_worker_thread() - work thread handler for the AFU
> - * @work:	Work structure contained within cxlflash associated with host.
> - *
> - * Handles the following events:
> - * - Link reset which cannot be performed on interrupt context due to
> - * blocking up to a few seconds
> - * - Rescan the host
> - */
> -static void cxlflash_worker_thread(struct work_struct *work)
> -{
> -	struct cxlflash_cfg *cfg = container_of(work, struct cxlflash_cfg,
> -						work_q);
> -	struct afu *afu = cfg->afu;
> -	struct device *dev = &cfg->dev->dev;
> -	__be64 __iomem *fc_port_regs;
> -	int port;
> -	ulong lock_flags;
> -
> -	/* Avoid MMIO if the device has failed */
> -
> -	if (cfg->state != STATE_NORMAL)
> -		return;
> -
> -	spin_lock_irqsave(cfg->host->host_lock, lock_flags);
> -
> -	if (cfg->lr_state == LINK_RESET_REQUIRED) {
> -		port = cfg->lr_port;
> -		if (port < 0)
> -			dev_err(dev, "%s: invalid port index %d\n",
> -				__func__, port);
> -		else {
> -			spin_unlock_irqrestore(cfg->host->host_lock,
> -					       lock_flags);
> -
> -			/* The reset can block... */
> -			fc_port_regs = get_fc_port_regs(cfg, port);
> -			afu_link_reset(afu, port, fc_port_regs);
> -			spin_lock_irqsave(cfg->host->host_lock, lock_flags);
> -		}
> -
> -		cfg->lr_state = LINK_RESET_COMPLETE;
> -	}
> -
> -	spin_unlock_irqrestore(cfg->host->host_lock, lock_flags);
> -
> -	if (atomic_dec_if_positive(&cfg->scan_host_needed) >= 0)
> -		scsi_scan_host(cfg->host);
> -}
> -
> -/**
> - * cxlflash_chr_open() - character device open handler
> - * @inode:	Device inode associated with this character device.
> - * @file:	File pointer for this device.
> - *
> - * Only users with admin privileges are allowed to open the character device.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int cxlflash_chr_open(struct inode *inode, struct file *file)
> -{
> -	struct cxlflash_cfg *cfg;
> -
> -	if (!capable(CAP_SYS_ADMIN))
> -		return -EACCES;
> -
> -	cfg = container_of(inode->i_cdev, struct cxlflash_cfg, cdev);
> -	file->private_data = cfg;
> -
> -	return 0;
> -}
> -
> -/**
> - * decode_hioctl() - translates encoded host ioctl to easily identifiable string
> - * @cmd:        The host ioctl command to decode.
> - *
> - * Return: A string identifying the decoded host ioctl.
> - */
> -static char *decode_hioctl(unsigned int cmd)
> -{
> -	switch (cmd) {
> -	case HT_CXLFLASH_LUN_PROVISION:
> -		return __stringify_1(HT_CXLFLASH_LUN_PROVISION);
> -	}
> -
> -	return "UNKNOWN";
> -}
> -
> -/**
> - * cxlflash_lun_provision() - host LUN provisioning handler
> - * @cfg:	Internal structure associated with the host.
> - * @arg:	Kernel copy of userspace ioctl data structure.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int cxlflash_lun_provision(struct cxlflash_cfg *cfg, void *arg)
> -{
> -	struct ht_cxlflash_lun_provision *lunprov = arg;
> -	struct afu *afu = cfg->afu;
> -	struct device *dev = &cfg->dev->dev;
> -	struct sisl_ioarcb rcb;
> -	struct sisl_ioasa asa;
> -	__be64 __iomem *fc_port_regs;
> -	u16 port = lunprov->port;
> -	u16 scmd = lunprov->hdr.subcmd;
> -	u16 type;
> -	u64 reg;
> -	u64 size;
> -	u64 lun_id;
> -	int rc = 0;
> -
> -	if (!afu_is_lun_provision(afu)) {
> -		rc = -ENOTSUPP;
> -		goto out;
> -	}
> -
> -	if (port >= cfg->num_fc_ports) {
> -		rc = -EINVAL;
> -		goto out;
> -	}
> -
> -	switch (scmd) {
> -	case HT_CXLFLASH_LUN_PROVISION_SUBCMD_CREATE_LUN:
> -		type = SISL_AFU_LUN_PROVISION_CREATE;
> -		size = lunprov->size;
> -		lun_id = 0;
> -		break;
> -	case HT_CXLFLASH_LUN_PROVISION_SUBCMD_DELETE_LUN:
> -		type = SISL_AFU_LUN_PROVISION_DELETE;
> -		size = 0;
> -		lun_id = lunprov->lun_id;
> -		break;
> -	case HT_CXLFLASH_LUN_PROVISION_SUBCMD_QUERY_PORT:
> -		fc_port_regs = get_fc_port_regs(cfg, port);
> -
> -		reg = readq_be(&fc_port_regs[FC_MAX_NUM_LUNS / 8]);
> -		lunprov->max_num_luns = reg;
> -		reg = readq_be(&fc_port_regs[FC_CUR_NUM_LUNS / 8]);
> -		lunprov->cur_num_luns = reg;
> -		reg = readq_be(&fc_port_regs[FC_MAX_CAP_PORT / 8]);
> -		lunprov->max_cap_port = reg;
> -		reg = readq_be(&fc_port_regs[FC_CUR_CAP_PORT / 8]);
> -		lunprov->cur_cap_port = reg;
> -
> -		goto out;
> -	default:
> -		rc = -EINVAL;
> -		goto out;
> -	}
> -
> -	memset(&rcb, 0, sizeof(rcb));
> -	memset(&asa, 0, sizeof(asa));
> -	rcb.req_flags = SISL_REQ_FLAGS_AFU_CMD;
> -	rcb.lun_id = lun_id;
> -	rcb.msi = SISL_MSI_RRQ_UPDATED;
> -	rcb.timeout = MC_LUN_PROV_TIMEOUT;
> -	rcb.ioasa = &asa;
> -
> -	rcb.cdb[0] = SISL_AFU_CMD_LUN_PROVISION;
> -	rcb.cdb[1] = type;
> -	rcb.cdb[2] = port;
> -	put_unaligned_be64(size, &rcb.cdb[8]);
> -
> -	rc = send_afu_cmd(afu, &rcb);
> -	if (rc) {
> -		dev_err(dev, "%s: send_afu_cmd failed rc=%d asc=%08x afux=%x\n",
> -			__func__, rc, asa.ioasc, asa.afu_extra);
> -		goto out;
> -	}
> -
> -	if (scmd == HT_CXLFLASH_LUN_PROVISION_SUBCMD_CREATE_LUN) {
> -		lunprov->lun_id = (u64)asa.lunid_hi << 32 | asa.lunid_lo;
> -		memcpy(lunprov->wwid, asa.wwid, sizeof(lunprov->wwid));
> -	}
> -out:
> -	dev_dbg(dev, "%s: returning rc=%d\n", __func__, rc);
> -	return rc;
> -}
> -
> -/**
> - * cxlflash_afu_debug() - host AFU debug handler
> - * @cfg:	Internal structure associated with the host.
> - * @arg:	Kernel copy of userspace ioctl data structure.
> - *
> - * For debug requests requiring a data buffer, always provide an aligned
> - * (cache line) buffer to the AFU to appease any alignment requirements.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int cxlflash_afu_debug(struct cxlflash_cfg *cfg, void *arg)
> -{
> -	struct ht_cxlflash_afu_debug *afu_dbg = arg;
> -	struct afu *afu = cfg->afu;
> -	struct device *dev = &cfg->dev->dev;
> -	struct sisl_ioarcb rcb;
> -	struct sisl_ioasa asa;
> -	char *buf = NULL;
> -	char *kbuf = NULL;
> -	void __user *ubuf = (__force void __user *)afu_dbg->data_ea;
> -	u16 req_flags = SISL_REQ_FLAGS_AFU_CMD;
> -	u32 ulen = afu_dbg->data_len;
> -	bool is_write = afu_dbg->hdr.flags & HT_CXLFLASH_HOST_WRITE;
> -	int rc = 0;
> -
> -	if (!afu_is_afu_debug(afu)) {
> -		rc = -ENOTSUPP;
> -		goto out;
> -	}
> -
> -	if (ulen) {
> -		req_flags |= SISL_REQ_FLAGS_SUP_UNDERRUN;
> -
> -		if (ulen > HT_CXLFLASH_AFU_DEBUG_MAX_DATA_LEN) {
> -			rc = -EINVAL;
> -			goto out;
> -		}
> -
> -		buf = kmalloc(ulen + cache_line_size() - 1, GFP_KERNEL);
> -		if (unlikely(!buf)) {
> -			rc = -ENOMEM;
> -			goto out;
> -		}
> -
> -		kbuf = PTR_ALIGN(buf, cache_line_size());
> -
> -		if (is_write) {
> -			req_flags |= SISL_REQ_FLAGS_HOST_WRITE;
> -
> -			if (copy_from_user(kbuf, ubuf, ulen)) {
> -				rc = -EFAULT;
> -				goto out;
> -			}
> -		}
> -	}
> -
> -	memset(&rcb, 0, sizeof(rcb));
> -	memset(&asa, 0, sizeof(asa));
> -
> -	rcb.req_flags = req_flags;
> -	rcb.msi = SISL_MSI_RRQ_UPDATED;
> -	rcb.timeout = MC_AFU_DEBUG_TIMEOUT;
> -	rcb.ioasa = &asa;
> -
> -	if (ulen) {
> -		rcb.data_len = ulen;
> -		rcb.data_ea = (uintptr_t)kbuf;
> -	}
> -
> -	rcb.cdb[0] = SISL_AFU_CMD_DEBUG;
> -	memcpy(&rcb.cdb[4], afu_dbg->afu_subcmd,
> -	       HT_CXLFLASH_AFU_DEBUG_SUBCMD_LEN);
> -
> -	rc = send_afu_cmd(afu, &rcb);
> -	if (rc) {
> -		dev_err(dev, "%s: send_afu_cmd failed rc=%d asc=%08x afux=%x\n",
> -			__func__, rc, asa.ioasc, asa.afu_extra);
> -		goto out;
> -	}
> -
> -	if (ulen && !is_write) {
> -		if (copy_to_user(ubuf, kbuf, ulen))
> -			rc = -EFAULT;
> -	}
> -out:
> -	kfree(buf);
> -	dev_dbg(dev, "%s: returning rc=%d\n", __func__, rc);
> -	return rc;
> -}
> -
> -/**
> - * cxlflash_chr_ioctl() - character device IOCTL handler
> - * @file:	File pointer for this device.
> - * @cmd:	IOCTL command.
> - * @arg:	Userspace ioctl data structure.
> - *
> - * A read/write semaphore is used to implement a 'drain' of currently
> - * running ioctls. The read semaphore is taken at the beginning of each
> - * ioctl thread and released upon concluding execution. Additionally the
> - * semaphore should be released and then reacquired in any ioctl execution
> - * path which will wait for an event to occur that is outside the scope of
> - * the ioctl (i.e. an adapter reset). To drain the ioctls currently running,
> - * a thread simply needs to acquire the write semaphore.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static long cxlflash_chr_ioctl(struct file *file, unsigned int cmd,
> -			       unsigned long arg)
> -{
> -	typedef int (*hioctl) (struct cxlflash_cfg *, void *);
> -
> -	struct cxlflash_cfg *cfg = file->private_data;
> -	struct device *dev = &cfg->dev->dev;
> -	char buf[sizeof(union cxlflash_ht_ioctls)];
> -	void __user *uarg = (void __user *)arg;
> -	struct ht_cxlflash_hdr *hdr;
> -	size_t size = 0;
> -	bool known_ioctl = false;
> -	int idx = 0;
> -	int rc = 0;
> -	hioctl do_ioctl = NULL;
> -
> -	static const struct {
> -		size_t size;
> -		hioctl ioctl;
> -	} ioctl_tbl[] = {	/* NOTE: order matters here */
> -	{ sizeof(struct ht_cxlflash_lun_provision), cxlflash_lun_provision },
> -	{ sizeof(struct ht_cxlflash_afu_debug), cxlflash_afu_debug },
> -	};
> -
> -	/* Hold read semaphore so we can drain if needed */
> -	down_read(&cfg->ioctl_rwsem);
> -
> -	dev_dbg(dev, "%s: cmd=%u idx=%d tbl_size=%lu\n",
> -		__func__, cmd, idx, sizeof(ioctl_tbl));
> -
> -	switch (cmd) {
> -	case HT_CXLFLASH_LUN_PROVISION:
> -	case HT_CXLFLASH_AFU_DEBUG:
> -		known_ioctl = true;
> -		idx = _IOC_NR(HT_CXLFLASH_LUN_PROVISION) - _IOC_NR(cmd);
> -		size = ioctl_tbl[idx].size;
> -		do_ioctl = ioctl_tbl[idx].ioctl;
> -
> -		if (likely(do_ioctl))
> -			break;
> -
> -		fallthrough;
> -	default:
> -		rc = -EINVAL;
> -		goto out;
> -	}
> -
> -	if (unlikely(copy_from_user(&buf, uarg, size))) {
> -		dev_err(dev, "%s: copy_from_user() fail "
> -			"size=%lu cmd=%d (%s) uarg=%p\n",
> -			__func__, size, cmd, decode_hioctl(cmd), uarg);
> -		rc = -EFAULT;
> -		goto out;
> -	}
> -
> -	hdr = (struct ht_cxlflash_hdr *)&buf;
> -	if (hdr->version != HT_CXLFLASH_VERSION_0) {
> -		dev_dbg(dev, "%s: Version %u not supported for %s\n",
> -			__func__, hdr->version, decode_hioctl(cmd));
> -		rc = -EINVAL;
> -		goto out;
> -	}
> -
> -	if (hdr->rsvd[0] || hdr->rsvd[1] || hdr->return_flags) {
> -		dev_dbg(dev, "%s: Reserved/rflags populated\n", __func__);
> -		rc = -EINVAL;
> -		goto out;
> -	}
> -
> -	rc = do_ioctl(cfg, (void *)&buf);
> -	if (likely(!rc))
> -		if (unlikely(copy_to_user(uarg, &buf, size))) {
> -			dev_err(dev, "%s: copy_to_user() fail "
> -				"size=%lu cmd=%d (%s) uarg=%p\n",
> -				__func__, size, cmd, decode_hioctl(cmd), uarg);
> -			rc = -EFAULT;
> -		}
> -
> -	/* fall through to exit */
> -
> -out:
> -	up_read(&cfg->ioctl_rwsem);
> -	if (unlikely(rc && known_ioctl))
> -		dev_err(dev, "%s: ioctl %s (%08X) returned rc=%d\n",
> -			__func__, decode_hioctl(cmd), cmd, rc);
> -	else
> -		dev_dbg(dev, "%s: ioctl %s (%08X) returned rc=%d\n",
> -			__func__, decode_hioctl(cmd), cmd, rc);
> -	return rc;
> -}
> -
> -/*
> - * Character device file operations
> - */
> -static const struct file_operations cxlflash_chr_fops = {
> -	.owner          = THIS_MODULE,
> -	.open           = cxlflash_chr_open,
> -	.unlocked_ioctl	= cxlflash_chr_ioctl,
> -	.compat_ioctl	= compat_ptr_ioctl,
> -};
> -
> -/**
> - * init_chrdev() - initialize the character device for the host
> - * @cfg:	Internal structure associated with the host.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int init_chrdev(struct cxlflash_cfg *cfg)
> -{
> -	struct device *dev = &cfg->dev->dev;
> -	struct device *char_dev;
> -	dev_t devno;
> -	int minor;
> -	int rc = 0;
> -
> -	minor = cxlflash_get_minor();
> -	if (unlikely(minor < 0)) {
> -		dev_err(dev, "%s: Exhausted allowed adapters\n", __func__);
> -		rc = -ENOSPC;
> -		goto out;
> -	}
> -
> -	devno = MKDEV(cxlflash_major, minor);
> -	cdev_init(&cfg->cdev, &cxlflash_chr_fops);
> -
> -	rc = cdev_add(&cfg->cdev, devno, 1);
> -	if (rc) {
> -		dev_err(dev, "%s: cdev_add failed rc=%d\n", __func__, rc);
> -		goto err1;
> -	}
> -
> -	char_dev = device_create(&cxlflash_class, NULL, devno,
> -				 NULL, "cxlflash%d", minor);
> -	if (IS_ERR(char_dev)) {
> -		rc = PTR_ERR(char_dev);
> -		dev_err(dev, "%s: device_create failed rc=%d\n",
> -			__func__, rc);
> -		goto err2;
> -	}
> -
> -	cfg->chardev = char_dev;
> -out:
> -	dev_dbg(dev, "%s: returning rc=%d\n", __func__, rc);
> -	return rc;
> -err2:
> -	cdev_del(&cfg->cdev);
> -err1:
> -	cxlflash_put_minor(minor);
> -	goto out;
> -}
> -
> -/**
> - * cxlflash_probe() - PCI entry point to add host
> - * @pdev:	PCI device associated with the host.
> - * @dev_id:	PCI device id associated with device.
> - *
> - * The device will initially start out in a 'probing' state and
> - * transition to the 'normal' state at the end of a successful
> - * probe. Should an EEH event occur during probe, the notification
> - * thread (error_detected()) will wait until the probe handler
> - * is nearly complete. At that time, the device will be moved to
> - * a 'probed' state and the EEH thread woken up to drive the slot
> - * reset and recovery (device moves to 'normal' state). Meanwhile,
> - * the probe will be allowed to exit successfully.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int cxlflash_probe(struct pci_dev *pdev,
> -			  const struct pci_device_id *dev_id)
> -{
> -	struct Scsi_Host *host;
> -	struct cxlflash_cfg *cfg = NULL;
> -	struct device *dev = &pdev->dev;
> -	struct dev_dependent_vals *ddv;
> -	int rc = 0;
> -	int k;
> -
> -	dev_err_once(&pdev->dev, "DEPRECATION: cxlflash is deprecated and will be removed in a future kernel release\n");
> -
> -	dev_dbg(&pdev->dev, "%s: Found CXLFLASH with IRQ: %d\n",
> -		__func__, pdev->irq);
> -
> -	ddv = (struct dev_dependent_vals *)dev_id->driver_data;
> -	driver_template.max_sectors = ddv->max_sectors;
> -
> -	host = scsi_host_alloc(&driver_template, sizeof(struct cxlflash_cfg));
> -	if (!host) {
> -		dev_err(dev, "%s: scsi_host_alloc failed\n", __func__);
> -		rc = -ENOMEM;
> -		goto out;
> -	}
> -
> -	host->max_id = CXLFLASH_MAX_NUM_TARGETS_PER_BUS;
> -	host->max_lun = CXLFLASH_MAX_NUM_LUNS_PER_TARGET;
> -	host->unique_id = host->host_no;
> -	host->max_cmd_len = CXLFLASH_MAX_CDB_LEN;
> -
> -	cfg = shost_priv(host);
> -	cfg->state = STATE_PROBING;
> -	cfg->host = host;
> -	rc = alloc_mem(cfg);
> -	if (rc) {
> -		dev_err(dev, "%s: alloc_mem failed\n", __func__);
> -		rc = -ENOMEM;
> -		scsi_host_put(cfg->host);
> -		goto out;
> -	}
> -
> -	cfg->init_state = INIT_STATE_NONE;
> -	cfg->dev = pdev;
> -	cfg->cxl_fops = cxlflash_cxl_fops;
> -	cfg->ops = cxlflash_assign_ops(ddv);
> -	WARN_ON_ONCE(!cfg->ops);
> -
> -	/*
> -	 * Promoted LUNs move to the top of the LUN table. The rest stay on
> -	 * the bottom half. The bottom half grows from the end (index = 255),
> -	 * whereas the top half grows from the beginning (index = 0).
> -	 *
> -	 * Initialize the last LUN index for all possible ports.
> -	 */
> -	cfg->promote_lun_index = 0;
> -
> -	for (k = 0; k < MAX_FC_PORTS; k++)
> -		cfg->last_lun_index[k] = CXLFLASH_NUM_VLUNS/2 - 1;
> -
> -	cfg->dev_id = (struct pci_device_id *)dev_id;
> -
> -	init_waitqueue_head(&cfg->tmf_waitq);
> -	init_waitqueue_head(&cfg->reset_waitq);
> -
> -	INIT_WORK(&cfg->work_q, cxlflash_worker_thread);
> -	cfg->lr_state = LINK_RESET_INVALID;
> -	cfg->lr_port = -1;
> -	spin_lock_init(&cfg->tmf_slock);
> -	mutex_init(&cfg->ctx_tbl_list_mutex);
> -	mutex_init(&cfg->ctx_recovery_mutex);
> -	init_rwsem(&cfg->ioctl_rwsem);
> -	INIT_LIST_HEAD(&cfg->ctx_err_recovery);
> -	INIT_LIST_HEAD(&cfg->lluns);
> -
> -	pci_set_drvdata(pdev, cfg);
> -
> -	rc = init_pci(cfg);
> -	if (rc) {
> -		dev_err(dev, "%s: init_pci failed rc=%d\n", __func__, rc);
> -		goto out_remove;
> -	}
> -	cfg->init_state = INIT_STATE_PCI;
> -
> -	cfg->afu_cookie = cfg->ops->create_afu(pdev);
> -	if (unlikely(!cfg->afu_cookie)) {
> -		dev_err(dev, "%s: create_afu failed\n", __func__);
> -		rc = -ENOMEM;
> -		goto out_remove;
> -	}
> -
> -	rc = init_afu(cfg);
> -	if (rc && !wq_has_sleeper(&cfg->reset_waitq)) {
> -		dev_err(dev, "%s: init_afu failed rc=%d\n", __func__, rc);
> -		goto out_remove;
> -	}
> -	cfg->init_state = INIT_STATE_AFU;
> -
> -	rc = init_scsi(cfg);
> -	if (rc) {
> -		dev_err(dev, "%s: init_scsi failed rc=%d\n", __func__, rc);
> -		goto out_remove;
> -	}
> -	cfg->init_state = INIT_STATE_SCSI;
> -
> -	rc = init_chrdev(cfg);
> -	if (rc) {
> -		dev_err(dev, "%s: init_chrdev failed rc=%d\n", __func__, rc);
> -		goto out_remove;
> -	}
> -	cfg->init_state = INIT_STATE_CDEV;
> -
> -	if (wq_has_sleeper(&cfg->reset_waitq)) {
> -		cfg->state = STATE_PROBED;
> -		wake_up_all(&cfg->reset_waitq);
> -	} else
> -		cfg->state = STATE_NORMAL;
> -out:
> -	dev_dbg(dev, "%s: returning rc=%d\n", __func__, rc);
> -	return rc;
> -
> -out_remove:
> -	cfg->state = STATE_PROBED;
> -	cxlflash_remove(pdev);
> -	goto out;
> -}
> -
> -/**
> - * cxlflash_pci_error_detected() - called when a PCI error is detected
> - * @pdev:	PCI device struct.
> - * @state:	PCI channel state.
> - *
> - * When an EEH occurs during an active reset, wait until the reset is
> - * complete and then take action based upon the device state.
> - *
> - * Return: PCI_ERS_RESULT_NEED_RESET or PCI_ERS_RESULT_DISCONNECT
> - */
> -static pci_ers_result_t cxlflash_pci_error_detected(struct pci_dev *pdev,
> -						    pci_channel_state_t state)
> -{
> -	int rc = 0;
> -	struct cxlflash_cfg *cfg = pci_get_drvdata(pdev);
> -	struct device *dev = &cfg->dev->dev;
> -
> -	dev_dbg(dev, "%s: pdev=%p state=%u\n", __func__, pdev, state);
> -
> -	switch (state) {
> -	case pci_channel_io_frozen:
> -		wait_event(cfg->reset_waitq, cfg->state != STATE_RESET &&
> -					     cfg->state != STATE_PROBING);
> -		if (cfg->state == STATE_FAILTERM)
> -			return PCI_ERS_RESULT_DISCONNECT;
> -
> -		cfg->state = STATE_RESET;
> -		scsi_block_requests(cfg->host);
> -		drain_ioctls(cfg);
> -		rc = cxlflash_mark_contexts_error(cfg);
> -		if (unlikely(rc))
> -			dev_err(dev, "%s: Failed to mark user contexts rc=%d\n",
> -				__func__, rc);
> -		term_afu(cfg);
> -		return PCI_ERS_RESULT_NEED_RESET;
> -	case pci_channel_io_perm_failure:
> -		cfg->state = STATE_FAILTERM;
> -		wake_up_all(&cfg->reset_waitq);
> -		scsi_unblock_requests(cfg->host);
> -		return PCI_ERS_RESULT_DISCONNECT;
> -	default:
> -		break;
> -	}
> -	return PCI_ERS_RESULT_NEED_RESET;
> -}
> -
> -/**
> - * cxlflash_pci_slot_reset() - called when PCI slot has been reset
> - * @pdev:	PCI device struct.
> - *
> - * This routine is called by the pci error recovery code after the PCI
> - * slot has been reset, just before we should resume normal operations.
> - *
> - * Return: PCI_ERS_RESULT_RECOVERED or PCI_ERS_RESULT_DISCONNECT
> - */
> -static pci_ers_result_t cxlflash_pci_slot_reset(struct pci_dev *pdev)
> -{
> -	int rc = 0;
> -	struct cxlflash_cfg *cfg = pci_get_drvdata(pdev);
> -	struct device *dev = &cfg->dev->dev;
> -
> -	dev_dbg(dev, "%s: pdev=%p\n", __func__, pdev);
> -
> -	rc = init_afu(cfg);
> -	if (unlikely(rc)) {
> -		dev_err(dev, "%s: EEH recovery failed rc=%d\n", __func__, rc);
> -		return PCI_ERS_RESULT_DISCONNECT;
> -	}
> -
> -	return PCI_ERS_RESULT_RECOVERED;
> -}
> -
> -/**
> - * cxlflash_pci_resume() - called when normal operation can resume
> - * @pdev:	PCI device struct
> - */
> -static void cxlflash_pci_resume(struct pci_dev *pdev)
> -{
> -	struct cxlflash_cfg *cfg = pci_get_drvdata(pdev);
> -	struct device *dev = &cfg->dev->dev;
> -
> -	dev_dbg(dev, "%s: pdev=%p\n", __func__, pdev);
> -
> -	cfg->state = STATE_NORMAL;
> -	wake_up_all(&cfg->reset_waitq);
> -	scsi_unblock_requests(cfg->host);
> -}
> -
> -/**
> - * cxlflash_devnode() - provides devtmpfs for devices in the cxlflash class
> - * @dev:	Character device.
> - * @mode:	Mode that can be used to verify access.
> - *
> - * Return: Allocated string describing the devtmpfs structure.
> - */
> -static char *cxlflash_devnode(const struct device *dev, umode_t *mode)
> -{
> -	return kasprintf(GFP_KERNEL, "cxlflash/%s", dev_name(dev));
> -}
> -
> -/**
> - * cxlflash_class_init() - create character device class
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int cxlflash_class_init(void)
> -{
> -	dev_t devno;
> -	int rc = 0;
> -
> -	rc = alloc_chrdev_region(&devno, 0, CXLFLASH_MAX_ADAPTERS, "cxlflash");
> -	if (unlikely(rc)) {
> -		pr_err("%s: alloc_chrdev_region failed rc=%d\n", __func__, rc);
> -		goto out;
> -	}
> -
> -	cxlflash_major = MAJOR(devno);
> -
> -	rc = class_register(&cxlflash_class);
> -	if (rc) {
> -		pr_err("%s: class_create failed rc=%d\n", __func__, rc);
> -		goto err;
> -	}
> -
> -out:
> -	pr_debug("%s: returning rc=%d\n", __func__, rc);
> -	return rc;
> -err:
> -	unregister_chrdev_region(devno, CXLFLASH_MAX_ADAPTERS);
> -	goto out;
> -}
> -
> -/**
> - * cxlflash_class_exit() - destroy character device class
> - */
> -static void cxlflash_class_exit(void)
> -{
> -	dev_t devno = MKDEV(cxlflash_major, 0);
> -
> -	class_unregister(&cxlflash_class);
> -	unregister_chrdev_region(devno, CXLFLASH_MAX_ADAPTERS);
> -}
> -
> -static const struct pci_error_handlers cxlflash_err_handler = {
> -	.error_detected = cxlflash_pci_error_detected,
> -	.slot_reset = cxlflash_pci_slot_reset,
> -	.resume = cxlflash_pci_resume,
> -};
> -
> -/*
> - * PCI device structure
> - */
> -static struct pci_driver cxlflash_driver = {
> -	.name = CXLFLASH_NAME,
> -	.id_table = cxlflash_pci_table,
> -	.probe = cxlflash_probe,
> -	.remove = cxlflash_remove,
> -	.shutdown = cxlflash_remove,
> -	.err_handler = &cxlflash_err_handler,
> -};
> -
> -/**
> - * init_cxlflash() - module entry point
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int __init init_cxlflash(void)
> -{
> -	int rc;
> -
> -	check_sizes();
> -	cxlflash_list_init();
> -	rc = cxlflash_class_init();
> -	if (unlikely(rc))
> -		goto out;
> -
> -	rc = pci_register_driver(&cxlflash_driver);
> -	if (unlikely(rc))
> -		goto err;
> -out:
> -	pr_debug("%s: returning rc=%d\n", __func__, rc);
> -	return rc;
> -err:
> -	cxlflash_class_exit();
> -	goto out;
> -}
> -
> -/**
> - * exit_cxlflash() - module exit point
> - */
> -static void __exit exit_cxlflash(void)
> -{
> -	cxlflash_term_global_luns();
> -	cxlflash_free_errpage();
> -
> -	pci_unregister_driver(&cxlflash_driver);
> -	cxlflash_class_exit();
> -}
> -
> -module_init(init_cxlflash);
> -module_exit(exit_cxlflash);
> diff --git a/drivers/scsi/cxlflash/main.h b/drivers/scsi/cxlflash/main.h
> deleted file mode 100644
> index 0bfb98effce0..000000000000
> --- a/drivers/scsi/cxlflash/main.h
> +++ /dev/null
> @@ -1,129 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * CXL Flash Device Driver
> - *
> - * Written by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>, IBM Corporation
> - *             Matthew R. Ochs <mrochs@linux.vnet.ibm.com>, IBM Corporation
> - *
> - * Copyright (C) 2015 IBM Corporation
> - */
> -
> -#ifndef _CXLFLASH_MAIN_H
> -#define _CXLFLASH_MAIN_H
> -
> -#include <linux/list.h>
> -#include <linux/types.h>
> -#include <scsi/scsi.h>
> -#include <scsi/scsi_device.h>
> -
> -#include "backend.h"
> -
> -#define CXLFLASH_NAME		"cxlflash"
> -#define CXLFLASH_ADAPTER_NAME	"IBM POWER CXL Flash Adapter"
> -#define CXLFLASH_MAX_ADAPTERS	32
> -
> -#define PCI_DEVICE_ID_IBM_CORSA		0x04F0
> -#define PCI_DEVICE_ID_IBM_FLASH_GT	0x0600
> -#define PCI_DEVICE_ID_IBM_BRIARD	0x0624
> -
> -/* Since there is only one target, make it 0 */
> -#define CXLFLASH_TARGET		0
> -#define CXLFLASH_MAX_CDB_LEN	16
> -
> -/* Really only one target per bus since the Texan is directly attached */
> -#define CXLFLASH_MAX_NUM_TARGETS_PER_BUS	1
> -#define CXLFLASH_MAX_NUM_LUNS_PER_TARGET	65536
> -
> -#define CXLFLASH_PCI_ERROR_RECOVERY_TIMEOUT	(120 * HZ)
> -
> -/* FC defines */
> -#define FC_MTIP_CMDCONFIG 0x010
> -#define FC_MTIP_STATUS 0x018
> -#define FC_MAX_NUM_LUNS 0x080 /* Max LUNs host can provision for port */
> -#define FC_CUR_NUM_LUNS 0x088 /* Cur number LUNs provisioned for port */
> -#define FC_MAX_CAP_PORT 0x090 /* Max capacity all LUNs for port (4K blocks) */
> -#define FC_CUR_CAP_PORT 0x098 /* Cur capacity all LUNs for port (4K blocks) */
> -
> -#define FC_PNAME 0x300
> -#define FC_CONFIG 0x320
> -#define FC_CONFIG2 0x328
> -#define FC_STATUS 0x330
> -#define FC_ERROR 0x380
> -#define FC_ERRCAP 0x388
> -#define FC_ERRMSK 0x390
> -#define FC_CNT_CRCERR 0x538
> -#define FC_CRC_THRESH 0x580
> -
> -#define FC_MTIP_CMDCONFIG_ONLINE	0x20ULL
> -#define FC_MTIP_CMDCONFIG_OFFLINE	0x40ULL
> -
> -#define FC_MTIP_STATUS_MASK		0x30ULL
> -#define FC_MTIP_STATUS_ONLINE		0x20ULL
> -#define FC_MTIP_STATUS_OFFLINE		0x10ULL
> -
> -/* TIMEOUT and RETRY definitions */
> -
> -/* AFU command timeout values */
> -#define MC_AFU_SYNC_TIMEOUT	5	/* 5 secs */
> -#define MC_LUN_PROV_TIMEOUT	5	/* 5 secs */
> -#define MC_AFU_DEBUG_TIMEOUT	5	/* 5 secs */
> -
> -/* AFU command room retry limit */
> -#define MC_ROOM_RETRY_CNT	10
> -
> -/* FC CRC clear periodic timer */
> -#define MC_CRC_THRESH 100	/* threshold in 5 mins */
> -
> -#define FC_PORT_STATUS_RETRY_CNT 100	/* 100 100ms retries = 10 seconds */
> -#define FC_PORT_STATUS_RETRY_INTERVAL_US 100000	/* microseconds */
> -
> -/* VPD defines */
> -#define CXLFLASH_VPD_LEN	256
> -#define WWPN_LEN	16
> -#define WWPN_BUF_LEN	(WWPN_LEN + 1)
> -
> -enum undo_level {
> -	UNDO_NOOP = 0,
> -	FREE_IRQ,
> -	UNMAP_ONE,
> -	UNMAP_TWO,
> -	UNMAP_THREE
> -};
> -
> -struct dev_dependent_vals {
> -	u64 max_sectors;
> -	u64 flags;
> -#define CXLFLASH_NOTIFY_SHUTDOWN	0x0000000000000001ULL
> -#define CXLFLASH_WWPN_VPD_REQUIRED	0x0000000000000002ULL
> -#define CXLFLASH_OCXL_DEV		0x0000000000000004ULL
> -};
> -
> -static inline const struct cxlflash_backend_ops *
> -cxlflash_assign_ops(struct dev_dependent_vals *ddv)
> -{
> -	const struct cxlflash_backend_ops *ops = NULL;
> -
> -#ifdef CONFIG_OCXL_BASE
> -	if (ddv->flags & CXLFLASH_OCXL_DEV)
> -		ops = &cxlflash_ocxl_ops;
> -#endif
> -
> -#ifdef CONFIG_CXL_BASE
> -	if (!(ddv->flags & CXLFLASH_OCXL_DEV))
> -		ops = &cxlflash_cxl_ops;
> -#endif
> -
> -	return ops;
> -}
> -
> -struct asyc_intr_info {
> -	u64 status;
> -	char *desc;
> -	u8 port;
> -	u8 action;
> -#define CLR_FC_ERROR	0x01
> -#define LINK_RESET	0x02
> -#define SCAN_HOST	0x04
> -};
> -
> -#endif /* _CXLFLASH_MAIN_H */
> diff --git a/drivers/scsi/cxlflash/ocxl_hw.c b/drivers/scsi/cxlflash/ocxl_hw.c
> deleted file mode 100644
> index 6542818e595a..000000000000
> --- a/drivers/scsi/cxlflash/ocxl_hw.c
> +++ /dev/null
> @@ -1,1399 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * CXL Flash Device Driver
> - *
> - * Written by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>, IBM Corporation
> - *             Uma Krishnan <ukrishn@linux.vnet.ibm.com>, IBM Corporation
> - *
> - * Copyright (C) 2018 IBM Corporation
> - */
> -
> -#include <linux/file.h>
> -#include <linux/idr.h>
> -#include <linux/module.h>
> -#include <linux/mount.h>
> -#include <linux/pseudo_fs.h>
> -#include <linux/poll.h>
> -#include <linux/sched/signal.h>
> -#include <linux/interrupt.h>
> -#include <linux/irqdomain.h>
> -#include <asm/xive.h>
> -#include <misc/ocxl.h>
> -
> -#include <uapi/misc/cxl.h>
> -
> -#include "backend.h"
> -#include "ocxl_hw.h"
> -
> -/*
> - * Pseudo-filesystem to allocate inodes.
> - */
> -
> -#define OCXLFLASH_FS_MAGIC      0x1697698f
> -
> -static int ocxlflash_fs_cnt;
> -static struct vfsmount *ocxlflash_vfs_mount;
> -
> -static int ocxlflash_fs_init_fs_context(struct fs_context *fc)
> -{
> -	return init_pseudo(fc, OCXLFLASH_FS_MAGIC) ? 0 : -ENOMEM;
> -}
> -
> -static struct file_system_type ocxlflash_fs_type = {
> -	.name		= "ocxlflash",
> -	.owner		= THIS_MODULE,
> -	.init_fs_context = ocxlflash_fs_init_fs_context,
> -	.kill_sb	= kill_anon_super,
> -};
> -
> -/*
> - * ocxlflash_release_mapping() - release the memory mapping
> - * @ctx:	Context whose mapping is to be released.
> - */
> -static void ocxlflash_release_mapping(struct ocxlflash_context *ctx)
> -{
> -	if (ctx->mapping)
> -		simple_release_fs(&ocxlflash_vfs_mount, &ocxlflash_fs_cnt);
> -	ctx->mapping = NULL;
> -}
> -
> -/*
> - * ocxlflash_getfile() - allocate pseudo filesystem, inode, and the file
> - * @dev:	Generic device of the host.
> - * @name:	Name of the pseudo filesystem.
> - * @fops:	File operations.
> - * @priv:	Private data.
> - * @flags:	Flags for the file.
> - *
> - * Return: pointer to the file on success, ERR_PTR on failure
> - */
> -static struct file *ocxlflash_getfile(struct device *dev, const char *name,
> -				      const struct file_operations *fops,
> -				      void *priv, int flags)
> -{
> -	struct file *file;
> -	struct inode *inode;
> -	int rc;
> -
> -	if (fops->owner && !try_module_get(fops->owner)) {
> -		dev_err(dev, "%s: Owner does not exist\n", __func__);
> -		rc = -ENOENT;
> -		goto err1;
> -	}
> -
> -	rc = simple_pin_fs(&ocxlflash_fs_type, &ocxlflash_vfs_mount,
> -			   &ocxlflash_fs_cnt);
> -	if (unlikely(rc < 0)) {
> -		dev_err(dev, "%s: Cannot mount ocxlflash pseudofs rc=%d\n",
> -			__func__, rc);
> -		goto err2;
> -	}
> -
> -	inode = alloc_anon_inode(ocxlflash_vfs_mount->mnt_sb);
> -	if (IS_ERR(inode)) {
> -		rc = PTR_ERR(inode);
> -		dev_err(dev, "%s: alloc_anon_inode failed rc=%d\n",
> -			__func__, rc);
> -		goto err3;
> -	}
> -
> -	file = alloc_file_pseudo(inode, ocxlflash_vfs_mount, name,
> -				 flags & (O_ACCMODE | O_NONBLOCK), fops);
> -	if (IS_ERR(file)) {
> -		rc = PTR_ERR(file);
> -		dev_err(dev, "%s: alloc_file failed rc=%d\n",
> -			__func__, rc);
> -		goto err4;
> -	}
> -
> -	file->private_data = priv;
> -out:
> -	return file;
> -err4:
> -	iput(inode);
> -err3:
> -	simple_release_fs(&ocxlflash_vfs_mount, &ocxlflash_fs_cnt);
> -err2:
> -	module_put(fops->owner);
> -err1:
> -	file = ERR_PTR(rc);
> -	goto out;
> -}
> -
> -/**
> - * ocxlflash_psa_map() - map the process specific MMIO space
> - * @ctx_cookie:	Adapter context for which the mapping needs to be done.
> - *
> - * Return: MMIO pointer of the mapped region
> - */
> -static void __iomem *ocxlflash_psa_map(void *ctx_cookie)
> -{
> -	struct ocxlflash_context *ctx = ctx_cookie;
> -	struct device *dev = ctx->hw_afu->dev;
> -
> -	mutex_lock(&ctx->state_mutex);
> -	if (ctx->state != STARTED) {
> -		dev_err(dev, "%s: Context not started, state=%d\n", __func__,
> -			ctx->state);
> -		mutex_unlock(&ctx->state_mutex);
> -		return NULL;
> -	}
> -	mutex_unlock(&ctx->state_mutex);
> -
> -	return ioremap(ctx->psn_phys, ctx->psn_size);
> -}
> -
> -/**
> - * ocxlflash_psa_unmap() - unmap the process specific MMIO space
> - * @addr:	MMIO pointer to unmap.
> - */
> -static void ocxlflash_psa_unmap(void __iomem *addr)
> -{
> -	iounmap(addr);
> -}
> -
> -/**
> - * ocxlflash_process_element() - get process element of the adapter context
> - * @ctx_cookie:	Adapter context associated with the process element.
> - *
> - * Return: process element of the adapter context
> - */
> -static int ocxlflash_process_element(void *ctx_cookie)
> -{
> -	struct ocxlflash_context *ctx = ctx_cookie;
> -
> -	return ctx->pe;
> -}
> -
> -/**
> - * afu_map_irq() - map the interrupt of the adapter context
> - * @flags:	Flags.
> - * @ctx:	Adapter context.
> - * @num:	Per-context AFU interrupt number.
> - * @handler:	Interrupt handler to register.
> - * @cookie:	Interrupt handler private data.
> - * @name:	Name of the interrupt.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int afu_map_irq(u64 flags, struct ocxlflash_context *ctx, int num,
> -		       irq_handler_t handler, void *cookie, char *name)
> -{
> -	struct ocxl_hw_afu *afu = ctx->hw_afu;
> -	struct device *dev = afu->dev;
> -	struct ocxlflash_irqs *irq;
> -	struct xive_irq_data *xd;
> -	u32 virq;
> -	int rc = 0;
> -
> -	if (num < 0 || num >= ctx->num_irqs) {
> -		dev_err(dev, "%s: Interrupt %d not allocated\n", __func__, num);
> -		rc = -ENOENT;
> -		goto out;
> -	}
> -
> -	irq = &ctx->irqs[num];
> -	virq = irq_create_mapping(NULL, irq->hwirq);
> -	if (unlikely(!virq)) {
> -		dev_err(dev, "%s: irq_create_mapping failed\n", __func__);
> -		rc = -ENOMEM;
> -		goto out;
> -	}
> -
> -	rc = request_irq(virq, handler, 0, name, cookie);
> -	if (unlikely(rc)) {
> -		dev_err(dev, "%s: request_irq failed rc=%d\n", __func__, rc);
> -		goto err1;
> -	}
> -
> -	xd = irq_get_handler_data(virq);
> -	if (unlikely(!xd)) {
> -		dev_err(dev, "%s: Can't get interrupt data\n", __func__);
> -		rc = -ENXIO;
> -		goto err2;
> -	}
> -
> -	irq->virq = virq;
> -	irq->vtrig = xd->trig_mmio;
> -out:
> -	return rc;
> -err2:
> -	free_irq(virq, cookie);
> -err1:
> -	irq_dispose_mapping(virq);
> -	goto out;
> -}
> -
> -/**
> - * ocxlflash_map_afu_irq() - map the interrupt of the adapter context
> - * @ctx_cookie:	Adapter context.
> - * @num:	Per-context AFU interrupt number.
> - * @handler:	Interrupt handler to register.
> - * @cookie:	Interrupt handler private data.
> - * @name:	Name of the interrupt.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int ocxlflash_map_afu_irq(void *ctx_cookie, int num,
> -				 irq_handler_t handler, void *cookie,
> -				 char *name)
> -{
> -	return afu_map_irq(0, ctx_cookie, num, handler, cookie, name);
> -}
> -
> -/**
> - * afu_unmap_irq() - unmap the interrupt
> - * @flags:	Flags.
> - * @ctx:	Adapter context.
> - * @num:	Per-context AFU interrupt number.
> - * @cookie:	Interrupt handler private data.
> - */
> -static void afu_unmap_irq(u64 flags, struct ocxlflash_context *ctx, int num,
> -			  void *cookie)
> -{
> -	struct ocxl_hw_afu *afu = ctx->hw_afu;
> -	struct device *dev = afu->dev;
> -	struct ocxlflash_irqs *irq;
> -
> -	if (num < 0 || num >= ctx->num_irqs) {
> -		dev_err(dev, "%s: Interrupt %d not allocated\n", __func__, num);
> -		return;
> -	}
> -
> -	irq = &ctx->irqs[num];
> -
> -	if (irq_find_mapping(NULL, irq->hwirq)) {
> -		free_irq(irq->virq, cookie);
> -		irq_dispose_mapping(irq->virq);
> -	}
> -
> -	memset(irq, 0, sizeof(*irq));
> -}
> -
> -/**
> - * ocxlflash_unmap_afu_irq() - unmap the interrupt
> - * @ctx_cookie:	Adapter context.
> - * @num:	Per-context AFU interrupt number.
> - * @cookie:	Interrupt handler private data.
> - */
> -static void ocxlflash_unmap_afu_irq(void *ctx_cookie, int num, void *cookie)
> -{
> -	return afu_unmap_irq(0, ctx_cookie, num, cookie);
> -}
> -
> -/**
> - * ocxlflash_get_irq_objhndl() - get the object handle for an interrupt
> - * @ctx_cookie:	Context associated with the interrupt.
> - * @irq:	Interrupt number.
> - *
> - * Return: effective address of the mapped region
> - */
> -static u64 ocxlflash_get_irq_objhndl(void *ctx_cookie, int irq)
> -{
> -	struct ocxlflash_context *ctx = ctx_cookie;
> -
> -	if (irq < 0 || irq >= ctx->num_irqs)
> -		return 0;
> -
> -	return (__force u64)ctx->irqs[irq].vtrig;
> -}
> -
> -/**
> - * ocxlflash_xsl_fault() - callback when translation error is triggered
> - * @data:	Private data provided at callback registration, the context.
> - * @addr:	Address that triggered the error.
> - * @dsisr:	Value of dsisr register.
> - */
> -static void ocxlflash_xsl_fault(void *data, u64 addr, u64 dsisr)
> -{
> -	struct ocxlflash_context *ctx = data;
> -
> -	spin_lock(&ctx->slock);
> -	ctx->fault_addr = addr;
> -	ctx->fault_dsisr = dsisr;
> -	ctx->pending_fault = true;
> -	spin_unlock(&ctx->slock);
> -
> -	wake_up_all(&ctx->wq);
> -}
> -
> -/**
> - * start_context() - local routine to start a context
> - * @ctx:	Adapter context to be started.
> - *
> - * Assign the context specific MMIO space, add and enable the PE.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int start_context(struct ocxlflash_context *ctx)
> -{
> -	struct ocxl_hw_afu *afu = ctx->hw_afu;
> -	struct ocxl_afu_config *acfg = &afu->acfg;
> -	void *link_token = afu->link_token;
> -	struct pci_dev *pdev = afu->pdev;
> -	struct device *dev = afu->dev;
> -	bool master = ctx->master;
> -	struct mm_struct *mm;
> -	int rc = 0;
> -	u32 pid;
> -
> -	mutex_lock(&ctx->state_mutex);
> -	if (ctx->state != OPENED) {
> -		dev_err(dev, "%s: Context state invalid, state=%d\n",
> -			__func__, ctx->state);
> -		rc = -EINVAL;
> -		goto out;
> -	}
> -
> -	if (master) {
> -		ctx->psn_size = acfg->global_mmio_size;
> -		ctx->psn_phys = afu->gmmio_phys;
> -	} else {
> -		ctx->psn_size = acfg->pp_mmio_stride;
> -		ctx->psn_phys = afu->ppmmio_phys + (ctx->pe * ctx->psn_size);
> -	}
> -
> -	/* pid and mm not set for master contexts */
> -	if (master) {
> -		pid = 0;
> -		mm = NULL;
> -	} else {
> -		pid = current->mm->context.id;
> -		mm = current->mm;
> -	}
> -
> -	rc = ocxl_link_add_pe(link_token, ctx->pe, pid, 0, 0,
> -			      pci_dev_id(pdev), mm, ocxlflash_xsl_fault,
> -			      ctx);
> -	if (unlikely(rc)) {
> -		dev_err(dev, "%s: ocxl_link_add_pe failed rc=%d\n",
> -			__func__, rc);
> -		goto out;
> -	}
> -
> -	ctx->state = STARTED;
> -out:
> -	mutex_unlock(&ctx->state_mutex);
> -	return rc;
> -}
> -
> -/**
> - * ocxlflash_start_context() - start a kernel context
> - * @ctx_cookie:	Adapter context to be started.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int ocxlflash_start_context(void *ctx_cookie)
> -{
> -	struct ocxlflash_context *ctx = ctx_cookie;
> -
> -	return start_context(ctx);
> -}
> -
> -/**
> - * ocxlflash_stop_context() - stop a context
> - * @ctx_cookie:	Adapter context to be stopped.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int ocxlflash_stop_context(void *ctx_cookie)
> -{
> -	struct ocxlflash_context *ctx = ctx_cookie;
> -	struct ocxl_hw_afu *afu = ctx->hw_afu;
> -	struct ocxl_afu_config *acfg = &afu->acfg;
> -	struct pci_dev *pdev = afu->pdev;
> -	struct device *dev = afu->dev;
> -	enum ocxlflash_ctx_state state;
> -	int rc = 0;
> -
> -	mutex_lock(&ctx->state_mutex);
> -	state = ctx->state;
> -	ctx->state = CLOSED;
> -	mutex_unlock(&ctx->state_mutex);
> -	if (state != STARTED)
> -		goto out;
> -
> -	rc = ocxl_config_terminate_pasid(pdev, acfg->dvsec_afu_control_pos,
> -					 ctx->pe);
> -	if (unlikely(rc)) {
> -		dev_err(dev, "%s: ocxl_config_terminate_pasid failed rc=%d\n",
> -			__func__, rc);
> -		/* If EBUSY, PE could be referenced in future by the AFU */
> -		if (rc == -EBUSY)
> -			goto out;
> -	}
> -
> -	rc = ocxl_link_remove_pe(afu->link_token, ctx->pe);
> -	if (unlikely(rc)) {
> -		dev_err(dev, "%s: ocxl_link_remove_pe failed rc=%d\n",
> -			__func__, rc);
> -		goto out;
> -	}
> -out:
> -	return rc;
> -}
> -
> -/**
> - * ocxlflash_afu_reset() - reset the AFU
> - * @ctx_cookie:	Adapter context.
> - */
> -static int ocxlflash_afu_reset(void *ctx_cookie)
> -{
> -	struct ocxlflash_context *ctx = ctx_cookie;
> -	struct device *dev = ctx->hw_afu->dev;
> -
> -	/* Pending implementation from OCXL transport services */
> -	dev_err_once(dev, "%s: afu_reset() fop not supported\n", __func__);
> -
> -	/* Silently return success until it is implemented */
> -	return 0;
> -}
> -
> -/**
> - * ocxlflash_set_master() - sets the context as master
> - * @ctx_cookie:	Adapter context to set as master.
> - */
> -static void ocxlflash_set_master(void *ctx_cookie)
> -{
> -	struct ocxlflash_context *ctx = ctx_cookie;
> -
> -	ctx->master = true;
> -}
> -
> -/**
> - * ocxlflash_get_context() - obtains the context associated with the host
> - * @pdev:	PCI device associated with the host.
> - * @afu_cookie:	Hardware AFU associated with the host.
> - *
> - * Return: returns the pointer to host adapter context
> - */
> -static void *ocxlflash_get_context(struct pci_dev *pdev, void *afu_cookie)
> -{
> -	struct ocxl_hw_afu *afu = afu_cookie;
> -
> -	return afu->ocxl_ctx;
> -}
> -
> -/**
> - * ocxlflash_dev_context_init() - allocate and initialize an adapter context
> - * @pdev:	PCI device associated with the host.
> - * @afu_cookie:	Hardware AFU associated with the host.
> - *
> - * Return: returns the adapter context on success, ERR_PTR on failure
> - */
> -static void *ocxlflash_dev_context_init(struct pci_dev *pdev, void *afu_cookie)
> -{
> -	struct ocxl_hw_afu *afu = afu_cookie;
> -	struct device *dev = afu->dev;
> -	struct ocxlflash_context *ctx;
> -	int rc;
> -
> -	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> -	if (unlikely(!ctx)) {
> -		dev_err(dev, "%s: Context allocation failed\n", __func__);
> -		rc = -ENOMEM;
> -		goto err1;
> -	}
> -
> -	idr_preload(GFP_KERNEL);
> -	rc = idr_alloc(&afu->idr, ctx, 0, afu->max_pasid, GFP_NOWAIT);
> -	idr_preload_end();
> -	if (unlikely(rc < 0)) {
> -		dev_err(dev, "%s: idr_alloc failed rc=%d\n", __func__, rc);
> -		goto err2;
> -	}
> -
> -	spin_lock_init(&ctx->slock);
> -	init_waitqueue_head(&ctx->wq);
> -	mutex_init(&ctx->state_mutex);
> -
> -	ctx->state = OPENED;
> -	ctx->pe = rc;
> -	ctx->master = false;
> -	ctx->mapping = NULL;
> -	ctx->hw_afu = afu;
> -	ctx->irq_bitmap = 0;
> -	ctx->pending_irq = false;
> -	ctx->pending_fault = false;
> -out:
> -	return ctx;
> -err2:
> -	kfree(ctx);
> -err1:
> -	ctx = ERR_PTR(rc);
> -	goto out;
> -}
> -
> -/**
> - * ocxlflash_release_context() - releases an adapter context
> - * @ctx_cookie:	Adapter context to be released.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int ocxlflash_release_context(void *ctx_cookie)
> -{
> -	struct ocxlflash_context *ctx = ctx_cookie;
> -	struct device *dev;
> -	int rc = 0;
> -
> -	if (!ctx)
> -		goto out;
> -
> -	dev = ctx->hw_afu->dev;
> -	mutex_lock(&ctx->state_mutex);
> -	if (ctx->state >= STARTED) {
> -		dev_err(dev, "%s: Context in use, state=%d\n", __func__,
> -			ctx->state);
> -		mutex_unlock(&ctx->state_mutex);
> -		rc = -EBUSY;
> -		goto out;
> -	}
> -	mutex_unlock(&ctx->state_mutex);
> -
> -	idr_remove(&ctx->hw_afu->idr, ctx->pe);
> -	ocxlflash_release_mapping(ctx);
> -	kfree(ctx);
> -out:
> -	return rc;
> -}
> -
> -/**
> - * ocxlflash_perst_reloads_same_image() - sets the image reload policy
> - * @afu_cookie:	Hardware AFU associated with the host.
> - * @image:	Whether to load the same image on PERST.
> - */
> -static void ocxlflash_perst_reloads_same_image(void *afu_cookie, bool image)
> -{
> -	struct ocxl_hw_afu *afu = afu_cookie;
> -
> -	afu->perst_same_image = image;
> -}
> -
> -/**
> - * ocxlflash_read_adapter_vpd() - reads the adapter VPD
> - * @pdev:	PCI device associated with the host.
> - * @buf:	Buffer to get the VPD data.
> - * @count:	Size of buffer (maximum bytes that can be read).
> - *
> - * Return: size of VPD on success, -errno on failure
> - */
> -static ssize_t ocxlflash_read_adapter_vpd(struct pci_dev *pdev, void *buf,
> -					  size_t count)
> -{
> -	return pci_read_vpd(pdev, 0, count, buf);
> -}
> -
> -/**
> - * free_afu_irqs() - internal service to free interrupts
> - * @ctx:	Adapter context.
> - */
> -static void free_afu_irqs(struct ocxlflash_context *ctx)
> -{
> -	struct ocxl_hw_afu *afu = ctx->hw_afu;
> -	struct device *dev = afu->dev;
> -	int i;
> -
> -	if (!ctx->irqs) {
> -		dev_err(dev, "%s: Interrupts not allocated\n", __func__);
> -		return;
> -	}
> -
> -	for (i = ctx->num_irqs; i >= 0; i--)
> -		ocxl_link_free_irq(afu->link_token, ctx->irqs[i].hwirq);
> -
> -	kfree(ctx->irqs);
> -	ctx->irqs = NULL;
> -}
> -
> -/**
> - * alloc_afu_irqs() - internal service to allocate interrupts
> - * @ctx:	Context associated with the request.
> - * @num:	Number of interrupts requested.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int alloc_afu_irqs(struct ocxlflash_context *ctx, int num)
> -{
> -	struct ocxl_hw_afu *afu = ctx->hw_afu;
> -	struct device *dev = afu->dev;
> -	struct ocxlflash_irqs *irqs;
> -	int rc = 0;
> -	int hwirq;
> -	int i;
> -
> -	if (ctx->irqs) {
> -		dev_err(dev, "%s: Interrupts already allocated\n", __func__);
> -		rc = -EEXIST;
> -		goto out;
> -	}
> -
> -	if (num > OCXL_MAX_IRQS) {
> -		dev_err(dev, "%s: Too many interrupts num=%d\n", __func__, num);
> -		rc = -EINVAL;
> -		goto out;
> -	}
> -
> -	irqs = kcalloc(num, sizeof(*irqs), GFP_KERNEL);
> -	if (unlikely(!irqs)) {
> -		dev_err(dev, "%s: Context irqs allocation failed\n", __func__);
> -		rc = -ENOMEM;
> -		goto out;
> -	}
> -
> -	for (i = 0; i < num; i++) {
> -		rc = ocxl_link_irq_alloc(afu->link_token, &hwirq);
> -		if (unlikely(rc)) {
> -			dev_err(dev, "%s: ocxl_link_irq_alloc failed rc=%d\n",
> -				__func__, rc);
> -			goto err;
> -		}
> -
> -		irqs[i].hwirq = hwirq;
> -	}
> -
> -	ctx->irqs = irqs;
> -	ctx->num_irqs = num;
> -out:
> -	return rc;
> -err:
> -	for (i = i-1; i >= 0; i--)
> -		ocxl_link_free_irq(afu->link_token, irqs[i].hwirq);
> -	kfree(irqs);
> -	goto out;
> -}
> -
> -/**
> - * ocxlflash_allocate_afu_irqs() - allocates the requested number of interrupts
> - * @ctx_cookie:	Context associated with the request.
> - * @num:	Number of interrupts requested.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int ocxlflash_allocate_afu_irqs(void *ctx_cookie, int num)
> -{
> -	return alloc_afu_irqs(ctx_cookie, num);
> -}
> -
> -/**
> - * ocxlflash_free_afu_irqs() - frees the interrupts of an adapter context
> - * @ctx_cookie:	Adapter context.
> - */
> -static void ocxlflash_free_afu_irqs(void *ctx_cookie)
> -{
> -	free_afu_irqs(ctx_cookie);
> -}
> -
> -/**
> - * ocxlflash_unconfig_afu() - unconfigure the AFU
> - * @afu: AFU associated with the host.
> - */
> -static void ocxlflash_unconfig_afu(struct ocxl_hw_afu *afu)
> -{
> -	if (afu->gmmio_virt) {
> -		iounmap(afu->gmmio_virt);
> -		afu->gmmio_virt = NULL;
> -	}
> -}
> -
> -/**
> - * ocxlflash_destroy_afu() - destroy the AFU structure
> - * @afu_cookie:	AFU to be freed.
> - */
> -static void ocxlflash_destroy_afu(void *afu_cookie)
> -{
> -	struct ocxl_hw_afu *afu = afu_cookie;
> -	int pos;
> -
> -	if (!afu)
> -		return;
> -
> -	ocxlflash_release_context(afu->ocxl_ctx);
> -	idr_destroy(&afu->idr);
> -
> -	/* Disable the AFU */
> -	pos = afu->acfg.dvsec_afu_control_pos;
> -	ocxl_config_set_afu_state(afu->pdev, pos, 0);
> -
> -	ocxlflash_unconfig_afu(afu);
> -	kfree(afu);
> -}
> -
> -/**
> - * ocxlflash_config_fn() - configure the host function
> - * @pdev:	PCI device associated with the host.
> - * @afu:	AFU associated with the host.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int ocxlflash_config_fn(struct pci_dev *pdev, struct ocxl_hw_afu *afu)
> -{
> -	struct ocxl_fn_config *fcfg = &afu->fcfg;
> -	struct device *dev = &pdev->dev;
> -	u16 base, enabled, supported;
> -	int rc = 0;
> -
> -	/* Read DVSEC config of the function */
> -	rc = ocxl_config_read_function(pdev, fcfg);
> -	if (unlikely(rc)) {
> -		dev_err(dev, "%s: ocxl_config_read_function failed rc=%d\n",
> -			__func__, rc);
> -		goto out;
> -	}
> -
> -	/* Check if function has AFUs defined, only 1 per function supported */
> -	if (fcfg->max_afu_index >= 0) {
> -		afu->is_present = true;
> -		if (fcfg->max_afu_index != 0)
> -			dev_warn(dev, "%s: Unexpected AFU index value %d\n",
> -				 __func__, fcfg->max_afu_index);
> -	}
> -
> -	rc = ocxl_config_get_actag_info(pdev, &base, &enabled, &supported);
> -	if (unlikely(rc)) {
> -		dev_err(dev, "%s: ocxl_config_get_actag_info failed rc=%d\n",
> -			__func__, rc);
> -		goto out;
> -	}
> -
> -	afu->fn_actag_base = base;
> -	afu->fn_actag_enabled = enabled;
> -
> -	ocxl_config_set_actag(pdev, fcfg->dvsec_function_pos, base, enabled);
> -	dev_dbg(dev, "%s: Function acTag range base=%u enabled=%u\n",
> -		__func__, base, enabled);
> -
> -	rc = ocxl_link_setup(pdev, 0, &afu->link_token);
> -	if (unlikely(rc)) {
> -		dev_err(dev, "%s: ocxl_link_setup failed rc=%d\n",
> -			__func__, rc);
> -		goto out;
> -	}
> -
> -	rc = ocxl_config_set_TL(pdev, fcfg->dvsec_tl_pos);
> -	if (unlikely(rc)) {
> -		dev_err(dev, "%s: ocxl_config_set_TL failed rc=%d\n",
> -			__func__, rc);
> -		goto err;
> -	}
> -out:
> -	return rc;
> -err:
> -	ocxl_link_release(pdev, afu->link_token);
> -	goto out;
> -}
> -
> -/**
> - * ocxlflash_unconfig_fn() - unconfigure the host function
> - * @pdev:	PCI device associated with the host.
> - * @afu:	AFU associated with the host.
> - */
> -static void ocxlflash_unconfig_fn(struct pci_dev *pdev, struct ocxl_hw_afu *afu)
> -{
> -	ocxl_link_release(pdev, afu->link_token);
> -}
> -
> -/**
> - * ocxlflash_map_mmio() - map the AFU MMIO space
> - * @afu: AFU associated with the host.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int ocxlflash_map_mmio(struct ocxl_hw_afu *afu)
> -{
> -	struct ocxl_afu_config *acfg = &afu->acfg;
> -	struct pci_dev *pdev = afu->pdev;
> -	struct device *dev = afu->dev;
> -	phys_addr_t gmmio, ppmmio;
> -	int rc = 0;
> -
> -	rc = pci_request_region(pdev, acfg->global_mmio_bar, "ocxlflash");
> -	if (unlikely(rc)) {
> -		dev_err(dev, "%s: pci_request_region for global failed rc=%d\n",
> -			__func__, rc);
> -		goto out;
> -	}
> -	gmmio = pci_resource_start(pdev, acfg->global_mmio_bar);
> -	gmmio += acfg->global_mmio_offset;
> -
> -	rc = pci_request_region(pdev, acfg->pp_mmio_bar, "ocxlflash");
> -	if (unlikely(rc)) {
> -		dev_err(dev, "%s: pci_request_region for pp bar failed rc=%d\n",
> -			__func__, rc);
> -		goto err1;
> -	}
> -	ppmmio = pci_resource_start(pdev, acfg->pp_mmio_bar);
> -	ppmmio += acfg->pp_mmio_offset;
> -
> -	afu->gmmio_virt = ioremap(gmmio, acfg->global_mmio_size);
> -	if (unlikely(!afu->gmmio_virt)) {
> -		dev_err(dev, "%s: MMIO mapping failed\n", __func__);
> -		rc = -ENOMEM;
> -		goto err2;
> -	}
> -
> -	afu->gmmio_phys = gmmio;
> -	afu->ppmmio_phys = ppmmio;
> -out:
> -	return rc;
> -err2:
> -	pci_release_region(pdev, acfg->pp_mmio_bar);
> -err1:
> -	pci_release_region(pdev, acfg->global_mmio_bar);
> -	goto out;
> -}
> -
> -/**
> - * ocxlflash_config_afu() - configure the host AFU
> - * @pdev:	PCI device associated with the host.
> - * @afu:	AFU associated with the host.
> - *
> - * Must be called _after_ host function configuration.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int ocxlflash_config_afu(struct pci_dev *pdev, struct ocxl_hw_afu *afu)
> -{
> -	struct ocxl_afu_config *acfg = &afu->acfg;
> -	struct ocxl_fn_config *fcfg = &afu->fcfg;
> -	struct device *dev = &pdev->dev;
> -	int count;
> -	int base;
> -	int pos;
> -	int rc = 0;
> -
> -	/* This HW AFU function does not have any AFUs defined */
> -	if (!afu->is_present)
> -		goto out;
> -
> -	/* Read AFU config at index 0 */
> -	rc = ocxl_config_read_afu(pdev, fcfg, acfg, 0);
> -	if (unlikely(rc)) {
> -		dev_err(dev, "%s: ocxl_config_read_afu failed rc=%d\n",
> -			__func__, rc);
> -		goto out;
> -	}
> -
> -	/* Only one AFU per function is supported, so actag_base is same */
> -	base = afu->fn_actag_base;
> -	count = min_t(int, acfg->actag_supported, afu->fn_actag_enabled);
> -	pos = acfg->dvsec_afu_control_pos;
> -
> -	ocxl_config_set_afu_actag(pdev, pos, base, count);
> -	dev_dbg(dev, "%s: acTag base=%d enabled=%d\n", __func__, base, count);
> -	afu->afu_actag_base = base;
> -	afu->afu_actag_enabled = count;
> -	afu->max_pasid = 1 << acfg->pasid_supported_log;
> -
> -	ocxl_config_set_afu_pasid(pdev, pos, 0, acfg->pasid_supported_log);
> -
> -	rc = ocxlflash_map_mmio(afu);
> -	if (unlikely(rc)) {
> -		dev_err(dev, "%s: ocxlflash_map_mmio failed rc=%d\n",
> -			__func__, rc);
> -		goto out;
> -	}
> -
> -	/* Enable the AFU */
> -	ocxl_config_set_afu_state(pdev, acfg->dvsec_afu_control_pos, 1);
> -out:
> -	return rc;
> -}
> -
> -/**
> - * ocxlflash_create_afu() - create the AFU for OCXL
> - * @pdev:	PCI device associated with the host.
> - *
> - * Return: AFU on success, NULL on failure
> - */
> -static void *ocxlflash_create_afu(struct pci_dev *pdev)
> -{
> -	struct device *dev = &pdev->dev;
> -	struct ocxlflash_context *ctx;
> -	struct ocxl_hw_afu *afu;
> -	int rc;
> -
> -	afu = kzalloc(sizeof(*afu), GFP_KERNEL);
> -	if (unlikely(!afu)) {
> -		dev_err(dev, "%s: HW AFU allocation failed\n", __func__);
> -		goto out;
> -	}
> -
> -	afu->pdev = pdev;
> -	afu->dev = dev;
> -	idr_init(&afu->idr);
> -
> -	rc = ocxlflash_config_fn(pdev, afu);
> -	if (unlikely(rc)) {
> -		dev_err(dev, "%s: Function configuration failed rc=%d\n",
> -			__func__, rc);
> -		goto err1;
> -	}
> -
> -	rc = ocxlflash_config_afu(pdev, afu);
> -	if (unlikely(rc)) {
> -		dev_err(dev, "%s: AFU configuration failed rc=%d\n",
> -			__func__, rc);
> -		goto err2;
> -	}
> -
> -	ctx = ocxlflash_dev_context_init(pdev, afu);
> -	if (IS_ERR(ctx)) {
> -		rc = PTR_ERR(ctx);
> -		dev_err(dev, "%s: ocxlflash_dev_context_init failed rc=%d\n",
> -			__func__, rc);
> -		goto err3;
> -	}
> -
> -	afu->ocxl_ctx = ctx;
> -out:
> -	return afu;
> -err3:
> -	ocxlflash_unconfig_afu(afu);
> -err2:
> -	ocxlflash_unconfig_fn(pdev, afu);
> -err1:
> -	idr_destroy(&afu->idr);
> -	kfree(afu);
> -	afu = NULL;
> -	goto out;
> -}
> -
> -/**
> - * ctx_event_pending() - check for any event pending on the context
> - * @ctx:	Context to be checked.
> - *
> - * Return: true if there is an event pending, false if none pending
> - */
> -static inline bool ctx_event_pending(struct ocxlflash_context *ctx)
> -{
> -	if (ctx->pending_irq || ctx->pending_fault)
> -		return true;
> -
> -	return false;
> -}
> -
> -/**
> - * afu_poll() - poll the AFU for events on the context
> - * @file:	File associated with the adapter context.
> - * @poll:	Poll structure from the user.
> - *
> - * Return: poll mask
> - */
> -static unsigned int afu_poll(struct file *file, struct poll_table_struct *poll)
> -{
> -	struct ocxlflash_context *ctx = file->private_data;
> -	struct device *dev = ctx->hw_afu->dev;
> -	ulong lock_flags;
> -	int mask = 0;
> -
> -	poll_wait(file, &ctx->wq, poll);
> -
> -	spin_lock_irqsave(&ctx->slock, lock_flags);
> -	if (ctx_event_pending(ctx))
> -		mask |= POLLIN | POLLRDNORM;
> -	else if (ctx->state == CLOSED)
> -		mask |= POLLERR;
> -	spin_unlock_irqrestore(&ctx->slock, lock_flags);
> -
> -	dev_dbg(dev, "%s: Poll wait completed for pe %i mask %i\n",
> -		__func__, ctx->pe, mask);
> -
> -	return mask;
> -}
> -
> -/**
> - * afu_read() - perform a read on the context for any event
> - * @file:	File associated with the adapter context.
> - * @buf:	Buffer to receive the data.
> - * @count:	Size of buffer (maximum bytes that can be read).
> - * @off:	Offset.
> - *
> - * Return: size of the data read on success, -errno on failure
> - */
> -static ssize_t afu_read(struct file *file, char __user *buf, size_t count,
> -			loff_t *off)
> -{
> -	struct ocxlflash_context *ctx = file->private_data;
> -	struct device *dev = ctx->hw_afu->dev;
> -	struct cxl_event event;
> -	ulong lock_flags;
> -	ssize_t esize;
> -	ssize_t rc;
> -	int bit;
> -	DEFINE_WAIT(event_wait);
> -
> -	if (*off != 0) {
> -		dev_err(dev, "%s: Non-zero offset not supported, off=%lld\n",
> -			__func__, *off);
> -		rc = -EINVAL;
> -		goto out;
> -	}
> -
> -	spin_lock_irqsave(&ctx->slock, lock_flags);
> -
> -	for (;;) {
> -		prepare_to_wait(&ctx->wq, &event_wait, TASK_INTERRUPTIBLE);
> -
> -		if (ctx_event_pending(ctx) || (ctx->state == CLOSED))
> -			break;
> -
> -		if (file->f_flags & O_NONBLOCK) {
> -			dev_err(dev, "%s: File cannot be blocked on I/O\n",
> -				__func__);
> -			rc = -EAGAIN;
> -			goto err;
> -		}
> -
> -		if (signal_pending(current)) {
> -			dev_err(dev, "%s: Signal pending on the process\n",
> -				__func__);
> -			rc = -ERESTARTSYS;
> -			goto err;
> -		}
> -
> -		spin_unlock_irqrestore(&ctx->slock, lock_flags);
> -		schedule();
> -		spin_lock_irqsave(&ctx->slock, lock_flags);
> -	}
> -
> -	finish_wait(&ctx->wq, &event_wait);
> -
> -	memset(&event, 0, sizeof(event));
> -	event.header.process_element = ctx->pe;
> -	event.header.size = sizeof(struct cxl_event_header);
> -	if (ctx->pending_irq) {
> -		esize = sizeof(struct cxl_event_afu_interrupt);
> -		event.header.size += esize;
> -		event.header.type = CXL_EVENT_AFU_INTERRUPT;
> -
> -		bit = find_first_bit(&ctx->irq_bitmap, ctx->num_irqs);
> -		clear_bit(bit, &ctx->irq_bitmap);
> -		event.irq.irq = bit + 1;
> -		if (bitmap_empty(&ctx->irq_bitmap, ctx->num_irqs))
> -			ctx->pending_irq = false;
> -	} else if (ctx->pending_fault) {
> -		event.header.size += sizeof(struct cxl_event_data_storage);
> -		event.header.type = CXL_EVENT_DATA_STORAGE;
> -		event.fault.addr = ctx->fault_addr;
> -		event.fault.dsisr = ctx->fault_dsisr;
> -		ctx->pending_fault = false;
> -	}
> -
> -	spin_unlock_irqrestore(&ctx->slock, lock_flags);
> -
> -	if (copy_to_user(buf, &event, event.header.size)) {
> -		dev_err(dev, "%s: copy_to_user failed\n", __func__);
> -		rc = -EFAULT;
> -		goto out;
> -	}
> -
> -	rc = event.header.size;
> -out:
> -	return rc;
> -err:
> -	finish_wait(&ctx->wq, &event_wait);
> -	spin_unlock_irqrestore(&ctx->slock, lock_flags);
> -	goto out;
> -}
> -
> -/**
> - * afu_release() - release and free the context
> - * @inode:	File inode pointer.
> - * @file:	File associated with the context.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int afu_release(struct inode *inode, struct file *file)
> -{
> -	struct ocxlflash_context *ctx = file->private_data;
> -	int i;
> -
> -	/* Unmap and free the interrupts associated with the context */
> -	for (i = ctx->num_irqs; i >= 0; i--)
> -		afu_unmap_irq(0, ctx, i, ctx);
> -	free_afu_irqs(ctx);
> -
> -	return ocxlflash_release_context(ctx);
> -}
> -
> -/**
> - * ocxlflash_mmap_fault() - mmap fault handler
> - * @vmf:	VM fault associated with current fault.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static vm_fault_t ocxlflash_mmap_fault(struct vm_fault *vmf)
> -{
> -	struct vm_area_struct *vma = vmf->vma;
> -	struct ocxlflash_context *ctx = vma->vm_file->private_data;
> -	struct device *dev = ctx->hw_afu->dev;
> -	u64 mmio_area, offset;
> -
> -	offset = vmf->pgoff << PAGE_SHIFT;
> -	if (offset >= ctx->psn_size)
> -		return VM_FAULT_SIGBUS;
> -
> -	mutex_lock(&ctx->state_mutex);
> -	if (ctx->state != STARTED) {
> -		dev_err(dev, "%s: Context not started, state=%d\n",
> -			__func__, ctx->state);
> -		mutex_unlock(&ctx->state_mutex);
> -		return VM_FAULT_SIGBUS;
> -	}
> -	mutex_unlock(&ctx->state_mutex);
> -
> -	mmio_area = ctx->psn_phys;
> -	mmio_area += offset;
> -
> -	return vmf_insert_pfn(vma, vmf->address, mmio_area >> PAGE_SHIFT);
> -}
> -
> -static const struct vm_operations_struct ocxlflash_vmops = {
> -	.fault = ocxlflash_mmap_fault,
> -};
> -
> -/**
> - * afu_mmap() - map the fault handler operations
> - * @file:	File associated with the context.
> - * @vma:	VM area associated with mapping.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int afu_mmap(struct file *file, struct vm_area_struct *vma)
> -{
> -	struct ocxlflash_context *ctx = file->private_data;
> -
> -	if ((vma_pages(vma) + vma->vm_pgoff) >
> -	    (ctx->psn_size >> PAGE_SHIFT))
> -		return -EINVAL;
> -
> -	vm_flags_set(vma, VM_IO | VM_PFNMAP);
> -	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> -	vma->vm_ops = &ocxlflash_vmops;
> -	return 0;
> -}
> -
> -static const struct file_operations ocxl_afu_fops = {
> -	.owner		= THIS_MODULE,
> -	.poll		= afu_poll,
> -	.read		= afu_read,
> -	.release	= afu_release,
> -	.mmap		= afu_mmap,
> -};
> -
> -#define PATCH_FOPS(NAME)						\
> -	do { if (!fops->NAME) fops->NAME = ocxl_afu_fops.NAME; } while (0)
> -
> -/**
> - * ocxlflash_get_fd() - get file descriptor for an adapter context
> - * @ctx_cookie:	Adapter context.
> - * @fops:	File operations to be associated.
> - * @fd:		File descriptor to be returned back.
> - *
> - * Return: pointer to the file on success, ERR_PTR on failure
> - */
> -static struct file *ocxlflash_get_fd(void *ctx_cookie,
> -				     struct file_operations *fops, int *fd)
> -{
> -	struct ocxlflash_context *ctx = ctx_cookie;
> -	struct device *dev = ctx->hw_afu->dev;
> -	struct file *file;
> -	int flags, fdtmp;
> -	int rc = 0;
> -	char *name = NULL;
> -
> -	/* Only allow one fd per context */
> -	if (ctx->mapping) {
> -		dev_err(dev, "%s: Context is already mapped to an fd\n",
> -			__func__);
> -		rc = -EEXIST;
> -		goto err1;
> -	}
> -
> -	flags = O_RDWR | O_CLOEXEC;
> -
> -	/* This code is similar to anon_inode_getfd() */
> -	rc = get_unused_fd_flags(flags);
> -	if (unlikely(rc < 0)) {
> -		dev_err(dev, "%s: get_unused_fd_flags failed rc=%d\n",
> -			__func__, rc);
> -		goto err1;
> -	}
> -	fdtmp = rc;
> -
> -	/* Patch the file ops that are not defined */
> -	if (fops) {
> -		PATCH_FOPS(poll);
> -		PATCH_FOPS(read);
> -		PATCH_FOPS(release);
> -		PATCH_FOPS(mmap);
> -	} else /* Use default ops */
> -		fops = (struct file_operations *)&ocxl_afu_fops;
> -
> -	name = kasprintf(GFP_KERNEL, "ocxlflash:%d", ctx->pe);
> -	file = ocxlflash_getfile(dev, name, fops, ctx, flags);
> -	kfree(name);
> -	if (IS_ERR(file)) {
> -		rc = PTR_ERR(file);
> -		dev_err(dev, "%s: ocxlflash_getfile failed rc=%d\n",
> -			__func__, rc);
> -		goto err2;
> -	}
> -
> -	ctx->mapping = file->f_mapping;
> -	*fd = fdtmp;
> -out:
> -	return file;
> -err2:
> -	put_unused_fd(fdtmp);
> -err1:
> -	file = ERR_PTR(rc);
> -	goto out;
> -}
> -
> -/**
> - * ocxlflash_fops_get_context() - get the context associated with the file
> - * @file:	File associated with the adapter context.
> - *
> - * Return: pointer to the context
> - */
> -static void *ocxlflash_fops_get_context(struct file *file)
> -{
> -	return file->private_data;
> -}
> -
> -/**
> - * ocxlflash_afu_irq() - interrupt handler for user contexts
> - * @irq:	Interrupt number.
> - * @data:	Private data provided at interrupt registration, the context.
> - *
> - * Return: Always return IRQ_HANDLED.
> - */
> -static irqreturn_t ocxlflash_afu_irq(int irq, void *data)
> -{
> -	struct ocxlflash_context *ctx = data;
> -	struct device *dev = ctx->hw_afu->dev;
> -	int i;
> -
> -	dev_dbg(dev, "%s: Interrupt raised for pe %i virq %i\n",
> -		__func__, ctx->pe, irq);
> -
> -	for (i = 0; i < ctx->num_irqs; i++) {
> -		if (ctx->irqs[i].virq == irq)
> -			break;
> -	}
> -	if (unlikely(i >= ctx->num_irqs)) {
> -		dev_err(dev, "%s: Received AFU IRQ out of range\n", __func__);
> -		goto out;
> -	}
> -
> -	spin_lock(&ctx->slock);
> -	set_bit(i - 1, &ctx->irq_bitmap);
> -	ctx->pending_irq = true;
> -	spin_unlock(&ctx->slock);
> -
> -	wake_up_all(&ctx->wq);
> -out:
> -	return IRQ_HANDLED;
> -}
> -
> -/**
> - * ocxlflash_start_work() - start a user context
> - * @ctx_cookie:	Context to be started.
> - * @num_irqs:	Number of interrupts requested.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int ocxlflash_start_work(void *ctx_cookie, u64 num_irqs)
> -{
> -	struct ocxlflash_context *ctx = ctx_cookie;
> -	struct ocxl_hw_afu *afu = ctx->hw_afu;
> -	struct device *dev = afu->dev;
> -	char *name;
> -	int rc = 0;
> -	int i;
> -
> -	rc = alloc_afu_irqs(ctx, num_irqs);
> -	if (unlikely(rc < 0)) {
> -		dev_err(dev, "%s: alloc_afu_irqs failed rc=%d\n", __func__, rc);
> -		goto out;
> -	}
> -
> -	for (i = 0; i < num_irqs; i++) {
> -		name = kasprintf(GFP_KERNEL, "ocxlflash-%s-pe%i-%i",
> -				 dev_name(dev), ctx->pe, i);
> -		rc = afu_map_irq(0, ctx, i, ocxlflash_afu_irq, ctx, name);
> -		kfree(name);
> -		if (unlikely(rc < 0)) {
> -			dev_err(dev, "%s: afu_map_irq failed rc=%d\n",
> -				__func__, rc);
> -			goto err;
> -		}
> -	}
> -
> -	rc = start_context(ctx);
> -	if (unlikely(rc)) {
> -		dev_err(dev, "%s: start_context failed rc=%d\n", __func__, rc);
> -		goto err;
> -	}
> -out:
> -	return rc;
> -err:
> -	for (i = i-1; i >= 0; i--)
> -		afu_unmap_irq(0, ctx, i, ctx);
> -	free_afu_irqs(ctx);
> -	goto out;
> -};
> -
> -/**
> - * ocxlflash_fd_mmap() - mmap handler for adapter file descriptor
> - * @file:	File installed with adapter file descriptor.
> - * @vma:	VM area associated with mapping.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int ocxlflash_fd_mmap(struct file *file, struct vm_area_struct *vma)
> -{
> -	return afu_mmap(file, vma);
> -}
> -
> -/**
> - * ocxlflash_fd_release() - release the context associated with the file
> - * @inode:	File inode pointer.
> - * @file:	File associated with the adapter context.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int ocxlflash_fd_release(struct inode *inode, struct file *file)
> -{
> -	return afu_release(inode, file);
> -}
> -
> -/* Backend ops to ocxlflash services */
> -const struct cxlflash_backend_ops cxlflash_ocxl_ops = {
> -	.module			= THIS_MODULE,
> -	.psa_map		= ocxlflash_psa_map,
> -	.psa_unmap		= ocxlflash_psa_unmap,
> -	.process_element	= ocxlflash_process_element,
> -	.map_afu_irq		= ocxlflash_map_afu_irq,
> -	.unmap_afu_irq		= ocxlflash_unmap_afu_irq,
> -	.get_irq_objhndl	= ocxlflash_get_irq_objhndl,
> -	.start_context		= ocxlflash_start_context,
> -	.stop_context		= ocxlflash_stop_context,
> -	.afu_reset		= ocxlflash_afu_reset,
> -	.set_master		= ocxlflash_set_master,
> -	.get_context		= ocxlflash_get_context,
> -	.dev_context_init	= ocxlflash_dev_context_init,
> -	.release_context	= ocxlflash_release_context,
> -	.perst_reloads_same_image = ocxlflash_perst_reloads_same_image,
> -	.read_adapter_vpd	= ocxlflash_read_adapter_vpd,
> -	.allocate_afu_irqs	= ocxlflash_allocate_afu_irqs,
> -	.free_afu_irqs		= ocxlflash_free_afu_irqs,
> -	.create_afu		= ocxlflash_create_afu,
> -	.destroy_afu		= ocxlflash_destroy_afu,
> -	.get_fd			= ocxlflash_get_fd,
> -	.fops_get_context	= ocxlflash_fops_get_context,
> -	.start_work		= ocxlflash_start_work,
> -	.fd_mmap		= ocxlflash_fd_mmap,
> -	.fd_release		= ocxlflash_fd_release,
> -};
> diff --git a/drivers/scsi/cxlflash/ocxl_hw.h b/drivers/scsi/cxlflash/ocxl_hw.h
> deleted file mode 100644
> index f2fe88816bea..000000000000
> --- a/drivers/scsi/cxlflash/ocxl_hw.h
> +++ /dev/null
> @@ -1,72 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * CXL Flash Device Driver
> - *
> - * Written by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>, IBM Corporation
> - *	       Uma Krishnan <ukrishn@linux.vnet.ibm.com>, IBM Corporation
> - *
> - * Copyright (C) 2018 IBM Corporation
> - */
> -
> -#define OCXL_MAX_IRQS	4	/* Max interrupts per process */
> -
> -struct ocxlflash_irqs {
> -	int hwirq;
> -	u32 virq;
> -	void __iomem *vtrig;
> -};
> -
> -/* OCXL hardware AFU associated with the host */
> -struct ocxl_hw_afu {
> -	struct ocxlflash_context *ocxl_ctx; /* Host context */
> -	struct pci_dev *pdev;		/* PCI device */
> -	struct device *dev;		/* Generic device */
> -	bool perst_same_image;		/* Same image loaded on perst */
> -
> -	struct ocxl_fn_config fcfg;	/* DVSEC config of the function */
> -	struct ocxl_afu_config acfg;	/* AFU configuration data */
> -
> -	int fn_actag_base;		/* Function acTag base */
> -	int fn_actag_enabled;		/* Function acTag number enabled */
> -	int afu_actag_base;		/* AFU acTag base */
> -	int afu_actag_enabled;		/* AFU acTag number enabled */
> -
> -	phys_addr_t ppmmio_phys;	/* Per process MMIO space */
> -	phys_addr_t gmmio_phys;		/* Global AFU MMIO space */
> -	void __iomem *gmmio_virt;	/* Global MMIO map */
> -
> -	void *link_token;		/* Link token for the SPA */
> -	struct idr idr;			/* IDR to manage contexts */
> -	int max_pasid;			/* Maximum number of contexts */
> -	bool is_present;		/* Function has AFUs defined */
> -};
> -
> -enum ocxlflash_ctx_state {
> -	CLOSED,
> -	OPENED,
> -	STARTED
> -};
> -
> -struct ocxlflash_context {
> -	struct ocxl_hw_afu *hw_afu;	/* HW AFU back pointer */
> -	struct address_space *mapping;	/* Mapping for pseudo filesystem */
> -	bool master;			/* Whether this is a master context */
> -	int pe;				/* Process element */
> -
> -	phys_addr_t psn_phys;		/* Process mapping */
> -	u64 psn_size;			/* Process mapping size */
> -
> -	spinlock_t slock;		/* Protects irq/fault/event updates */
> -	wait_queue_head_t wq;		/* Wait queue for poll and interrupts */
> -	struct mutex state_mutex;	/* Mutex to update context state */
> -	enum ocxlflash_ctx_state state;	/* Context state */
> -
> -	struct ocxlflash_irqs *irqs;	/* Pointer to array of structures */
> -	int num_irqs;			/* Number of interrupts */
> -	bool pending_irq;		/* Pending interrupt on the context */
> -	ulong irq_bitmap;		/* Bits indicating pending irq num */
> -
> -	u64 fault_addr;			/* Address that triggered the fault */
> -	u64 fault_dsisr;		/* Value of dsisr register at fault */
> -	bool pending_fault;		/* Pending translation fault */
> -};
> diff --git a/drivers/scsi/cxlflash/sislite.h b/drivers/scsi/cxlflash/sislite.h
> deleted file mode 100644
> index ab315c59505b..000000000000
> --- a/drivers/scsi/cxlflash/sislite.h
> +++ /dev/null
> @@ -1,560 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * CXL Flash Device Driver
> - *
> - * Written by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>, IBM Corporation
> - *             Matthew R. Ochs <mrochs@linux.vnet.ibm.com>, IBM Corporation
> - *
> - * Copyright (C) 2015 IBM Corporation
> - */
> -
> -#ifndef _SISLITE_H
> -#define _SISLITE_H
> -
> -#include <linux/types.h>
> -
> -typedef u16 ctx_hndl_t;
> -typedef u32 res_hndl_t;
> -
> -#define SIZE_4K		4096
> -#define SIZE_64K	65536
> -
> -/*
> - * IOARCB: 64 bytes, min 16 byte alignment required, host native endianness
> - * except for SCSI CDB which remains big endian per SCSI standards.
> - */
> -struct sisl_ioarcb {
> -	u16 ctx_id;		/* ctx_hndl_t */
> -	u16 req_flags;
> -#define SISL_REQ_FLAGS_RES_HNDL       0x8000U	/* bit 0 (MSB) */
> -#define SISL_REQ_FLAGS_PORT_LUN_ID    0x0000U
> -
> -#define SISL_REQ_FLAGS_SUP_UNDERRUN   0x4000U	/* bit 1 */
> -
> -#define SISL_REQ_FLAGS_TIMEOUT_SECS   0x0000U	/* bits 8,9 */
> -#define SISL_REQ_FLAGS_TIMEOUT_MSECS  0x0040U
> -#define SISL_REQ_FLAGS_TIMEOUT_USECS  0x0080U
> -#define SISL_REQ_FLAGS_TIMEOUT_CYCLES 0x00C0U
> -
> -#define SISL_REQ_FLAGS_TMF_CMD        0x0004u	/* bit 13 */
> -
> -#define SISL_REQ_FLAGS_AFU_CMD        0x0002U	/* bit 14 */
> -
> -#define SISL_REQ_FLAGS_HOST_WRITE     0x0001U	/* bit 15 (LSB) */
> -#define SISL_REQ_FLAGS_HOST_READ      0x0000U
> -
> -	union {
> -		u32 res_hndl;	/* res_hndl_t */
> -		u32 port_sel;	/* this is a selection mask:
> -				 * 0x1 -> port#0 can be selected,
> -				 * 0x2 -> port#1 can be selected.
> -				 * Can be bitwise ORed.
> -				 */
> -	};
> -	u64 lun_id;
> -	u32 data_len;		/* 4K for read/write */
> -	u32 ioadl_len;
> -	union {
> -		u64 data_ea;	/* min 16 byte aligned */
> -		u64 ioadl_ea;
> -	};
> -	u8 msi;			/* LISN to send on RRQ write */
> -#define SISL_MSI_CXL_PFAULT        0	/* reserved for CXL page faults */
> -#define SISL_MSI_SYNC_ERROR        1	/* recommended for AFU sync error */
> -#define SISL_MSI_RRQ_UPDATED       2	/* recommended for IO completion */
> -#define SISL_MSI_ASYNC_ERROR       3	/* master only - for AFU async error */
> -
> -	u8 rrq;			/* 0 for a single RRQ */
> -	u16 timeout;		/* in units specified by req_flags */
> -	u32 rsvd1;
> -	u8 cdb[16];		/* must be in big endian */
> -#define SISL_AFU_CMD_SYNC		0xC0	/* AFU sync command */
> -#define SISL_AFU_CMD_LUN_PROVISION	0xD0	/* AFU LUN provision command */
> -#define SISL_AFU_CMD_DEBUG		0xE0	/* AFU debug command */
> -
> -#define SISL_AFU_LUN_PROVISION_CREATE	0x00	/* LUN provision create type */
> -#define SISL_AFU_LUN_PROVISION_DELETE	0x01	/* LUN provision delete type */
> -
> -	union {
> -		u64 reserved;			/* Reserved for IOARRIN mode */
> -		struct sisl_ioasa *ioasa;	/* IOASA EA for SQ Mode */
> -	};
> -} __packed;
> -
> -struct sisl_rc {
> -	u8 flags;
> -#define SISL_RC_FLAGS_SENSE_VALID         0x80U
> -#define SISL_RC_FLAGS_FCP_RSP_CODE_VALID  0x40U
> -#define SISL_RC_FLAGS_OVERRUN             0x20U
> -#define SISL_RC_FLAGS_UNDERRUN            0x10U
> -
> -	u8 afu_rc;
> -#define SISL_AFU_RC_RHT_INVALID           0x01U	/* user error */
> -#define SISL_AFU_RC_RHT_UNALIGNED         0x02U	/* should never happen */
> -#define SISL_AFU_RC_RHT_OUT_OF_BOUNDS     0x03u	/* user error */
> -#define SISL_AFU_RC_RHT_DMA_ERR           0x04u	/* see afu_extra
> -						 * may retry if afu_retry is off
> -						 * possible on master exit
> -						 */
> -#define SISL_AFU_RC_RHT_RW_PERM           0x05u	/* no RW perms, user error */
> -#define SISL_AFU_RC_LXT_UNALIGNED         0x12U	/* should never happen */
> -#define SISL_AFU_RC_LXT_OUT_OF_BOUNDS     0x13u	/* user error */
> -#define SISL_AFU_RC_LXT_DMA_ERR           0x14u	/* see afu_extra
> -						 * may retry if afu_retry is off
> -						 * possible on master exit
> -						 */
> -#define SISL_AFU_RC_LXT_RW_PERM           0x15u	/* no RW perms, user error */
> -
> -#define SISL_AFU_RC_NOT_XLATE_HOST        0x1au	/* possible if master exited */
> -
> -	/* NO_CHANNELS means the FC ports selected by dest_port in
> -	 * IOARCB or in the LXT entry are down when the AFU tried to select
> -	 * a FC port. If the port went down on an active IO, it will set
> -	 * fc_rc to =0x54(NOLOGI) or 0x57(LINKDOWN) instead.
> -	 */
> -#define SISL_AFU_RC_NO_CHANNELS           0x20U	/* see afu_extra, may retry */
> -#define SISL_AFU_RC_CAP_VIOLATION         0x21U	/* either user error or
> -						 * afu reset/master restart
> -						 */
> -#define SISL_AFU_RC_OUT_OF_DATA_BUFS      0x30U	/* always retry */
> -#define SISL_AFU_RC_DATA_DMA_ERR          0x31U	/* see afu_extra
> -						 * may retry if afu_retry is off
> -						 */
> -
> -	u8 scsi_rc;		/* SCSI status byte, retry as appropriate */
> -#define SISL_SCSI_RC_CHECK                0x02U
> -#define SISL_SCSI_RC_BUSY                 0x08u
> -
> -	u8 fc_rc;		/* retry */
> -	/*
> -	 * We should only see fc_rc=0x57 (LINKDOWN) or 0x54(NOLOGI) for
> -	 * commands that are in flight when a link goes down or is logged out.
> -	 * If the link is down or logged out before AFU selects the port, either
> -	 * it will choose the other port or we will get afu_rc=0x20 (no_channel)
> -	 * if there is no valid port to use.
> -	 *
> -	 * ABORTPEND/ABORTOK/ABORTFAIL/TGTABORT can be retried, typically these
> -	 * would happen if a frame is dropped and something times out.
> -	 * NOLOGI or LINKDOWN can be retried if the other port is up.
> -	 * RESIDERR can be retried as well.
> -	 *
> -	 * ABORTFAIL might indicate that lots of frames are getting CRC errors.
> -	 * So it maybe retried once and reset the link if it happens again.
> -	 * The link can also be reset on the CRC error threshold interrupt.
> -	 */
> -#define SISL_FC_RC_ABORTPEND	0x52	/* exchange timeout or abort request */
> -#define SISL_FC_RC_WRABORTPEND	0x53	/* due to write XFER_RDY invalid */
> -#define SISL_FC_RC_NOLOGI	0x54	/* port not logged in, in-flight cmds */
> -#define SISL_FC_RC_NOEXP	0x55	/* FC protocol error or HW bug */
> -#define SISL_FC_RC_INUSE	0x56	/* tag already in use, HW bug */
> -#define SISL_FC_RC_LINKDOWN	0x57	/* link down, in-flight cmds */
> -#define SISL_FC_RC_ABORTOK	0x58	/* pending abort completed w/success */
> -#define SISL_FC_RC_ABORTFAIL	0x59	/* pending abort completed w/fail */
> -#define SISL_FC_RC_RESID	0x5A	/* ioasa underrun/overrun flags set */
> -#define SISL_FC_RC_RESIDERR	0x5B	/* actual data len does not match SCSI
> -					 * reported len, possibly due to dropped
> -					 * frames
> -					 */
> -#define SISL_FC_RC_TGTABORT	0x5C	/* command aborted by target */
> -};
> -
> -#define SISL_SENSE_DATA_LEN     20	/* Sense data length         */
> -#define SISL_WWID_DATA_LEN	16	/* WWID data length          */
> -
> -/*
> - * IOASA: 64 bytes & must follow IOARCB, min 16 byte alignment required,
> - * host native endianness
> - */
> -struct sisl_ioasa {
> -	union {
> -		struct sisl_rc rc;
> -		u32 ioasc;
> -#define SISL_IOASC_GOOD_COMPLETION        0x00000000U
> -	};
> -
> -	union {
> -		u32 resid;
> -		u32 lunid_hi;
> -	};
> -
> -	u8 port;
> -	u8 afu_extra;
> -	/* when afu_rc=0x04, 0x14, 0x31 (_xxx_DMA_ERR):
> -	 * afu_exta contains PSL response code. Useful codes are:
> -	 */
> -#define SISL_AFU_DMA_ERR_PAGE_IN	0x0A	/* AFU_retry_on_pagein Action
> -						 *  Enabled            N/A
> -						 *  Disabled           retry
> -						 */
> -#define SISL_AFU_DMA_ERR_INVALID_EA	0x0B	/* this is a hard error
> -						 * afu_rc	Implies
> -						 * 0x04, 0x14	master exit.
> -						 * 0x31         user error.
> -						 */
> -	/* when afu rc=0x20 (no channels):
> -	 * afu_extra bits [4:5]: available portmask,  [6:7]: requested portmask.
> -	 */
> -#define SISL_AFU_NO_CLANNELS_AMASK(afu_extra) (((afu_extra) & 0x0C) >> 2)
> -#define SISL_AFU_NO_CLANNELS_RMASK(afu_extra) ((afu_extra) & 0x03)
> -
> -	u8 scsi_extra;
> -	u8 fc_extra;
> -
> -	union {
> -		u8 sense_data[SISL_SENSE_DATA_LEN];
> -		struct {
> -			u32 lunid_lo;
> -			u8 wwid[SISL_WWID_DATA_LEN];
> -		};
> -	};
> -
> -	/* These fields are defined by the SISlite architecture for the
> -	 * host to use as they see fit for their implementation.
> -	 */
> -	union {
> -		u64 host_use[4];
> -		u8 host_use_b[32];
> -	};
> -} __packed;
> -
> -#define SISL_RESP_HANDLE_T_BIT        0x1ULL	/* Toggle bit */
> -
> -/* MMIO space is required to support only 64-bit access */
> -
> -/*
> - * This AFU has two mechanisms to deal with endian-ness.
> - * One is a global configuration (in the afu_config) register
> - * below that specifies the endian-ness of the host.
> - * The other is a per context (i.e. application) specification
> - * controlled by the endian_ctrl field here. Since the master
> - * context is one such application the master context's
> - * endian-ness is set to be the same as the host.
> - *
> - * As per the SISlite spec, the MMIO registers are always
> - * big endian.
> - */
> -#define SISL_ENDIAN_CTRL_BE           0x8000000000000080ULL
> -#define SISL_ENDIAN_CTRL_LE           0x0000000000000000ULL
> -
> -#ifdef __BIG_ENDIAN
> -#define SISL_ENDIAN_CTRL              SISL_ENDIAN_CTRL_BE
> -#else
> -#define SISL_ENDIAN_CTRL              SISL_ENDIAN_CTRL_LE
> -#endif
> -
> -/* per context host transport MMIO  */
> -struct sisl_host_map {
> -	__be64 endian_ctrl;	/* Per context Endian Control. The AFU will
> -				 * operate on whatever the context is of the
> -				 * host application.
> -				 */
> -
> -	__be64 intr_status;	/* this sends LISN# programmed in ctx_ctrl.
> -				 * Only recovery in a PERM_ERR is a context
> -				 * exit since there is no way to tell which
> -				 * command caused the error.
> -				 */
> -#define SISL_ISTATUS_PERM_ERR_LISN_3_EA		0x0400ULL /* b53, user error */
> -#define SISL_ISTATUS_PERM_ERR_LISN_2_EA		0x0200ULL /* b54, user error */
> -#define SISL_ISTATUS_PERM_ERR_LISN_1_EA		0x0100ULL /* b55, user error */
> -#define SISL_ISTATUS_PERM_ERR_LISN_3_PASID	0x0080ULL /* b56, user error */
> -#define SISL_ISTATUS_PERM_ERR_LISN_2_PASID	0x0040ULL /* b57, user error */
> -#define SISL_ISTATUS_PERM_ERR_LISN_1_PASID	0x0020ULL /* b58, user error */
> -#define SISL_ISTATUS_PERM_ERR_CMDROOM		0x0010ULL /* b59, user error */
> -#define SISL_ISTATUS_PERM_ERR_RCB_READ		0x0008ULL /* b60, user error */
> -#define SISL_ISTATUS_PERM_ERR_SA_WRITE		0x0004ULL /* b61, user error */
> -#define SISL_ISTATUS_PERM_ERR_RRQ_WRITE		0x0002ULL /* b62, user error */
> -	/* Page in wait accessing RCB/IOASA/RRQ is reported in b63.
> -	 * Same error in data/LXT/RHT access is reported via IOASA.
> -	 */
> -#define SISL_ISTATUS_TEMP_ERR_PAGEIN		0x0001ULL /* b63, can only be
> -							   * generated when AFU
> -							   * auto retry is
> -							   * disabled. If user
> -							   * can determine the
> -							   * command that caused
> -							   * the error, it can
> -							   * be retried.
> -							   */
> -#define SISL_ISTATUS_UNMASK	(0x07FFULL)		/* 1 means unmasked */
> -#define SISL_ISTATUS_MASK	~(SISL_ISTATUS_UNMASK)	/* 1 means masked */
> -
> -	__be64 intr_clear;
> -	__be64 intr_mask;
> -	__be64 ioarrin;		/* only write what cmd_room permits */
> -	__be64 rrq_start;	/* start & end are both inclusive */
> -	__be64 rrq_end;		/* write sequence: start followed by end */
> -	__be64 cmd_room;
> -	__be64 ctx_ctrl;	/* least significant byte or b56:63 is LISN# */
> -#define SISL_CTX_CTRL_UNMAP_SECTOR	0x8000000000000000ULL /* b0 */
> -#define SISL_CTX_CTRL_LISN_MASK		(0xFFULL)
> -	__be64 mbox_w;		/* restricted use */
> -	__be64 sq_start;	/* Submission Queue (R/W): write sequence and */
> -	__be64 sq_end;		/* inclusion semantics are the same as RRQ    */
> -	__be64 sq_head;		/* Submission Queue Head (R): for debugging   */
> -	__be64 sq_tail;		/* Submission Queue TAIL (R/W): next IOARCB   */
> -	__be64 sq_ctx_reset;	/* Submission Queue Context Reset (R/W)	      */
> -};
> -
> -/* per context provisioning & control MMIO */
> -struct sisl_ctrl_map {
> -	__be64 rht_start;
> -	__be64 rht_cnt_id;
> -	/* both cnt & ctx_id args must be ULL */
> -#define SISL_RHT_CNT_ID(cnt, ctx_id)  (((cnt) << 48) | ((ctx_id) << 32))
> -
> -	__be64 ctx_cap;	/* afu_rc below is when the capability is violated */
> -#define SISL_CTX_CAP_PROXY_ISSUE       0x8000000000000000ULL /* afu_rc 0x21 */
> -#define SISL_CTX_CAP_REAL_MODE         0x4000000000000000ULL /* afu_rc 0x21 */
> -#define SISL_CTX_CAP_HOST_XLATE        0x2000000000000000ULL /* afu_rc 0x1a */
> -#define SISL_CTX_CAP_PROXY_TARGET      0x1000000000000000ULL /* afu_rc 0x21 */
> -#define SISL_CTX_CAP_AFU_CMD           0x0000000000000008ULL /* afu_rc 0x21 */
> -#define SISL_CTX_CAP_GSCSI_CMD         0x0000000000000004ULL /* afu_rc 0x21 */
> -#define SISL_CTX_CAP_WRITE_CMD         0x0000000000000002ULL /* afu_rc 0x21 */
> -#define SISL_CTX_CAP_READ_CMD          0x0000000000000001ULL /* afu_rc 0x21 */
> -	__be64 mbox_r;
> -	__be64 lisn_pasid[2];
> -	/* pasid _a arg must be ULL */
> -#define SISL_LISN_PASID(_a, _b)	(((_a) << 32) | (_b))
> -	__be64 lisn_ea[3];
> -};
> -
> -/* single copy global regs */
> -struct sisl_global_regs {
> -	__be64 aintr_status;
> -	/*
> -	 * In cxlflash, FC port/link are arranged in port pairs, each
> -	 * gets a byte of status:
> -	 *
> -	 *	*_OTHER:	other err, FC_ERRCAP[31:20]
> -	 *	*_LOGO:		target sent FLOGI/PLOGI/LOGO while logged in
> -	 *	*_CRC_T:	CRC threshold exceeded
> -	 *	*_LOGI_R:	login state machine timed out and retrying
> -	 *	*_LOGI_F:	login failed, FC_ERROR[19:0]
> -	 *	*_LOGI_S:	login succeeded
> -	 *	*_LINK_DN:	link online to offline
> -	 *	*_LINK_UP:	link offline to online
> -	 */
> -#define SISL_ASTATUS_FC2_OTHER	 0x80000000ULL /* b32 */
> -#define SISL_ASTATUS_FC2_LOGO    0x40000000ULL /* b33 */
> -#define SISL_ASTATUS_FC2_CRC_T   0x20000000ULL /* b34 */
> -#define SISL_ASTATUS_FC2_LOGI_R  0x10000000ULL /* b35 */
> -#define SISL_ASTATUS_FC2_LOGI_F  0x08000000ULL /* b36 */
> -#define SISL_ASTATUS_FC2_LOGI_S  0x04000000ULL /* b37 */
> -#define SISL_ASTATUS_FC2_LINK_DN 0x02000000ULL /* b38 */
> -#define SISL_ASTATUS_FC2_LINK_UP 0x01000000ULL /* b39 */
> -
> -#define SISL_ASTATUS_FC3_OTHER   0x00800000ULL /* b40 */
> -#define SISL_ASTATUS_FC3_LOGO    0x00400000ULL /* b41 */
> -#define SISL_ASTATUS_FC3_CRC_T   0x00200000ULL /* b42 */
> -#define SISL_ASTATUS_FC3_LOGI_R  0x00100000ULL /* b43 */
> -#define SISL_ASTATUS_FC3_LOGI_F  0x00080000ULL /* b44 */
> -#define SISL_ASTATUS_FC3_LOGI_S  0x00040000ULL /* b45 */
> -#define SISL_ASTATUS_FC3_LINK_DN 0x00020000ULL /* b46 */
> -#define SISL_ASTATUS_FC3_LINK_UP 0x00010000ULL /* b47 */
> -
> -#define SISL_ASTATUS_FC0_OTHER	 0x00008000ULL /* b48 */
> -#define SISL_ASTATUS_FC0_LOGO    0x00004000ULL /* b49 */
> -#define SISL_ASTATUS_FC0_CRC_T   0x00002000ULL /* b50 */
> -#define SISL_ASTATUS_FC0_LOGI_R  0x00001000ULL /* b51 */
> -#define SISL_ASTATUS_FC0_LOGI_F  0x00000800ULL /* b52 */
> -#define SISL_ASTATUS_FC0_LOGI_S  0x00000400ULL /* b53 */
> -#define SISL_ASTATUS_FC0_LINK_DN 0x00000200ULL /* b54 */
> -#define SISL_ASTATUS_FC0_LINK_UP 0x00000100ULL /* b55 */
> -
> -#define SISL_ASTATUS_FC1_OTHER   0x00000080ULL /* b56 */
> -#define SISL_ASTATUS_FC1_LOGO    0x00000040ULL /* b57 */
> -#define SISL_ASTATUS_FC1_CRC_T   0x00000020ULL /* b58 */
> -#define SISL_ASTATUS_FC1_LOGI_R  0x00000010ULL /* b59 */
> -#define SISL_ASTATUS_FC1_LOGI_F  0x00000008ULL /* b60 */
> -#define SISL_ASTATUS_FC1_LOGI_S  0x00000004ULL /* b61 */
> -#define SISL_ASTATUS_FC1_LINK_DN 0x00000002ULL /* b62 */
> -#define SISL_ASTATUS_FC1_LINK_UP 0x00000001ULL /* b63 */
> -
> -#define SISL_FC_INTERNAL_UNMASK	0x0000000300000000ULL	/* 1 means unmasked */
> -#define SISL_FC_INTERNAL_MASK	~(SISL_FC_INTERNAL_UNMASK)
> -#define SISL_FC_INTERNAL_SHIFT	32
> -
> -#define SISL_FC_SHUTDOWN_NORMAL		0x0000000000000010ULL
> -#define SISL_FC_SHUTDOWN_ABRUPT		0x0000000000000020ULL
> -
> -#define SISL_STATUS_SHUTDOWN_ACTIVE	0x0000000000000010ULL
> -#define SISL_STATUS_SHUTDOWN_COMPLETE	0x0000000000000020ULL
> -
> -#define SISL_ASTATUS_UNMASK	0xFFFFFFFFULL		/* 1 means unmasked */
> -#define SISL_ASTATUS_MASK	~(SISL_ASTATUS_UNMASK)	/* 1 means masked */
> -
> -	__be64 aintr_clear;
> -	__be64 aintr_mask;
> -	__be64 afu_ctrl;
> -	__be64 afu_hb;
> -	__be64 afu_scratch_pad;
> -	__be64 afu_port_sel;
> -#define SISL_AFUCONF_AR_IOARCB	0x4000ULL
> -#define SISL_AFUCONF_AR_LXT	0x2000ULL
> -#define SISL_AFUCONF_AR_RHT	0x1000ULL
> -#define SISL_AFUCONF_AR_DATA	0x0800ULL
> -#define SISL_AFUCONF_AR_RSRC	0x0400ULL
> -#define SISL_AFUCONF_AR_IOASA	0x0200ULL
> -#define SISL_AFUCONF_AR_RRQ	0x0100ULL
> -/* Aggregate all Auto Retry Bits */
> -#define SISL_AFUCONF_AR_ALL	(SISL_AFUCONF_AR_IOARCB|SISL_AFUCONF_AR_LXT| \
> -				 SISL_AFUCONF_AR_RHT|SISL_AFUCONF_AR_DATA|   \
> -				 SISL_AFUCONF_AR_RSRC|SISL_AFUCONF_AR_IOASA| \
> -				 SISL_AFUCONF_AR_RRQ)
> -#ifdef __BIG_ENDIAN
> -#define SISL_AFUCONF_ENDIAN            0x0000ULL
> -#else
> -#define SISL_AFUCONF_ENDIAN            0x0020ULL
> -#endif
> -#define SISL_AFUCONF_MBOX_CLR_READ     0x0010ULL
> -	__be64 afu_config;
> -	__be64 rsvd[0xf8];
> -	__le64 afu_version;
> -	__be64 interface_version;
> -#define SISL_INTVER_CAP_SHIFT			16
> -#define SISL_INTVER_MAJ_SHIFT			8
> -#define SISL_INTVER_CAP_MASK			0xFFFFFFFF00000000ULL
> -#define SISL_INTVER_MAJ_MASK			0x00000000FFFF0000ULL
> -#define SISL_INTVER_MIN_MASK			0x000000000000FFFFULL
> -#define SISL_INTVER_CAP_IOARRIN_CMD_MODE	0x800000000000ULL
> -#define SISL_INTVER_CAP_SQ_CMD_MODE		0x400000000000ULL
> -#define SISL_INTVER_CAP_RESERVED_CMD_MODE_A	0x200000000000ULL
> -#define SISL_INTVER_CAP_RESERVED_CMD_MODE_B	0x100000000000ULL
> -#define SISL_INTVER_CAP_LUN_PROVISION		0x080000000000ULL
> -#define SISL_INTVER_CAP_AFU_DEBUG		0x040000000000ULL
> -#define SISL_INTVER_CAP_OCXL_LISN		0x020000000000ULL
> -};
> -
> -#define CXLFLASH_NUM_FC_PORTS_PER_BANK	2	/* fixed # of ports per bank */
> -#define CXLFLASH_MAX_FC_BANKS		2	/* max # of banks supported */
> -#define CXLFLASH_MAX_FC_PORTS	(CXLFLASH_NUM_FC_PORTS_PER_BANK *	\
> -				 CXLFLASH_MAX_FC_BANKS)
> -#define CXLFLASH_MAX_CONTEXT	512	/* number of contexts per AFU */
> -#define CXLFLASH_NUM_VLUNS	512	/* number of vluns per AFU/port */
> -#define CXLFLASH_NUM_REGS	512	/* number of registers per port */
> -
> -struct fc_port_bank {
> -	__be64 fc_port_regs[CXLFLASH_NUM_FC_PORTS_PER_BANK][CXLFLASH_NUM_REGS];
> -	__be64 fc_port_luns[CXLFLASH_NUM_FC_PORTS_PER_BANK][CXLFLASH_NUM_VLUNS];
> -};
> -
> -struct sisl_global_map {
> -	union {
> -		struct sisl_global_regs regs;
> -		char page0[SIZE_4K];	/* page 0 */
> -	};
> -
> -	char page1[SIZE_4K];	/* page 1 */
> -
> -	struct fc_port_bank bank[CXLFLASH_MAX_FC_BANKS]; /* pages 2 - 9 */
> -
> -	/* pages 10 - 15 are reserved */
> -
> -};
> -
> -/*
> - * CXL Flash Memory Map
> - *
> - *	+-------------------------------+
> - *	|    512 * 64 KB User MMIO      |
> - *	|        (per context)          |
> - *	|       User Accessible         |
> - *	+-------------------------------+
> - *	|    512 * 128 B per context    |
> - *	|    Provisioning and Control   |
> - *	|   Trusted Process accessible  |
> - *	+-------------------------------+
> - *	|         64 KB Global          |
> - *	|   Trusted Process accessible  |
> - *	+-------------------------------+
> - */
> -struct cxlflash_afu_map {
> -	union {
> -		struct sisl_host_map host;
> -		char harea[SIZE_64K];	/* 64KB each */
> -	} hosts[CXLFLASH_MAX_CONTEXT];
> -
> -	union {
> -		struct sisl_ctrl_map ctrl;
> -		char carea[cache_line_size()];	/* 128B each */
> -	} ctrls[CXLFLASH_MAX_CONTEXT];
> -
> -	union {
> -		struct sisl_global_map global;
> -		char garea[SIZE_64K];	/* 64KB single block */
> -	};
> -};
> -
> -/*
> - * LXT - LBA Translation Table
> - * LXT control blocks
> - */
> -struct sisl_lxt_entry {
> -	u64 rlba_base;	/* bits 0:47 is base
> -			 * b48:55 is lun index
> -			 * b58:59 is write & read perms
> -			 * (if no perm, afu_rc=0x15)
> -			 * b60:63 is port_sel mask
> -			 */
> -};
> -
> -/*
> - * RHT - Resource Handle Table
> - * Per the SISlite spec, RHT entries are to be 16-byte aligned
> - */
> -struct sisl_rht_entry {
> -	struct sisl_lxt_entry *lxt_start;
> -	u32 lxt_cnt;
> -	u16 rsvd;
> -	u8 fp;			/* format & perm nibbles.
> -				 * (if no perm, afu_rc=0x05)
> -				 */
> -	u8 nmask;
> -} __packed __aligned(16);
> -
> -struct sisl_rht_entry_f1 {
> -	u64 lun_id;
> -	union {
> -		struct {
> -			u8 valid;
> -			u8 rsvd[5];
> -			u8 fp;
> -			u8 port_sel;
> -		};
> -
> -		u64 dw;
> -	};
> -} __packed __aligned(16);
> -
> -/* make the fp byte */
> -#define SISL_RHT_FP(fmt, perm) (((fmt) << 4) | (perm))
> -
> -/* make the fp byte for a clone from a source fp and clone flags
> - * flags must be only 2 LSB bits.
> - */
> -#define SISL_RHT_FP_CLONE(src_fp, cln_flags) ((src_fp) & (0xFC | (cln_flags)))
> -
> -#define RHT_PERM_READ  0x01U
> -#define RHT_PERM_WRITE 0x02U
> -#define RHT_PERM_RW    (RHT_PERM_READ | RHT_PERM_WRITE)
> -
> -/* extract the perm bits from a fp */
> -#define SISL_RHT_PERM(fp) ((fp) & RHT_PERM_RW)
> -
> -#define PORT0  0x01U
> -#define PORT1  0x02U
> -#define PORT2  0x04U
> -#define PORT3  0x08U
> -#define PORT_MASK(_n)	((1 << (_n)) - 1)
> -
> -/* AFU Sync Mode byte */
> -#define AFU_LW_SYNC 0x0U
> -#define AFU_HW_SYNC 0x1U
> -#define AFU_GSYNC   0x2U
> -
> -/* Special Task Management Function CDB */
> -#define TMF_LUN_RESET  0x1U
> -#define TMF_CLEAR_ACA  0x2U
> -
> -#endif /* _SISLITE_H */
> diff --git a/drivers/scsi/cxlflash/superpipe.c b/drivers/scsi/cxlflash/superpipe.c
> deleted file mode 100644
> index 97631f48e19d..000000000000
> --- a/drivers/scsi/cxlflash/superpipe.c
> +++ /dev/null
> @@ -1,2218 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * CXL Flash Device Driver
> - *
> - * Written by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>, IBM Corporation
> - *             Matthew R. Ochs <mrochs@linux.vnet.ibm.com>, IBM Corporation
> - *
> - * Copyright (C) 2015 IBM Corporation
> - */
> -
> -#include <linux/delay.h>
> -#include <linux/file.h>
> -#include <linux/interrupt.h>
> -#include <linux/pci.h>
> -#include <linux/syscalls.h>
> -#include <linux/unaligned.h>
> -
> -#include <scsi/scsi.h>
> -#include <scsi/scsi_host.h>
> -#include <scsi/scsi_cmnd.h>
> -#include <scsi/scsi_eh.h>
> -#include <uapi/scsi/cxlflash_ioctl.h>
> -
> -#include "sislite.h"
> -#include "common.h"
> -#include "vlun.h"
> -#include "superpipe.h"
> -
> -struct cxlflash_global global;
> -
> -/**
> - * marshal_rele_to_resize() - translate release to resize structure
> - * @release:	Source structure from which to translate/copy.
> - * @resize:	Destination structure for the translate/copy.
> - */
> -static void marshal_rele_to_resize(struct dk_cxlflash_release *release,
> -				   struct dk_cxlflash_resize *resize)
> -{
> -	resize->hdr = release->hdr;
> -	resize->context_id = release->context_id;
> -	resize->rsrc_handle = release->rsrc_handle;
> -}
> -
> -/**
> - * marshal_det_to_rele() - translate detach to release structure
> - * @detach:	Destination structure for the translate/copy.
> - * @release:	Source structure from which to translate/copy.
> - */
> -static void marshal_det_to_rele(struct dk_cxlflash_detach *detach,
> -				struct dk_cxlflash_release *release)
> -{
> -	release->hdr = detach->hdr;
> -	release->context_id = detach->context_id;
> -}
> -
> -/**
> - * marshal_udir_to_rele() - translate udirect to release structure
> - * @udirect:	Source structure from which to translate/copy.
> - * @release:	Destination structure for the translate/copy.
> - */
> -static void marshal_udir_to_rele(struct dk_cxlflash_udirect *udirect,
> -				 struct dk_cxlflash_release *release)
> -{
> -	release->hdr = udirect->hdr;
> -	release->context_id = udirect->context_id;
> -	release->rsrc_handle = udirect->rsrc_handle;
> -}
> -
> -/**
> - * cxlflash_free_errpage() - frees resources associated with global error page
> - */
> -void cxlflash_free_errpage(void)
> -{
> -
> -	mutex_lock(&global.mutex);
> -	if (global.err_page) {
> -		__free_page(global.err_page);
> -		global.err_page = NULL;
> -	}
> -	mutex_unlock(&global.mutex);
> -}
> -
> -/**
> - * cxlflash_stop_term_user_contexts() - stops/terminates known user contexts
> - * @cfg:	Internal structure associated with the host.
> - *
> - * When the host needs to go down, all users must be quiesced and their
> - * memory freed. This is accomplished by putting the contexts in error
> - * state which will notify the user and let them 'drive' the tear down.
> - * Meanwhile, this routine camps until all user contexts have been removed.
> - *
> - * Note that the main loop in this routine will always execute at least once
> - * to flush the reset_waitq.
> - */
> -void cxlflash_stop_term_user_contexts(struct cxlflash_cfg *cfg)
> -{
> -	struct device *dev = &cfg->dev->dev;
> -	int i, found = true;
> -
> -	cxlflash_mark_contexts_error(cfg);
> -
> -	while (true) {
> -		for (i = 0; i < MAX_CONTEXT; i++)
> -			if (cfg->ctx_tbl[i]) {
> -				found = true;
> -				break;
> -			}
> -
> -		if (!found && list_empty(&cfg->ctx_err_recovery))
> -			return;
> -
> -		dev_dbg(dev, "%s: Wait for user contexts to quiesce...\n",
> -			__func__);
> -		wake_up_all(&cfg->reset_waitq);
> -		ssleep(1);
> -		found = false;
> -	}
> -}
> -
> -/**
> - * find_error_context() - locates a context by cookie on the error recovery list
> - * @cfg:	Internal structure associated with the host.
> - * @rctxid:	Desired context by id.
> - * @file:	Desired context by file.
> - *
> - * Return: Found context on success, NULL on failure
> - */
> -static struct ctx_info *find_error_context(struct cxlflash_cfg *cfg, u64 rctxid,
> -					   struct file *file)
> -{
> -	struct ctx_info *ctxi;
> -
> -	list_for_each_entry(ctxi, &cfg->ctx_err_recovery, list)
> -		if ((ctxi->ctxid == rctxid) || (ctxi->file == file))
> -			return ctxi;
> -
> -	return NULL;
> -}
> -
> -/**
> - * get_context() - obtains a validated and locked context reference
> - * @cfg:	Internal structure associated with the host.
> - * @rctxid:	Desired context (raw, un-decoded format).
> - * @arg:	LUN information or file associated with request.
> - * @ctx_ctrl:	Control information to 'steer' desired lookup.
> - *
> - * NOTE: despite the name pid, in linux, current->pid actually refers
> - * to the lightweight process id (tid) and can change if the process is
> - * multi threaded. The tgid remains constant for the process and only changes
> - * when the process of fork. For all intents and purposes, think of tgid
> - * as a pid in the traditional sense.
> - *
> - * Return: Validated context on success, NULL on failure
> - */
> -struct ctx_info *get_context(struct cxlflash_cfg *cfg, u64 rctxid,
> -			     void *arg, enum ctx_ctrl ctx_ctrl)
> -{
> -	struct device *dev = &cfg->dev->dev;
> -	struct ctx_info *ctxi = NULL;
> -	struct lun_access *lun_access = NULL;
> -	struct file *file = NULL;
> -	struct llun_info *lli = arg;
> -	u64 ctxid = DECODE_CTXID(rctxid);
> -	int rc;
> -	pid_t pid = task_tgid_nr(current), ctxpid = 0;
> -
> -	if (ctx_ctrl & CTX_CTRL_FILE) {
> -		lli = NULL;
> -		file = (struct file *)arg;
> -	}
> -
> -	if (ctx_ctrl & CTX_CTRL_CLONE)
> -		pid = task_ppid_nr(current);
> -
> -	if (likely(ctxid < MAX_CONTEXT)) {
> -		while (true) {
> -			mutex_lock(&cfg->ctx_tbl_list_mutex);
> -			ctxi = cfg->ctx_tbl[ctxid];
> -			if (ctxi)
> -				if ((file && (ctxi->file != file)) ||
> -				    (!file && (ctxi->ctxid != rctxid)))
> -					ctxi = NULL;
> -
> -			if ((ctx_ctrl & CTX_CTRL_ERR) ||
> -			    (!ctxi && (ctx_ctrl & CTX_CTRL_ERR_FALLBACK)))
> -				ctxi = find_error_context(cfg, rctxid, file);
> -			if (!ctxi) {
> -				mutex_unlock(&cfg->ctx_tbl_list_mutex);
> -				goto out;
> -			}
> -
> -			/*
> -			 * Need to acquire ownership of the context while still
> -			 * under the table/list lock to serialize with a remove
> -			 * thread. Use the 'try' to avoid stalling the
> -			 * table/list lock for a single context.
> -			 *
> -			 * Note that the lock order is:
> -			 *
> -			 *	cfg->ctx_tbl_list_mutex -> ctxi->mutex
> -			 *
> -			 * Therefore release ctx_tbl_list_mutex before retrying.
> -			 */
> -			rc = mutex_trylock(&ctxi->mutex);
> -			mutex_unlock(&cfg->ctx_tbl_list_mutex);
> -			if (rc)
> -				break; /* got the context's lock! */
> -		}
> -
> -		if (ctxi->unavail)
> -			goto denied;
> -
> -		ctxpid = ctxi->pid;
> -		if (likely(!(ctx_ctrl & CTX_CTRL_NOPID)))
> -			if (pid != ctxpid)
> -				goto denied;
> -
> -		if (lli) {
> -			list_for_each_entry(lun_access, &ctxi->luns, list)
> -				if (lun_access->lli == lli)
> -					goto out;
> -			goto denied;
> -		}
> -	}
> -
> -out:
> -	dev_dbg(dev, "%s: rctxid=%016llx ctxinfo=%p ctxpid=%u pid=%u "
> -		"ctx_ctrl=%u\n", __func__, rctxid, ctxi, ctxpid, pid,
> -		ctx_ctrl);
> -
> -	return ctxi;
> -
> -denied:
> -	mutex_unlock(&ctxi->mutex);
> -	ctxi = NULL;
> -	goto out;
> -}
> -
> -/**
> - * put_context() - release a context that was retrieved from get_context()
> - * @ctxi:	Context to release.
> - *
> - * For now, releasing the context equates to unlocking it's mutex.
> - */
> -void put_context(struct ctx_info *ctxi)
> -{
> -	mutex_unlock(&ctxi->mutex);
> -}
> -
> -/**
> - * afu_attach() - attach a context to the AFU
> - * @cfg:	Internal structure associated with the host.
> - * @ctxi:	Context to attach.
> - *
> - * Upon setting the context capabilities, they must be confirmed with
> - * a read back operation as the context might have been closed since
> - * the mailbox was unlocked. When this occurs, registration is failed.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int afu_attach(struct cxlflash_cfg *cfg, struct ctx_info *ctxi)
> -{
> -	struct device *dev = &cfg->dev->dev;
> -	struct afu *afu = cfg->afu;
> -	struct sisl_ctrl_map __iomem *ctrl_map = ctxi->ctrl_map;
> -	int rc = 0;
> -	struct hwq *hwq = get_hwq(afu, PRIMARY_HWQ);
> -	u64 val;
> -	int i;
> -
> -	/* Unlock cap and restrict user to read/write cmds in translated mode */
> -	readq_be(&ctrl_map->mbox_r);
> -	val = (SISL_CTX_CAP_READ_CMD | SISL_CTX_CAP_WRITE_CMD);
> -	writeq_be(val, &ctrl_map->ctx_cap);
> -	val = readq_be(&ctrl_map->ctx_cap);
> -	if (val != (SISL_CTX_CAP_READ_CMD | SISL_CTX_CAP_WRITE_CMD)) {
> -		dev_err(dev, "%s: ctx may be closed val=%016llx\n",
> -			__func__, val);
> -		rc = -EAGAIN;
> -		goto out;
> -	}
> -
> -	if (afu_is_ocxl_lisn(afu)) {
> -		/* Set up the LISN effective address for each interrupt */
> -		for (i = 0; i < ctxi->irqs; i++) {
> -			val = cfg->ops->get_irq_objhndl(ctxi->ctx, i);
> -			writeq_be(val, &ctrl_map->lisn_ea[i]);
> -		}
> -
> -		/* Use primary HWQ PASID as identifier for all interrupts */
> -		val = hwq->ctx_hndl;
> -		writeq_be(SISL_LISN_PASID(val, val), &ctrl_map->lisn_pasid[0]);
> -		writeq_be(SISL_LISN_PASID(0UL, val), &ctrl_map->lisn_pasid[1]);
> -	}
> -
> -	/* Set up MMIO registers pointing to the RHT */
> -	writeq_be((u64)ctxi->rht_start, &ctrl_map->rht_start);
> -	val = SISL_RHT_CNT_ID((u64)MAX_RHT_PER_CONTEXT, (u64)(hwq->ctx_hndl));
> -	writeq_be(val, &ctrl_map->rht_cnt_id);
> -out:
> -	dev_dbg(dev, "%s: returning rc=%d\n", __func__, rc);
> -	return rc;
> -}
> -
> -/**
> - * read_cap16() - issues a SCSI READ_CAP16 command
> - * @sdev:	SCSI device associated with LUN.
> - * @lli:	LUN destined for capacity request.
> - *
> - * The READ_CAP16 can take quite a while to complete. Should an EEH occur while
> - * in scsi_execute_cmd(), the EEH handler will attempt to recover. As part of
> - * the recovery, the handler drains all currently running ioctls, waiting until
> - * they have completed before proceeding with a reset. As this routine is used
> - * on the ioctl path, this can create a condition where the EEH handler becomes
> - * stuck, infinitely waiting for this ioctl thread. To avoid this behavior,
> - * temporarily unmark this thread as an ioctl thread by releasing the ioctl
> - * read semaphore. This will allow the EEH handler to proceed with a recovery
> - * while this thread is still running. Once the scsi_execute_cmd() returns,
> - * reacquire the ioctl read semaphore and check the adapter state in case it
> - * changed while inside of scsi_execute_cmd(). The state check will wait if the
> - * adapter is still being recovered or return a failure if the recovery failed.
> - * In the event that the adapter reset failed, simply return the failure as the
> - * ioctl would be unable to continue.
> - *
> - * Note that the above puts a requirement on this routine to only be called on
> - * an ioctl thread.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int read_cap16(struct scsi_device *sdev, struct llun_info *lli)
> -{
> -	struct cxlflash_cfg *cfg = shost_priv(sdev->host);
> -	struct device *dev = &cfg->dev->dev;
> -	struct glun_info *gli = lli->parent;
> -	struct scsi_sense_hdr sshdr;
> -	const struct scsi_exec_args exec_args = {
> -		.sshdr = &sshdr,
> -	};
> -	u8 *cmd_buf = NULL;
> -	u8 *scsi_cmd = NULL;
> -	int rc = 0;
> -	int result = 0;
> -	int retry_cnt = 0;
> -	u32 to = CMD_TIMEOUT * HZ;
> -
> -retry:
> -	cmd_buf = kzalloc(CMD_BUFSIZE, GFP_KERNEL);
> -	scsi_cmd = kzalloc(MAX_COMMAND_SIZE, GFP_KERNEL);
> -	if (unlikely(!cmd_buf || !scsi_cmd)) {
> -		rc = -ENOMEM;
> -		goto out;
> -	}
> -
> -	scsi_cmd[0] = SERVICE_ACTION_IN_16;	/* read cap(16) */
> -	scsi_cmd[1] = SAI_READ_CAPACITY_16;	/* service action */
> -	put_unaligned_be32(CMD_BUFSIZE, &scsi_cmd[10]);
> -
> -	dev_dbg(dev, "%s: %ssending cmd(%02x)\n", __func__,
> -		retry_cnt ? "re" : "", scsi_cmd[0]);
> -
> -	/* Drop the ioctl read semaphore across lengthy call */
> -	up_read(&cfg->ioctl_rwsem);
> -	result = scsi_execute_cmd(sdev, scsi_cmd, REQ_OP_DRV_IN, cmd_buf,
> -				  CMD_BUFSIZE, to, CMD_RETRIES, &exec_args);
> -	down_read(&cfg->ioctl_rwsem);
> -	rc = check_state(cfg);
> -	if (rc) {
> -		dev_err(dev, "%s: Failed state result=%08x\n",
> -			__func__, result);
> -		rc = -ENODEV;
> -		goto out;
> -	}
> -
> -	if (result > 0 && scsi_sense_valid(&sshdr)) {
> -		if (result & SAM_STAT_CHECK_CONDITION) {
> -			switch (sshdr.sense_key) {
> -			case NO_SENSE:
> -			case RECOVERED_ERROR:
> -			case NOT_READY:
> -				result &= ~SAM_STAT_CHECK_CONDITION;
> -				break;
> -			case UNIT_ATTENTION:
> -				switch (sshdr.asc) {
> -				case 0x29: /* Power on Reset or Device Reset */
> -					fallthrough;
> -				case 0x2A: /* Device capacity changed */
> -				case 0x3F: /* Report LUNs changed */
> -					/* Retry the command once more */
> -					if (retry_cnt++ < 1) {
> -						kfree(cmd_buf);
> -						kfree(scsi_cmd);
> -						goto retry;
> -					}
> -				}
> -				break;
> -			default:
> -				break;
> -			}
> -		}
> -	}
> -
> -	if (result) {
> -		dev_err(dev, "%s: command failed, result=%08x\n",
> -			__func__, result);
> -		rc = -EIO;
> -		goto out;
> -	}
> -
> -	/*
> -	 * Read cap was successful, grab values from the buffer;
> -	 * note that we don't need to worry about unaligned access
> -	 * as the buffer is allocated on an aligned boundary.
> -	 */
> -	mutex_lock(&gli->mutex);
> -	gli->max_lba = be64_to_cpu(*((__be64 *)&cmd_buf[0]));
> -	gli->blk_len = be32_to_cpu(*((__be32 *)&cmd_buf[8]));
> -	mutex_unlock(&gli->mutex);
> -
> -out:
> -	kfree(cmd_buf);
> -	kfree(scsi_cmd);
> -
> -	dev_dbg(dev, "%s: maxlba=%lld blklen=%d rc=%d\n",
> -		__func__, gli->max_lba, gli->blk_len, rc);
> -	return rc;
> -}
> -
> -/**
> - * get_rhte() - obtains validated resource handle table entry reference
> - * @ctxi:	Context owning the resource handle.
> - * @rhndl:	Resource handle associated with entry.
> - * @lli:	LUN associated with request.
> - *
> - * Return: Validated RHTE on success, NULL on failure
> - */
> -struct sisl_rht_entry *get_rhte(struct ctx_info *ctxi, res_hndl_t rhndl,
> -				struct llun_info *lli)
> -{
> -	struct cxlflash_cfg *cfg = ctxi->cfg;
> -	struct device *dev = &cfg->dev->dev;
> -	struct sisl_rht_entry *rhte = NULL;
> -
> -	if (unlikely(!ctxi->rht_start)) {
> -		dev_dbg(dev, "%s: Context does not have allocated RHT\n",
> -			 __func__);
> -		goto out;
> -	}
> -
> -	if (unlikely(rhndl >= MAX_RHT_PER_CONTEXT)) {
> -		dev_dbg(dev, "%s: Bad resource handle rhndl=%d\n",
> -			__func__, rhndl);
> -		goto out;
> -	}
> -
> -	if (unlikely(ctxi->rht_lun[rhndl] != lli)) {
> -		dev_dbg(dev, "%s: Bad resource handle LUN rhndl=%d\n",
> -			__func__, rhndl);
> -		goto out;
> -	}
> -
> -	rhte = &ctxi->rht_start[rhndl];
> -	if (unlikely(rhte->nmask == 0)) {
> -		dev_dbg(dev, "%s: Unopened resource handle rhndl=%d\n",
> -			__func__, rhndl);
> -		rhte = NULL;
> -		goto out;
> -	}
> -
> -out:
> -	return rhte;
> -}
> -
> -/**
> - * rhte_checkout() - obtains free/empty resource handle table entry
> - * @ctxi:	Context owning the resource handle.
> - * @lli:	LUN associated with request.
> - *
> - * Return: Free RHTE on success, NULL on failure
> - */
> -struct sisl_rht_entry *rhte_checkout(struct ctx_info *ctxi,
> -				     struct llun_info *lli)
> -{
> -	struct cxlflash_cfg *cfg = ctxi->cfg;
> -	struct device *dev = &cfg->dev->dev;
> -	struct sisl_rht_entry *rhte = NULL;
> -	int i;
> -
> -	/* Find a free RHT entry */
> -	for (i = 0; i < MAX_RHT_PER_CONTEXT; i++)
> -		if (ctxi->rht_start[i].nmask == 0) {
> -			rhte = &ctxi->rht_start[i];
> -			ctxi->rht_out++;
> -			break;
> -		}
> -
> -	if (likely(rhte))
> -		ctxi->rht_lun[i] = lli;
> -
> -	dev_dbg(dev, "%s: returning rhte=%p index=%d\n", __func__, rhte, i);
> -	return rhte;
> -}
> -
> -/**
> - * rhte_checkin() - releases a resource handle table entry
> - * @ctxi:	Context owning the resource handle.
> - * @rhte:	RHTE to release.
> - */
> -void rhte_checkin(struct ctx_info *ctxi,
> -		  struct sisl_rht_entry *rhte)
> -{
> -	u32 rsrc_handle = rhte - ctxi->rht_start;
> -
> -	rhte->nmask = 0;
> -	rhte->fp = 0;
> -	ctxi->rht_out--;
> -	ctxi->rht_lun[rsrc_handle] = NULL;
> -	ctxi->rht_needs_ws[rsrc_handle] = false;
> -}
> -
> -/**
> - * rht_format1() - populates a RHTE for format 1
> - * @rhte:	RHTE to populate.
> - * @lun_id:	LUN ID of LUN associated with RHTE.
> - * @perm:	Desired permissions for RHTE.
> - * @port_sel:	Port selection mask
> - */
> -static void rht_format1(struct sisl_rht_entry *rhte, u64 lun_id, u32 perm,
> -			u32 port_sel)
> -{
> -	/*
> -	 * Populate the Format 1 RHT entry for direct access (physical
> -	 * LUN) using the synchronization sequence defined in the
> -	 * SISLite specification.
> -	 */
> -	struct sisl_rht_entry_f1 dummy = { 0 };
> -	struct sisl_rht_entry_f1 *rhte_f1 = (struct sisl_rht_entry_f1 *)rhte;
> -
> -	memset(rhte_f1, 0, sizeof(*rhte_f1));
> -	rhte_f1->fp = SISL_RHT_FP(1U, 0);
> -	dma_wmb(); /* Make setting of format bit visible */
> -
> -	rhte_f1->lun_id = lun_id;
> -	dma_wmb(); /* Make setting of LUN id visible */
> -
> -	/*
> -	 * Use a dummy RHT Format 1 entry to build the second dword
> -	 * of the entry that must be populated in a single write when
> -	 * enabled (valid bit set to TRUE).
> -	 */
> -	dummy.valid = 0x80;
> -	dummy.fp = SISL_RHT_FP(1U, perm);
> -	dummy.port_sel = port_sel;
> -	rhte_f1->dw = dummy.dw;
> -
> -	dma_wmb(); /* Make remaining RHT entry fields visible */
> -}
> -
> -/**
> - * cxlflash_lun_attach() - attaches a user to a LUN and manages the LUN's mode
> - * @gli:	LUN to attach.
> - * @mode:	Desired mode of the LUN.
> - * @locked:	Mutex status on current thread.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -int cxlflash_lun_attach(struct glun_info *gli, enum lun_mode mode, bool locked)
> -{
> -	int rc = 0;
> -
> -	if (!locked)
> -		mutex_lock(&gli->mutex);
> -
> -	if (gli->mode == MODE_NONE)
> -		gli->mode = mode;
> -	else if (gli->mode != mode) {
> -		pr_debug("%s: gli_mode=%d requested_mode=%d\n",
> -			 __func__, gli->mode, mode);
> -		rc = -EINVAL;
> -		goto out;
> -	}
> -
> -	gli->users++;
> -	WARN_ON(gli->users <= 0);
> -out:
> -	pr_debug("%s: Returning rc=%d gli->mode=%u gli->users=%u\n",
> -		 __func__, rc, gli->mode, gli->users);
> -	if (!locked)
> -		mutex_unlock(&gli->mutex);
> -	return rc;
> -}
> -
> -/**
> - * cxlflash_lun_detach() - detaches a user from a LUN and resets the LUN's mode
> - * @gli:	LUN to detach.
> - *
> - * When resetting the mode, terminate block allocation resources as they
> - * are no longer required (service is safe to call even when block allocation
> - * resources were not present - such as when transitioning from physical mode).
> - * These resources will be reallocated when needed (subsequent transition to
> - * virtual mode).
> - */
> -void cxlflash_lun_detach(struct glun_info *gli)
> -{
> -	mutex_lock(&gli->mutex);
> -	WARN_ON(gli->mode == MODE_NONE);
> -	if (--gli->users == 0) {
> -		gli->mode = MODE_NONE;
> -		cxlflash_ba_terminate(&gli->blka.ba_lun);
> -	}
> -	pr_debug("%s: gli->users=%u\n", __func__, gli->users);
> -	WARN_ON(gli->users < 0);
> -	mutex_unlock(&gli->mutex);
> -}
> -
> -/**
> - * _cxlflash_disk_release() - releases the specified resource entry
> - * @sdev:	SCSI device associated with LUN.
> - * @ctxi:	Context owning resources.
> - * @release:	Release ioctl data structure.
> - *
> - * For LUNs in virtual mode, the virtual LUN associated with the specified
> - * resource handle is resized to 0 prior to releasing the RHTE. Note that the
> - * AFU sync should _not_ be performed when the context is sitting on the error
> - * recovery list. A context on the error recovery list is not known to the AFU
> - * due to reset. When the context is recovered, it will be reattached and made
> - * known again to the AFU.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -int _cxlflash_disk_release(struct scsi_device *sdev,
> -			   struct ctx_info *ctxi,
> -			   struct dk_cxlflash_release *release)
> -{
> -	struct cxlflash_cfg *cfg = shost_priv(sdev->host);
> -	struct device *dev = &cfg->dev->dev;
> -	struct llun_info *lli = sdev->hostdata;
> -	struct glun_info *gli = lli->parent;
> -	struct afu *afu = cfg->afu;
> -	bool put_ctx = false;
> -
> -	struct dk_cxlflash_resize size;
> -	res_hndl_t rhndl = release->rsrc_handle;
> -
> -	int rc = 0;
> -	int rcr = 0;
> -	u64 ctxid = DECODE_CTXID(release->context_id),
> -	    rctxid = release->context_id;
> -
> -	struct sisl_rht_entry *rhte;
> -	struct sisl_rht_entry_f1 *rhte_f1;
> -
> -	dev_dbg(dev, "%s: ctxid=%llu rhndl=%llu gli->mode=%u gli->users=%u\n",
> -		__func__, ctxid, release->rsrc_handle, gli->mode, gli->users);
> -
> -	if (!ctxi) {
> -		ctxi = get_context(cfg, rctxid, lli, CTX_CTRL_ERR_FALLBACK);
> -		if (unlikely(!ctxi)) {
> -			dev_dbg(dev, "%s: Bad context ctxid=%llu\n",
> -				__func__, ctxid);
> -			rc = -EINVAL;
> -			goto out;
> -		}
> -
> -		put_ctx = true;
> -	}
> -
> -	rhte = get_rhte(ctxi, rhndl, lli);
> -	if (unlikely(!rhte)) {
> -		dev_dbg(dev, "%s: Bad resource handle rhndl=%d\n",
> -			__func__, rhndl);
> -		rc = -EINVAL;
> -		goto out;
> -	}
> -
> -	/*
> -	 * Resize to 0 for virtual LUNS by setting the size
> -	 * to 0. This will clear LXT_START and LXT_CNT fields
> -	 * in the RHT entry and properly sync with the AFU.
> -	 *
> -	 * Afterwards we clear the remaining fields.
> -	 */
> -	switch (gli->mode) {
> -	case MODE_VIRTUAL:
> -		marshal_rele_to_resize(release, &size);
> -		size.req_size = 0;
> -		rc = _cxlflash_vlun_resize(sdev, ctxi, &size);
> -		if (rc) {
> -			dev_dbg(dev, "%s: resize failed rc %d\n", __func__, rc);
> -			goto out;
> -		}
> -
> -		break;
> -	case MODE_PHYSICAL:
> -		/*
> -		 * Clear the Format 1 RHT entry for direct access
> -		 * (physical LUN) using the synchronization sequence
> -		 * defined in the SISLite specification.
> -		 */
> -		rhte_f1 = (struct sisl_rht_entry_f1 *)rhte;
> -
> -		rhte_f1->valid = 0;
> -		dma_wmb(); /* Make revocation of RHT entry visible */
> -
> -		rhte_f1->lun_id = 0;
> -		dma_wmb(); /* Make clearing of LUN id visible */
> -
> -		rhte_f1->dw = 0;
> -		dma_wmb(); /* Make RHT entry bottom-half clearing visible */
> -
> -		if (!ctxi->err_recovery_active) {
> -			rcr = cxlflash_afu_sync(afu, ctxid, rhndl, AFU_HW_SYNC);
> -			if (unlikely(rcr))
> -				dev_dbg(dev, "%s: AFU sync failed rc=%d\n",
> -					__func__, rcr);
> -		}
> -		break;
> -	default:
> -		WARN(1, "Unsupported LUN mode!");
> -		goto out;
> -	}
> -
> -	rhte_checkin(ctxi, rhte);
> -	cxlflash_lun_detach(gli);
> -
> -out:
> -	if (put_ctx)
> -		put_context(ctxi);
> -	dev_dbg(dev, "%s: returning rc=%d\n", __func__, rc);
> -	return rc;
> -}
> -
> -int cxlflash_disk_release(struct scsi_device *sdev, void *release)
> -{
> -	return _cxlflash_disk_release(sdev, NULL, release);
> -}
> -
> -/**
> - * destroy_context() - releases a context
> - * @cfg:	Internal structure associated with the host.
> - * @ctxi:	Context to release.
> - *
> - * This routine is safe to be called with a a non-initialized context.
> - * Also note that the routine conditionally checks for the existence
> - * of the context control map before clearing the RHT registers and
> - * context capabilities because it is possible to destroy a context
> - * while the context is in the error state (previous mapping was
> - * removed [so there is no need to worry about clearing] and context
> - * is waiting for a new mapping).
> - */
> -static void destroy_context(struct cxlflash_cfg *cfg,
> -			    struct ctx_info *ctxi)
> -{
> -	struct afu *afu = cfg->afu;
> -
> -	if (ctxi->initialized) {
> -		WARN_ON(!list_empty(&ctxi->luns));
> -
> -		/* Clear RHT registers and drop all capabilities for context */
> -		if (afu->afu_map && ctxi->ctrl_map) {
> -			writeq_be(0, &ctxi->ctrl_map->rht_start);
> -			writeq_be(0, &ctxi->ctrl_map->rht_cnt_id);
> -			writeq_be(0, &ctxi->ctrl_map->ctx_cap);
> -		}
> -	}
> -
> -	/* Free memory associated with context */
> -	free_page((ulong)ctxi->rht_start);
> -	kfree(ctxi->rht_needs_ws);
> -	kfree(ctxi->rht_lun);
> -	kfree(ctxi);
> -}
> -
> -/**
> - * create_context() - allocates and initializes a context
> - * @cfg:	Internal structure associated with the host.
> - *
> - * Return: Allocated context on success, NULL on failure
> - */
> -static struct ctx_info *create_context(struct cxlflash_cfg *cfg)
> -{
> -	struct device *dev = &cfg->dev->dev;
> -	struct ctx_info *ctxi = NULL;
> -	struct llun_info **lli = NULL;
> -	u8 *ws = NULL;
> -	struct sisl_rht_entry *rhte;
> -
> -	ctxi = kzalloc(sizeof(*ctxi), GFP_KERNEL);
> -	lli = kzalloc((MAX_RHT_PER_CONTEXT * sizeof(*lli)), GFP_KERNEL);
> -	ws = kzalloc((MAX_RHT_PER_CONTEXT * sizeof(*ws)), GFP_KERNEL);
> -	if (unlikely(!ctxi || !lli || !ws)) {
> -		dev_err(dev, "%s: Unable to allocate context\n", __func__);
> -		goto err;
> -	}
> -
> -	rhte = (struct sisl_rht_entry *)get_zeroed_page(GFP_KERNEL);
> -	if (unlikely(!rhte)) {
> -		dev_err(dev, "%s: Unable to allocate RHT\n", __func__);
> -		goto err;
> -	}
> -
> -	ctxi->rht_lun = lli;
> -	ctxi->rht_needs_ws = ws;
> -	ctxi->rht_start = rhte;
> -out:
> -	return ctxi;
> -
> -err:
> -	kfree(ws);
> -	kfree(lli);
> -	kfree(ctxi);
> -	ctxi = NULL;
> -	goto out;
> -}
> -
> -/**
> - * init_context() - initializes a previously allocated context
> - * @ctxi:	Previously allocated context
> - * @cfg:	Internal structure associated with the host.
> - * @ctx:	Previously obtained context cookie.
> - * @ctxid:	Previously obtained process element associated with CXL context.
> - * @file:	Previously obtained file associated with CXL context.
> - * @perms:	User-specified permissions.
> - * @irqs:	User-specified number of interrupts.
> - */
> -static void init_context(struct ctx_info *ctxi, struct cxlflash_cfg *cfg,
> -			 void *ctx, int ctxid, struct file *file, u32 perms,
> -			 u64 irqs)
> -{
> -	struct afu *afu = cfg->afu;
> -
> -	ctxi->rht_perms = perms;
> -	ctxi->ctrl_map = &afu->afu_map->ctrls[ctxid].ctrl;
> -	ctxi->ctxid = ENCODE_CTXID(ctxi, ctxid);
> -	ctxi->irqs = irqs;
> -	ctxi->pid = task_tgid_nr(current); /* tgid = pid */
> -	ctxi->ctx = ctx;
> -	ctxi->cfg = cfg;
> -	ctxi->file = file;
> -	ctxi->initialized = true;
> -	mutex_init(&ctxi->mutex);
> -	kref_init(&ctxi->kref);
> -	INIT_LIST_HEAD(&ctxi->luns);
> -	INIT_LIST_HEAD(&ctxi->list); /* initialize for list_empty() */
> -}
> -
> -/**
> - * remove_context() - context kref release handler
> - * @kref:	Kernel reference associated with context to be removed.
> - *
> - * When a context no longer has any references it can safely be removed
> - * from global access and destroyed. Note that it is assumed the thread
> - * relinquishing access to the context holds its mutex.
> - */
> -static void remove_context(struct kref *kref)
> -{
> -	struct ctx_info *ctxi = container_of(kref, struct ctx_info, kref);
> -	struct cxlflash_cfg *cfg = ctxi->cfg;
> -	u64 ctxid = DECODE_CTXID(ctxi->ctxid);
> -
> -	/* Remove context from table/error list */
> -	WARN_ON(!mutex_is_locked(&ctxi->mutex));
> -	ctxi->unavail = true;
> -	mutex_unlock(&ctxi->mutex);
> -	mutex_lock(&cfg->ctx_tbl_list_mutex);
> -	mutex_lock(&ctxi->mutex);
> -
> -	if (!list_empty(&ctxi->list))
> -		list_del(&ctxi->list);
> -	cfg->ctx_tbl[ctxid] = NULL;
> -	mutex_unlock(&cfg->ctx_tbl_list_mutex);
> -	mutex_unlock(&ctxi->mutex);
> -
> -	/* Context now completely uncoupled/unreachable */
> -	destroy_context(cfg, ctxi);
> -}
> -
> -/**
> - * _cxlflash_disk_detach() - detaches a LUN from a context
> - * @sdev:	SCSI device associated with LUN.
> - * @ctxi:	Context owning resources.
> - * @detach:	Detach ioctl data structure.
> - *
> - * As part of the detach, all per-context resources associated with the LUN
> - * are cleaned up. When detaching the last LUN for a context, the context
> - * itself is cleaned up and released.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int _cxlflash_disk_detach(struct scsi_device *sdev,
> -				 struct ctx_info *ctxi,
> -				 struct dk_cxlflash_detach *detach)
> -{
> -	struct cxlflash_cfg *cfg = shost_priv(sdev->host);
> -	struct device *dev = &cfg->dev->dev;
> -	struct llun_info *lli = sdev->hostdata;
> -	struct lun_access *lun_access, *t;
> -	struct dk_cxlflash_release rel;
> -	bool put_ctx = false;
> -
> -	int i;
> -	int rc = 0;
> -	u64 ctxid = DECODE_CTXID(detach->context_id),
> -	    rctxid = detach->context_id;
> -
> -	dev_dbg(dev, "%s: ctxid=%llu\n", __func__, ctxid);
> -
> -	if (!ctxi) {
> -		ctxi = get_context(cfg, rctxid, lli, CTX_CTRL_ERR_FALLBACK);
> -		if (unlikely(!ctxi)) {
> -			dev_dbg(dev, "%s: Bad context ctxid=%llu\n",
> -				__func__, ctxid);
> -			rc = -EINVAL;
> -			goto out;
> -		}
> -
> -		put_ctx = true;
> -	}
> -
> -	/* Cleanup outstanding resources tied to this LUN */
> -	if (ctxi->rht_out) {
> -		marshal_det_to_rele(detach, &rel);
> -		for (i = 0; i < MAX_RHT_PER_CONTEXT; i++) {
> -			if (ctxi->rht_lun[i] == lli) {
> -				rel.rsrc_handle = i;
> -				_cxlflash_disk_release(sdev, ctxi, &rel);
> -			}
> -
> -			/* No need to loop further if we're done */
> -			if (ctxi->rht_out == 0)
> -				break;
> -		}
> -	}
> -
> -	/* Take our LUN out of context, free the node */
> -	list_for_each_entry_safe(lun_access, t, &ctxi->luns, list)
> -		if (lun_access->lli == lli) {
> -			list_del(&lun_access->list);
> -			kfree(lun_access);
> -			lun_access = NULL;
> -			break;
> -		}
> -
> -	/*
> -	 * Release the context reference and the sdev reference that
> -	 * bound this LUN to the context.
> -	 */
> -	if (kref_put(&ctxi->kref, remove_context))
> -		put_ctx = false;
> -	scsi_device_put(sdev);
> -out:
> -	if (put_ctx)
> -		put_context(ctxi);
> -	dev_dbg(dev, "%s: returning rc=%d\n", __func__, rc);
> -	return rc;
> -}
> -
> -static int cxlflash_disk_detach(struct scsi_device *sdev, void *detach)
> -{
> -	return _cxlflash_disk_detach(sdev, NULL, detach);
> -}
> -
> -/**
> - * cxlflash_cxl_release() - release handler for adapter file descriptor
> - * @inode:	File-system inode associated with fd.
> - * @file:	File installed with adapter file descriptor.
> - *
> - * This routine is the release handler for the fops registered with
> - * the CXL services on an initial attach for a context. It is called
> - * when a close (explicitly by the user or as part of a process tear
> - * down) is performed on the adapter file descriptor returned to the
> - * user. The user should be aware that explicitly performing a close
> - * considered catastrophic and subsequent usage of the superpipe API
> - * with previously saved off tokens will fail.
> - *
> - * This routine derives the context reference and calls detach for
> - * each LUN associated with the context.The final detach operation
> - * causes the context itself to be freed. With exception to when the
> - * CXL process element (context id) lookup fails (a case that should
> - * theoretically never occur), every call into this routine results
> - * in a complete freeing of a context.
> - *
> - * Detaching the LUN is typically an ioctl() operation and the underlying
> - * code assumes that ioctl_rwsem has been acquired as a reader. To support
> - * that design point, the semaphore is acquired and released around detach.
> - *
> - * Return: 0 on success
> - */
> -static int cxlflash_cxl_release(struct inode *inode, struct file *file)
> -{
> -	struct cxlflash_cfg *cfg = container_of(file->f_op, struct cxlflash_cfg,
> -						cxl_fops);
> -	void *ctx = cfg->ops->fops_get_context(file);
> -	struct device *dev = &cfg->dev->dev;
> -	struct ctx_info *ctxi = NULL;
> -	struct dk_cxlflash_detach detach = { { 0 }, 0 };
> -	struct lun_access *lun_access, *t;
> -	enum ctx_ctrl ctrl = CTX_CTRL_ERR_FALLBACK | CTX_CTRL_FILE;
> -	int ctxid;
> -
> -	ctxid = cfg->ops->process_element(ctx);
> -	if (unlikely(ctxid < 0)) {
> -		dev_err(dev, "%s: Context %p was closed ctxid=%d\n",
> -			__func__, ctx, ctxid);
> -		goto out;
> -	}
> -
> -	ctxi = get_context(cfg, ctxid, file, ctrl);
> -	if (unlikely(!ctxi)) {
> -		ctxi = get_context(cfg, ctxid, file, ctrl | CTX_CTRL_CLONE);
> -		if (!ctxi) {
> -			dev_dbg(dev, "%s: ctxid=%d already free\n",
> -				__func__, ctxid);
> -			goto out_release;
> -		}
> -
> -		dev_dbg(dev, "%s: Another process owns ctxid=%d\n",
> -			__func__, ctxid);
> -		put_context(ctxi);
> -		goto out;
> -	}
> -
> -	dev_dbg(dev, "%s: close for ctxid=%d\n", __func__, ctxid);
> -
> -	down_read(&cfg->ioctl_rwsem);
> -	detach.context_id = ctxi->ctxid;
> -	list_for_each_entry_safe(lun_access, t, &ctxi->luns, list)
> -		_cxlflash_disk_detach(lun_access->sdev, ctxi, &detach);
> -	up_read(&cfg->ioctl_rwsem);
> -out_release:
> -	cfg->ops->fd_release(inode, file);
> -out:
> -	dev_dbg(dev, "%s: returning\n", __func__);
> -	return 0;
> -}
> -
> -/**
> - * unmap_context() - clears a previously established mapping
> - * @ctxi:	Context owning the mapping.
> - *
> - * This routine is used to switch between the error notification page
> - * (dummy page of all 1's) and the real mapping (established by the CXL
> - * fault handler).
> - */
> -static void unmap_context(struct ctx_info *ctxi)
> -{
> -	unmap_mapping_range(ctxi->file->f_mapping, 0, 0, 1);
> -}
> -
> -/**
> - * get_err_page() - obtains and allocates the error notification page
> - * @cfg:	Internal structure associated with the host.
> - *
> - * Return: error notification page on success, NULL on failure
> - */
> -static struct page *get_err_page(struct cxlflash_cfg *cfg)
> -{
> -	struct page *err_page = global.err_page;
> -	struct device *dev = &cfg->dev->dev;
> -
> -	if (unlikely(!err_page)) {
> -		err_page = alloc_page(GFP_KERNEL);
> -		if (unlikely(!err_page)) {
> -			dev_err(dev, "%s: Unable to allocate err_page\n",
> -				__func__);
> -			goto out;
> -		}
> -
> -		memset(page_address(err_page), -1, PAGE_SIZE);
> -
> -		/* Serialize update w/ other threads to avoid a leak */
> -		mutex_lock(&global.mutex);
> -		if (likely(!global.err_page))
> -			global.err_page = err_page;
> -		else {
> -			__free_page(err_page);
> -			err_page = global.err_page;
> -		}
> -		mutex_unlock(&global.mutex);
> -	}
> -
> -out:
> -	dev_dbg(dev, "%s: returning err_page=%p\n", __func__, err_page);
> -	return err_page;
> -}
> -
> -/**
> - * cxlflash_mmap_fault() - mmap fault handler for adapter file descriptor
> - * @vmf:	VM fault associated with current fault.
> - *
> - * To support error notification via MMIO, faults are 'caught' by this routine
> - * that was inserted before passing back the adapter file descriptor on attach.
> - * When a fault occurs, this routine evaluates if error recovery is active and
> - * if so, installs the error page to 'notify' the user about the error state.
> - * During normal operation, the fault is simply handled by the original fault
> - * handler that was installed by CXL services as part of initializing the
> - * adapter file descriptor. The VMA's page protection bits are toggled to
> - * indicate cached/not-cached depending on the memory backing the fault.
> - *
> - * Return: 0 on success, VM_FAULT_SIGBUS on failure
> - */
> -static vm_fault_t cxlflash_mmap_fault(struct vm_fault *vmf)
> -{
> -	struct vm_area_struct *vma = vmf->vma;
> -	struct file *file = vma->vm_file;
> -	struct cxlflash_cfg *cfg = container_of(file->f_op, struct cxlflash_cfg,
> -						cxl_fops);
> -	void *ctx = cfg->ops->fops_get_context(file);
> -	struct device *dev = &cfg->dev->dev;
> -	struct ctx_info *ctxi = NULL;
> -	struct page *err_page = NULL;
> -	enum ctx_ctrl ctrl = CTX_CTRL_ERR_FALLBACK | CTX_CTRL_FILE;
> -	vm_fault_t rc = 0;
> -	int ctxid;
> -
> -	ctxid = cfg->ops->process_element(ctx);
> -	if (unlikely(ctxid < 0)) {
> -		dev_err(dev, "%s: Context %p was closed ctxid=%d\n",
> -			__func__, ctx, ctxid);
> -		goto err;
> -	}
> -
> -	ctxi = get_context(cfg, ctxid, file, ctrl);
> -	if (unlikely(!ctxi)) {
> -		dev_dbg(dev, "%s: Bad context ctxid=%d\n", __func__, ctxid);
> -		goto err;
> -	}
> -
> -	dev_dbg(dev, "%s: fault for context %d\n", __func__, ctxid);
> -
> -	if (likely(!ctxi->err_recovery_active)) {
> -		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> -		rc = ctxi->cxl_mmap_vmops->fault(vmf);
> -	} else {
> -		dev_dbg(dev, "%s: err recovery active, use err_page\n",
> -			__func__);
> -
> -		err_page = get_err_page(cfg);
> -		if (unlikely(!err_page)) {
> -			dev_err(dev, "%s: Could not get err_page\n", __func__);
> -			rc = VM_FAULT_RETRY;
> -			goto out;
> -		}
> -
> -		get_page(err_page);
> -		vmf->page = err_page;
> -		vma->vm_page_prot = pgprot_cached(vma->vm_page_prot);
> -	}
> -
> -out:
> -	if (likely(ctxi))
> -		put_context(ctxi);
> -	dev_dbg(dev, "%s: returning rc=%x\n", __func__, rc);
> -	return rc;
> -
> -err:
> -	rc = VM_FAULT_SIGBUS;
> -	goto out;
> -}
> -
> -/*
> - * Local MMAP vmops to 'catch' faults
> - */
> -static const struct vm_operations_struct cxlflash_mmap_vmops = {
> -	.fault = cxlflash_mmap_fault,
> -};
> -
> -/**
> - * cxlflash_cxl_mmap() - mmap handler for adapter file descriptor
> - * @file:	File installed with adapter file descriptor.
> - * @vma:	VM area associated with mapping.
> - *
> - * Installs local mmap vmops to 'catch' faults for error notification support.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int cxlflash_cxl_mmap(struct file *file, struct vm_area_struct *vma)
> -{
> -	struct cxlflash_cfg *cfg = container_of(file->f_op, struct cxlflash_cfg,
> -						cxl_fops);
> -	void *ctx = cfg->ops->fops_get_context(file);
> -	struct device *dev = &cfg->dev->dev;
> -	struct ctx_info *ctxi = NULL;
> -	enum ctx_ctrl ctrl = CTX_CTRL_ERR_FALLBACK | CTX_CTRL_FILE;
> -	int ctxid;
> -	int rc = 0;
> -
> -	ctxid = cfg->ops->process_element(ctx);
> -	if (unlikely(ctxid < 0)) {
> -		dev_err(dev, "%s: Context %p was closed ctxid=%d\n",
> -			__func__, ctx, ctxid);
> -		rc = -EIO;
> -		goto out;
> -	}
> -
> -	ctxi = get_context(cfg, ctxid, file, ctrl);
> -	if (unlikely(!ctxi)) {
> -		dev_dbg(dev, "%s: Bad context ctxid=%d\n", __func__, ctxid);
> -		rc = -EIO;
> -		goto out;
> -	}
> -
> -	dev_dbg(dev, "%s: mmap for context %d\n", __func__, ctxid);
> -
> -	rc = cfg->ops->fd_mmap(file, vma);
> -	if (likely(!rc)) {
> -		/* Insert ourself in the mmap fault handler path */
> -		ctxi->cxl_mmap_vmops = vma->vm_ops;
> -		vma->vm_ops = &cxlflash_mmap_vmops;
> -	}
> -
> -out:
> -	if (likely(ctxi))
> -		put_context(ctxi);
> -	return rc;
> -}
> -
> -const struct file_operations cxlflash_cxl_fops = {
> -	.owner = THIS_MODULE,
> -	.mmap = cxlflash_cxl_mmap,
> -	.release = cxlflash_cxl_release,
> -};
> -
> -/**
> - * cxlflash_mark_contexts_error() - move contexts to error state and list
> - * @cfg:	Internal structure associated with the host.
> - *
> - * A context is only moved over to the error list when there are no outstanding
> - * references to it. This ensures that a running operation has completed.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -int cxlflash_mark_contexts_error(struct cxlflash_cfg *cfg)
> -{
> -	int i, rc = 0;
> -	struct ctx_info *ctxi = NULL;
> -
> -	mutex_lock(&cfg->ctx_tbl_list_mutex);
> -
> -	for (i = 0; i < MAX_CONTEXT; i++) {
> -		ctxi = cfg->ctx_tbl[i];
> -		if (ctxi) {
> -			mutex_lock(&ctxi->mutex);
> -			cfg->ctx_tbl[i] = NULL;
> -			list_add(&ctxi->list, &cfg->ctx_err_recovery);
> -			ctxi->err_recovery_active = true;
> -			ctxi->ctrl_map = NULL;
> -			unmap_context(ctxi);
> -			mutex_unlock(&ctxi->mutex);
> -		}
> -	}
> -
> -	mutex_unlock(&cfg->ctx_tbl_list_mutex);
> -	return rc;
> -}
> -
> -/*
> - * Dummy NULL fops
> - */
> -static const struct file_operations null_fops = {
> -	.owner = THIS_MODULE,
> -};
> -
> -/**
> - * check_state() - checks and responds to the current adapter state
> - * @cfg:	Internal structure associated with the host.
> - *
> - * This routine can block and should only be used on process context.
> - * It assumes that the caller is an ioctl thread and holding the ioctl
> - * read semaphore. This is temporarily let up across the wait to allow
> - * for draining actively running ioctls. Also note that when waking up
> - * from waiting in reset, the state is unknown and must be checked again
> - * before proceeding.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -int check_state(struct cxlflash_cfg *cfg)
> -{
> -	struct device *dev = &cfg->dev->dev;
> -	int rc = 0;
> -
> -retry:
> -	switch (cfg->state) {
> -	case STATE_RESET:
> -		dev_dbg(dev, "%s: Reset state, going to wait...\n", __func__);
> -		up_read(&cfg->ioctl_rwsem);
> -		rc = wait_event_interruptible(cfg->reset_waitq,
> -					      cfg->state != STATE_RESET);
> -		down_read(&cfg->ioctl_rwsem);
> -		if (unlikely(rc))
> -			break;
> -		goto retry;
> -	case STATE_FAILTERM:
> -		dev_dbg(dev, "%s: Failed/Terminating\n", __func__);
> -		rc = -ENODEV;
> -		break;
> -	default:
> -		break;
> -	}
> -
> -	return rc;
> -}
> -
> -/**
> - * cxlflash_disk_attach() - attach a LUN to a context
> - * @sdev:	SCSI device associated with LUN.
> - * @arg:	Attach ioctl data structure.
> - *
> - * Creates a context and attaches LUN to it. A LUN can only be attached
> - * one time to a context (subsequent attaches for the same context/LUN pair
> - * are not supported). Additional LUNs can be attached to a context by
> - * specifying the 'reuse' flag defined in the cxlflash_ioctl.h header.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int cxlflash_disk_attach(struct scsi_device *sdev, void *arg)
> -{
> -	struct dk_cxlflash_attach *attach = arg;
> -	struct cxlflash_cfg *cfg = shost_priv(sdev->host);
> -	struct device *dev = &cfg->dev->dev;
> -	struct afu *afu = cfg->afu;
> -	struct llun_info *lli = sdev->hostdata;
> -	struct glun_info *gli = lli->parent;
> -	struct ctx_info *ctxi = NULL;
> -	struct lun_access *lun_access = NULL;
> -	int rc = 0;
> -	u32 perms;
> -	int ctxid = -1;
> -	u64 irqs = attach->num_interrupts;
> -	u64 flags = 0UL;
> -	u64 rctxid = 0UL;
> -	struct file *file = NULL;
> -
> -	void *ctx = NULL;
> -
> -	int fd = -1;
> -
> -	if (irqs > 4) {
> -		dev_dbg(dev, "%s: Cannot support this many interrupts %llu\n",
> -			__func__, irqs);
> -		rc = -EINVAL;
> -		goto out;
> -	}
> -
> -	if (gli->max_lba == 0) {
> -		dev_dbg(dev, "%s: No capacity info for LUN=%016llx\n",
> -			__func__, lli->lun_id[sdev->channel]);
> -		rc = read_cap16(sdev, lli);
> -		if (rc) {
> -			dev_err(dev, "%s: Invalid device rc=%d\n",
> -				__func__, rc);
> -			rc = -ENODEV;
> -			goto out;
> -		}
> -		dev_dbg(dev, "%s: LBA = %016llx\n", __func__, gli->max_lba);
> -		dev_dbg(dev, "%s: BLK_LEN = %08x\n", __func__, gli->blk_len);
> -	}
> -
> -	if (attach->hdr.flags & DK_CXLFLASH_ATTACH_REUSE_CONTEXT) {
> -		rctxid = attach->context_id;
> -		ctxi = get_context(cfg, rctxid, NULL, 0);
> -		if (!ctxi) {
> -			dev_dbg(dev, "%s: Bad context rctxid=%016llx\n",
> -				__func__, rctxid);
> -			rc = -EINVAL;
> -			goto out;
> -		}
> -
> -		list_for_each_entry(lun_access, &ctxi->luns, list)
> -			if (lun_access->lli == lli) {
> -				dev_dbg(dev, "%s: Already attached\n",
> -					__func__);
> -				rc = -EINVAL;
> -				goto out;
> -			}
> -	}
> -
> -	rc = scsi_device_get(sdev);
> -	if (unlikely(rc)) {
> -		dev_err(dev, "%s: Unable to get sdev reference\n", __func__);
> -		goto out;
> -	}
> -
> -	lun_access = kzalloc(sizeof(*lun_access), GFP_KERNEL);
> -	if (unlikely(!lun_access)) {
> -		dev_err(dev, "%s: Unable to allocate lun_access\n", __func__);
> -		rc = -ENOMEM;
> -		goto err;
> -	}
> -
> -	lun_access->lli = lli;
> -	lun_access->sdev = sdev;
> -
> -	/* Non-NULL context indicates reuse (another context reference) */
> -	if (ctxi) {
> -		dev_dbg(dev, "%s: Reusing context for LUN rctxid=%016llx\n",
> -			__func__, rctxid);
> -		kref_get(&ctxi->kref);
> -		list_add(&lun_access->list, &ctxi->luns);
> -		goto out_attach;
> -	}
> -
> -	ctxi = create_context(cfg);
> -	if (unlikely(!ctxi)) {
> -		dev_err(dev, "%s: Failed to create context ctxid=%d\n",
> -			__func__, ctxid);
> -		rc = -ENOMEM;
> -		goto err;
> -	}
> -
> -	ctx = cfg->ops->dev_context_init(cfg->dev, cfg->afu_cookie);
> -	if (IS_ERR_OR_NULL(ctx)) {
> -		dev_err(dev, "%s: Could not initialize context %p\n",
> -			__func__, ctx);
> -		rc = -ENODEV;
> -		goto err;
> -	}
> -
> -	rc = cfg->ops->start_work(ctx, irqs);
> -	if (unlikely(rc)) {
> -		dev_dbg(dev, "%s: Could not start context rc=%d\n",
> -			__func__, rc);
> -		goto err;
> -	}
> -
> -	ctxid = cfg->ops->process_element(ctx);
> -	if (unlikely((ctxid >= MAX_CONTEXT) || (ctxid < 0))) {
> -		dev_err(dev, "%s: ctxid=%d invalid\n", __func__, ctxid);
> -		rc = -EPERM;
> -		goto err;
> -	}
> -
> -	file = cfg->ops->get_fd(ctx, &cfg->cxl_fops, &fd);
> -	if (unlikely(fd < 0)) {
> -		rc = -ENODEV;
> -		dev_err(dev, "%s: Could not get file descriptor\n", __func__);
> -		goto err;
> -	}
> -
> -	/* Translate read/write O_* flags from fcntl.h to AFU permission bits */
> -	perms = SISL_RHT_PERM(attach->hdr.flags + 1);
> -
> -	/* Context mutex is locked upon return */
> -	init_context(ctxi, cfg, ctx, ctxid, file, perms, irqs);
> -
> -	rc = afu_attach(cfg, ctxi);
> -	if (unlikely(rc)) {
> -		dev_err(dev, "%s: Could not attach AFU rc %d\n", __func__, rc);
> -		goto err;
> -	}
> -
> -	/*
> -	 * No error paths after this point. Once the fd is installed it's
> -	 * visible to user space and can't be undone safely on this thread.
> -	 * There is no need to worry about a deadlock here because no one
> -	 * knows about us yet; we can be the only one holding our mutex.
> -	 */
> -	list_add(&lun_access->list, &ctxi->luns);
> -	mutex_lock(&cfg->ctx_tbl_list_mutex);
> -	mutex_lock(&ctxi->mutex);
> -	cfg->ctx_tbl[ctxid] = ctxi;
> -	mutex_unlock(&cfg->ctx_tbl_list_mutex);
> -	fd_install(fd, file);
> -
> -out_attach:
> -	if (fd != -1)
> -		flags |= DK_CXLFLASH_APP_CLOSE_ADAP_FD;
> -	if (afu_is_sq_cmd_mode(afu))
> -		flags |= DK_CXLFLASH_CONTEXT_SQ_CMD_MODE;
> -
> -	attach->hdr.return_flags = flags;
> -	attach->context_id = ctxi->ctxid;
> -	attach->block_size = gli->blk_len;
> -	attach->mmio_size = sizeof(afu->afu_map->hosts[0].harea);
> -	attach->last_lba = gli->max_lba;
> -	attach->max_xfer = sdev->host->max_sectors * MAX_SECTOR_UNIT;
> -	attach->max_xfer /= gli->blk_len;
> -
> -out:
> -	attach->adap_fd = fd;
> -
> -	if (ctxi)
> -		put_context(ctxi);
> -
> -	dev_dbg(dev, "%s: returning ctxid=%d fd=%d bs=%lld rc=%d llba=%lld\n",
> -		__func__, ctxid, fd, attach->block_size, rc, attach->last_lba);
> -	return rc;
> -
> -err:
> -	/* Cleanup CXL context; okay to 'stop' even if it was not started */
> -	if (!IS_ERR_OR_NULL(ctx)) {
> -		cfg->ops->stop_context(ctx);
> -		cfg->ops->release_context(ctx);
> -		ctx = NULL;
> -	}
> -
> -	/*
> -	 * Here, we're overriding the fops with a dummy all-NULL fops because
> -	 * fput() calls the release fop, which will cause us to mistakenly
> -	 * call into the CXL code. Rather than try to add yet more complexity
> -	 * to that routine (cxlflash_cxl_release) we should try to fix the
> -	 * issue here.
> -	 */
> -	if (fd > 0) {
> -		file->f_op = &null_fops;
> -		fput(file);
> -		put_unused_fd(fd);
> -		fd = -1;
> -		file = NULL;
> -	}
> -
> -	/* Cleanup our context */
> -	if (ctxi) {
> -		destroy_context(cfg, ctxi);
> -		ctxi = NULL;
> -	}
> -
> -	kfree(lun_access);
> -	scsi_device_put(sdev);
> -	goto out;
> -}
> -
> -/**
> - * recover_context() - recovers a context in error
> - * @cfg:	Internal structure associated with the host.
> - * @ctxi:	Context to release.
> - * @adap_fd:	Adapter file descriptor associated with new/recovered context.
> - *
> - * Restablishes the state for a context-in-error.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int recover_context(struct cxlflash_cfg *cfg,
> -			   struct ctx_info *ctxi,
> -			   int *adap_fd)
> -{
> -	struct device *dev = &cfg->dev->dev;
> -	int rc = 0;
> -	int fd = -1;
> -	int ctxid = -1;
> -	struct file *file;
> -	void *ctx;
> -	struct afu *afu = cfg->afu;
> -
> -	ctx = cfg->ops->dev_context_init(cfg->dev, cfg->afu_cookie);
> -	if (IS_ERR_OR_NULL(ctx)) {
> -		dev_err(dev, "%s: Could not initialize context %p\n",
> -			__func__, ctx);
> -		rc = -ENODEV;
> -		goto out;
> -	}
> -
> -	rc = cfg->ops->start_work(ctx, ctxi->irqs);
> -	if (unlikely(rc)) {
> -		dev_dbg(dev, "%s: Could not start context rc=%d\n",
> -			__func__, rc);
> -		goto err1;
> -	}
> -
> -	ctxid = cfg->ops->process_element(ctx);
> -	if (unlikely((ctxid >= MAX_CONTEXT) || (ctxid < 0))) {
> -		dev_err(dev, "%s: ctxid=%d invalid\n", __func__, ctxid);
> -		rc = -EPERM;
> -		goto err2;
> -	}
> -
> -	file = cfg->ops->get_fd(ctx, &cfg->cxl_fops, &fd);
> -	if (unlikely(fd < 0)) {
> -		rc = -ENODEV;
> -		dev_err(dev, "%s: Could not get file descriptor\n", __func__);
> -		goto err2;
> -	}
> -
> -	/* Update with new MMIO area based on updated context id */
> -	ctxi->ctrl_map = &afu->afu_map->ctrls[ctxid].ctrl;
> -
> -	rc = afu_attach(cfg, ctxi);
> -	if (rc) {
> -		dev_err(dev, "%s: Could not attach AFU rc %d\n", __func__, rc);
> -		goto err3;
> -	}
> -
> -	/*
> -	 * No error paths after this point. Once the fd is installed it's
> -	 * visible to user space and can't be undone safely on this thread.
> -	 */
> -	ctxi->ctxid = ENCODE_CTXID(ctxi, ctxid);
> -	ctxi->ctx = ctx;
> -	ctxi->file = file;
> -
> -	/*
> -	 * Put context back in table (note the reinit of the context list);
> -	 * we must first drop the context's mutex and then acquire it in
> -	 * order with the table/list mutex to avoid a deadlock - safe to do
> -	 * here because no one can find us at this moment in time.
> -	 */
> -	mutex_unlock(&ctxi->mutex);
> -	mutex_lock(&cfg->ctx_tbl_list_mutex);
> -	mutex_lock(&ctxi->mutex);
> -	list_del_init(&ctxi->list);
> -	cfg->ctx_tbl[ctxid] = ctxi;
> -	mutex_unlock(&cfg->ctx_tbl_list_mutex);
> -	fd_install(fd, file);
> -	*adap_fd = fd;
> -out:
> -	dev_dbg(dev, "%s: returning ctxid=%d fd=%d rc=%d\n",
> -		__func__, ctxid, fd, rc);
> -	return rc;
> -
> -err3:
> -	fput(file);
> -	put_unused_fd(fd);
> -err2:
> -	cfg->ops->stop_context(ctx);
> -err1:
> -	cfg->ops->release_context(ctx);
> -	goto out;
> -}
> -
> -/**
> - * cxlflash_afu_recover() - initiates AFU recovery
> - * @sdev:	SCSI device associated with LUN.
> - * @arg:	Recover ioctl data structure.
> - *
> - * Only a single recovery is allowed at a time to avoid exhausting CXL
> - * resources (leading to recovery failure) in the event that we're up
> - * against the maximum number of contexts limit. For similar reasons,
> - * a context recovery is retried if there are multiple recoveries taking
> - * place at the same time and the failure was due to CXL services being
> - * unable to keep up.
> - *
> - * As this routine is called on ioctl context, it holds the ioctl r/w
> - * semaphore that is used to drain ioctls in recovery scenarios. The
> - * implementation to achieve the pacing described above (a local mutex)
> - * requires that the ioctl r/w semaphore be dropped and reacquired to
> - * avoid a 3-way deadlock when multiple process recoveries operate in
> - * parallel.
> - *
> - * Because a user can detect an error condition before the kernel, it is
> - * quite possible for this routine to act as the kernel's EEH detection
> - * source (MMIO read of mbox_r). Because of this, there is a window of
> - * time where an EEH might have been detected but not yet 'serviced'
> - * (callback invoked, causing the device to enter reset state). To avoid
> - * looping in this routine during that window, a 1 second sleep is in place
> - * between the time the MMIO failure is detected and the time a wait on the
> - * reset wait queue is attempted via check_state().
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int cxlflash_afu_recover(struct scsi_device *sdev, void *arg)
> -{
> -	struct dk_cxlflash_recover_afu *recover = arg;
> -	struct cxlflash_cfg *cfg = shost_priv(sdev->host);
> -	struct device *dev = &cfg->dev->dev;
> -	struct llun_info *lli = sdev->hostdata;
> -	struct afu *afu = cfg->afu;
> -	struct ctx_info *ctxi = NULL;
> -	struct mutex *mutex = &cfg->ctx_recovery_mutex;
> -	struct hwq *hwq = get_hwq(afu, PRIMARY_HWQ);
> -	u64 flags;
> -	u64 ctxid = DECODE_CTXID(recover->context_id),
> -	    rctxid = recover->context_id;
> -	long reg;
> -	bool locked = true;
> -	int lretry = 20; /* up to 2 seconds */
> -	int new_adap_fd = -1;
> -	int rc = 0;
> -
> -	atomic_inc(&cfg->recovery_threads);
> -	up_read(&cfg->ioctl_rwsem);
> -	rc = mutex_lock_interruptible(mutex);
> -	down_read(&cfg->ioctl_rwsem);
> -	if (rc) {
> -		locked = false;
> -		goto out;
> -	}
> -
> -	rc = check_state(cfg);
> -	if (rc) {
> -		dev_err(dev, "%s: Failed state rc=%d\n", __func__, rc);
> -		rc = -ENODEV;
> -		goto out;
> -	}
> -
> -	dev_dbg(dev, "%s: reason=%016llx rctxid=%016llx\n",
> -		__func__, recover->reason, rctxid);
> -
> -retry:
> -	/* Ensure that this process is attached to the context */
> -	ctxi = get_context(cfg, rctxid, lli, CTX_CTRL_ERR_FALLBACK);
> -	if (unlikely(!ctxi)) {
> -		dev_dbg(dev, "%s: Bad context ctxid=%llu\n", __func__, ctxid);
> -		rc = -EINVAL;
> -		goto out;
> -	}
> -
> -	if (ctxi->err_recovery_active) {
> -retry_recover:
> -		rc = recover_context(cfg, ctxi, &new_adap_fd);
> -		if (unlikely(rc)) {
> -			dev_err(dev, "%s: Recovery failed ctxid=%llu rc=%d\n",
> -				__func__, ctxid, rc);
> -			if ((rc == -ENODEV) &&
> -			    ((atomic_read(&cfg->recovery_threads) > 1) ||
> -			     (lretry--))) {
> -				dev_dbg(dev, "%s: Going to try again\n",
> -					__func__);
> -				mutex_unlock(mutex);
> -				msleep(100);
> -				rc = mutex_lock_interruptible(mutex);
> -				if (rc) {
> -					locked = false;
> -					goto out;
> -				}
> -				goto retry_recover;
> -			}
> -
> -			goto out;
> -		}
> -
> -		ctxi->err_recovery_active = false;
> -
> -		flags = DK_CXLFLASH_APP_CLOSE_ADAP_FD |
> -			DK_CXLFLASH_RECOVER_AFU_CONTEXT_RESET;
> -		if (afu_is_sq_cmd_mode(afu))
> -			flags |= DK_CXLFLASH_CONTEXT_SQ_CMD_MODE;
> -
> -		recover->hdr.return_flags = flags;
> -		recover->context_id = ctxi->ctxid;
> -		recover->adap_fd = new_adap_fd;
> -		recover->mmio_size = sizeof(afu->afu_map->hosts[0].harea);
> -		goto out;
> -	}
> -
> -	/* Test if in error state */
> -	reg = readq_be(&hwq->ctrl_map->mbox_r);
> -	if (reg == -1) {
> -		dev_dbg(dev, "%s: MMIO fail, wait for recovery.\n", __func__);
> -
> -		/*
> -		 * Before checking the state, put back the context obtained with
> -		 * get_context() as it is no longer needed and sleep for a short
> -		 * period of time (see prolog notes).
> -		 */
> -		put_context(ctxi);
> -		ctxi = NULL;
> -		ssleep(1);
> -		rc = check_state(cfg);
> -		if (unlikely(rc))
> -			goto out;
> -		goto retry;
> -	}
> -
> -	dev_dbg(dev, "%s: MMIO working, no recovery required\n", __func__);
> -out:
> -	if (likely(ctxi))
> -		put_context(ctxi);
> -	if (locked)
> -		mutex_unlock(mutex);
> -	atomic_dec_if_positive(&cfg->recovery_threads);
> -	return rc;
> -}
> -
> -/**
> - * process_sense() - evaluates and processes sense data
> - * @sdev:	SCSI device associated with LUN.
> - * @verify:	Verify ioctl data structure.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int process_sense(struct scsi_device *sdev,
> -			 struct dk_cxlflash_verify *verify)
> -{
> -	struct cxlflash_cfg *cfg = shost_priv(sdev->host);
> -	struct device *dev = &cfg->dev->dev;
> -	struct llun_info *lli = sdev->hostdata;
> -	struct glun_info *gli = lli->parent;
> -	u64 prev_lba = gli->max_lba;
> -	struct scsi_sense_hdr sshdr = { 0 };
> -	int rc = 0;
> -
> -	rc = scsi_normalize_sense((const u8 *)&verify->sense_data,
> -				  DK_CXLFLASH_VERIFY_SENSE_LEN, &sshdr);
> -	if (!rc) {
> -		dev_err(dev, "%s: Failed to normalize sense data\n", __func__);
> -		rc = -EINVAL;
> -		goto out;
> -	}
> -
> -	switch (sshdr.sense_key) {
> -	case NO_SENSE:
> -	case RECOVERED_ERROR:
> -	case NOT_READY:
> -		break;
> -	case UNIT_ATTENTION:
> -		switch (sshdr.asc) {
> -		case 0x29: /* Power on Reset or Device Reset */
> -			fallthrough;
> -		case 0x2A: /* Device settings/capacity changed */
> -			rc = read_cap16(sdev, lli);
> -			if (rc) {
> -				rc = -ENODEV;
> -				break;
> -			}
> -			if (prev_lba != gli->max_lba)
> -				dev_dbg(dev, "%s: Capacity changed old=%lld "
> -					"new=%lld\n", __func__, prev_lba,
> -					gli->max_lba);
> -			break;
> -		case 0x3F: /* Report LUNs changed, Rescan. */
> -			scsi_scan_host(cfg->host);
> -			break;
> -		default:
> -			rc = -EIO;
> -			break;
> -		}
> -		break;
> -	default:
> -		rc = -EIO;
> -		break;
> -	}
> -out:
> -	dev_dbg(dev, "%s: sense_key %x asc %x ascq %x rc %d\n", __func__,
> -		sshdr.sense_key, sshdr.asc, sshdr.ascq, rc);
> -	return rc;
> -}
> -
> -/**
> - * cxlflash_disk_verify() - verifies a LUN is the same and handle size changes
> - * @sdev:	SCSI device associated with LUN.
> - * @arg:	Verify ioctl data structure.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int cxlflash_disk_verify(struct scsi_device *sdev, void *arg)
> -{
> -	struct dk_cxlflash_verify *verify = arg;
> -	int rc = 0;
> -	struct ctx_info *ctxi = NULL;
> -	struct cxlflash_cfg *cfg = shost_priv(sdev->host);
> -	struct device *dev = &cfg->dev->dev;
> -	struct llun_info *lli = sdev->hostdata;
> -	struct glun_info *gli = lli->parent;
> -	struct sisl_rht_entry *rhte = NULL;
> -	res_hndl_t rhndl = verify->rsrc_handle;
> -	u64 ctxid = DECODE_CTXID(verify->context_id),
> -	    rctxid = verify->context_id;
> -	u64 last_lba = 0;
> -
> -	dev_dbg(dev, "%s: ctxid=%llu rhndl=%016llx, hint=%016llx, "
> -		"flags=%016llx\n", __func__, ctxid, verify->rsrc_handle,
> -		verify->hint, verify->hdr.flags);
> -
> -	ctxi = get_context(cfg, rctxid, lli, 0);
> -	if (unlikely(!ctxi)) {
> -		dev_dbg(dev, "%s: Bad context ctxid=%llu\n", __func__, ctxid);
> -		rc = -EINVAL;
> -		goto out;
> -	}
> -
> -	rhte = get_rhte(ctxi, rhndl, lli);
> -	if (unlikely(!rhte)) {
> -		dev_dbg(dev, "%s: Bad resource handle rhndl=%d\n",
> -			__func__, rhndl);
> -		rc = -EINVAL;
> -		goto out;
> -	}
> -
> -	/*
> -	 * Look at the hint/sense to see if it requires us to redrive
> -	 * inquiry (i.e. the Unit attention is due to the WWN changing).
> -	 */
> -	if (verify->hint & DK_CXLFLASH_VERIFY_HINT_SENSE) {
> -		/* Can't hold mutex across process_sense/read_cap16,
> -		 * since we could have an intervening EEH event.
> -		 */
> -		ctxi->unavail = true;
> -		mutex_unlock(&ctxi->mutex);
> -		rc = process_sense(sdev, verify);
> -		if (unlikely(rc)) {
> -			dev_err(dev, "%s: Failed to validate sense data (%d)\n",
> -				__func__, rc);
> -			mutex_lock(&ctxi->mutex);
> -			ctxi->unavail = false;
> -			goto out;
> -		}
> -		mutex_lock(&ctxi->mutex);
> -		ctxi->unavail = false;
> -	}
> -
> -	switch (gli->mode) {
> -	case MODE_PHYSICAL:
> -		last_lba = gli->max_lba;
> -		break;
> -	case MODE_VIRTUAL:
> -		/* Cast lxt_cnt to u64 for multiply to be treated as 64bit op */
> -		last_lba = ((u64)rhte->lxt_cnt * MC_CHUNK_SIZE * gli->blk_len);
> -		last_lba /= CXLFLASH_BLOCK_SIZE;
> -		last_lba--;
> -		break;
> -	default:
> -		WARN(1, "Unsupported LUN mode!");
> -	}
> -
> -	verify->last_lba = last_lba;
> -
> -out:
> -	if (likely(ctxi))
> -		put_context(ctxi);
> -	dev_dbg(dev, "%s: returning rc=%d llba=%llx\n",
> -		__func__, rc, verify->last_lba);
> -	return rc;
> -}
> -
> -/**
> - * decode_ioctl() - translates an encoded ioctl to an easily identifiable string
> - * @cmd:	The ioctl command to decode.
> - *
> - * Return: A string identifying the decoded ioctl.
> - */
> -static char *decode_ioctl(unsigned int cmd)
> -{
> -	switch (cmd) {
> -	case DK_CXLFLASH_ATTACH:
> -		return __stringify_1(DK_CXLFLASH_ATTACH);
> -	case DK_CXLFLASH_USER_DIRECT:
> -		return __stringify_1(DK_CXLFLASH_USER_DIRECT);
> -	case DK_CXLFLASH_USER_VIRTUAL:
> -		return __stringify_1(DK_CXLFLASH_USER_VIRTUAL);
> -	case DK_CXLFLASH_VLUN_RESIZE:
> -		return __stringify_1(DK_CXLFLASH_VLUN_RESIZE);
> -	case DK_CXLFLASH_RELEASE:
> -		return __stringify_1(DK_CXLFLASH_RELEASE);
> -	case DK_CXLFLASH_DETACH:
> -		return __stringify_1(DK_CXLFLASH_DETACH);
> -	case DK_CXLFLASH_VERIFY:
> -		return __stringify_1(DK_CXLFLASH_VERIFY);
> -	case DK_CXLFLASH_VLUN_CLONE:
> -		return __stringify_1(DK_CXLFLASH_VLUN_CLONE);
> -	case DK_CXLFLASH_RECOVER_AFU:
> -		return __stringify_1(DK_CXLFLASH_RECOVER_AFU);
> -	case DK_CXLFLASH_MANAGE_LUN:
> -		return __stringify_1(DK_CXLFLASH_MANAGE_LUN);
> -	}
> -
> -	return "UNKNOWN";
> -}
> -
> -/**
> - * cxlflash_disk_direct_open() - opens a direct (physical) disk
> - * @sdev:	SCSI device associated with LUN.
> - * @arg:	UDirect ioctl data structure.
> - *
> - * On successful return, the user is informed of the resource handle
> - * to be used to identify the direct lun and the size (in blocks) of
> - * the direct lun in last LBA format.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int cxlflash_disk_direct_open(struct scsi_device *sdev, void *arg)
> -{
> -	struct cxlflash_cfg *cfg = shost_priv(sdev->host);
> -	struct device *dev = &cfg->dev->dev;
> -	struct afu *afu = cfg->afu;
> -	struct llun_info *lli = sdev->hostdata;
> -	struct glun_info *gli = lli->parent;
> -	struct dk_cxlflash_release rel = { { 0 }, 0 };
> -
> -	struct dk_cxlflash_udirect *pphys = (struct dk_cxlflash_udirect *)arg;
> -
> -	u64 ctxid = DECODE_CTXID(pphys->context_id),
> -	    rctxid = pphys->context_id;
> -	u64 lun_size = 0;
> -	u64 last_lba = 0;
> -	u64 rsrc_handle = -1;
> -	u32 port = CHAN2PORTMASK(sdev->channel);
> -
> -	int rc = 0;
> -
> -	struct ctx_info *ctxi = NULL;
> -	struct sisl_rht_entry *rhte = NULL;
> -
> -	dev_dbg(dev, "%s: ctxid=%llu ls=%llu\n", __func__, ctxid, lun_size);
> -
> -	rc = cxlflash_lun_attach(gli, MODE_PHYSICAL, false);
> -	if (unlikely(rc)) {
> -		dev_dbg(dev, "%s: Failed attach to LUN (PHYSICAL)\n", __func__);
> -		goto out;
> -	}
> -
> -	ctxi = get_context(cfg, rctxid, lli, 0);
> -	if (unlikely(!ctxi)) {
> -		dev_dbg(dev, "%s: Bad context ctxid=%llu\n", __func__, ctxid);
> -		rc = -EINVAL;
> -		goto err1;
> -	}
> -
> -	rhte = rhte_checkout(ctxi, lli);
> -	if (unlikely(!rhte)) {
> -		dev_dbg(dev, "%s: Too many opens ctxid=%lld\n",
> -			__func__, ctxid);
> -		rc = -EMFILE;	/* too many opens  */
> -		goto err1;
> -	}
> -
> -	rsrc_handle = (rhte - ctxi->rht_start);
> -
> -	rht_format1(rhte, lli->lun_id[sdev->channel], ctxi->rht_perms, port);
> -
> -	last_lba = gli->max_lba;
> -	pphys->hdr.return_flags = 0;
> -	pphys->last_lba = last_lba;
> -	pphys->rsrc_handle = rsrc_handle;
> -
> -	rc = cxlflash_afu_sync(afu, ctxid, rsrc_handle, AFU_LW_SYNC);
> -	if (unlikely(rc)) {
> -		dev_dbg(dev, "%s: AFU sync failed rc=%d\n", __func__, rc);
> -		goto err2;
> -	}
> -
> -out:
> -	if (likely(ctxi))
> -		put_context(ctxi);
> -	dev_dbg(dev, "%s: returning handle=%llu rc=%d llba=%llu\n",
> -		__func__, rsrc_handle, rc, last_lba);
> -	return rc;
> -
> -err2:
> -	marshal_udir_to_rele(pphys, &rel);
> -	_cxlflash_disk_release(sdev, ctxi, &rel);
> -	goto out;
> -err1:
> -	cxlflash_lun_detach(gli);
> -	goto out;
> -}
> -
> -/**
> - * ioctl_common() - common IOCTL handler for driver
> - * @sdev:	SCSI device associated with LUN.
> - * @cmd:	IOCTL command.
> - *
> - * Handles common fencing operations that are valid for multiple ioctls. Always
> - * allow through ioctls that are cleanup oriented in nature, even when operating
> - * in a failed/terminating state.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int ioctl_common(struct scsi_device *sdev, unsigned int cmd)
> -{
> -	struct cxlflash_cfg *cfg = shost_priv(sdev->host);
> -	struct device *dev = &cfg->dev->dev;
> -	struct llun_info *lli = sdev->hostdata;
> -	int rc = 0;
> -
> -	if (unlikely(!lli)) {
> -		dev_dbg(dev, "%s: Unknown LUN\n", __func__);
> -		rc = -EINVAL;
> -		goto out;
> -	}
> -
> -	rc = check_state(cfg);
> -	if (unlikely(rc) && (cfg->state == STATE_FAILTERM)) {
> -		switch (cmd) {
> -		case DK_CXLFLASH_VLUN_RESIZE:
> -		case DK_CXLFLASH_RELEASE:
> -		case DK_CXLFLASH_DETACH:
> -			dev_dbg(dev, "%s: Command override rc=%d\n",
> -				__func__, rc);
> -			rc = 0;
> -			break;
> -		}
> -	}
> -out:
> -	return rc;
> -}
> -
> -/**
> - * cxlflash_ioctl() - IOCTL handler for driver
> - * @sdev:	SCSI device associated with LUN.
> - * @cmd:	IOCTL command.
> - * @arg:	Userspace ioctl data structure.
> - *
> - * A read/write semaphore is used to implement a 'drain' of currently
> - * running ioctls. The read semaphore is taken at the beginning of each
> - * ioctl thread and released upon concluding execution. Additionally the
> - * semaphore should be released and then reacquired in any ioctl execution
> - * path which will wait for an event to occur that is outside the scope of
> - * the ioctl (i.e. an adapter reset). To drain the ioctls currently running,
> - * a thread simply needs to acquire the write semaphore.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -int cxlflash_ioctl(struct scsi_device *sdev, unsigned int cmd, void __user *arg)
> -{
> -	typedef int (*sioctl) (struct scsi_device *, void *);
> -
> -	struct cxlflash_cfg *cfg = shost_priv(sdev->host);
> -	struct device *dev = &cfg->dev->dev;
> -	struct afu *afu = cfg->afu;
> -	struct dk_cxlflash_hdr *hdr;
> -	char buf[sizeof(union cxlflash_ioctls)];
> -	size_t size = 0;
> -	bool known_ioctl = false;
> -	int idx;
> -	int rc = 0;
> -	struct Scsi_Host *shost = sdev->host;
> -	sioctl do_ioctl = NULL;
> -
> -	static const struct {
> -		size_t size;
> -		sioctl ioctl;
> -	} ioctl_tbl[] = {	/* NOTE: order matters here */
> -	{sizeof(struct dk_cxlflash_attach), cxlflash_disk_attach},
> -	{sizeof(struct dk_cxlflash_udirect), cxlflash_disk_direct_open},
> -	{sizeof(struct dk_cxlflash_release), cxlflash_disk_release},
> -	{sizeof(struct dk_cxlflash_detach), cxlflash_disk_detach},
> -	{sizeof(struct dk_cxlflash_verify), cxlflash_disk_verify},
> -	{sizeof(struct dk_cxlflash_recover_afu), cxlflash_afu_recover},
> -	{sizeof(struct dk_cxlflash_manage_lun), cxlflash_manage_lun},
> -	{sizeof(struct dk_cxlflash_uvirtual), cxlflash_disk_virtual_open},
> -	{sizeof(struct dk_cxlflash_resize), cxlflash_vlun_resize},
> -	{sizeof(struct dk_cxlflash_clone), cxlflash_disk_clone},
> -	};
> -
> -	/* Hold read semaphore so we can drain if needed */
> -	down_read(&cfg->ioctl_rwsem);
> -
> -	/* Restrict command set to physical support only for internal LUN */
> -	if (afu->internal_lun)
> -		switch (cmd) {
> -		case DK_CXLFLASH_RELEASE:
> -		case DK_CXLFLASH_USER_VIRTUAL:
> -		case DK_CXLFLASH_VLUN_RESIZE:
> -		case DK_CXLFLASH_VLUN_CLONE:
> -			dev_dbg(dev, "%s: %s not supported for lun_mode=%d\n",
> -				__func__, decode_ioctl(cmd), afu->internal_lun);
> -			rc = -EINVAL;
> -			goto cxlflash_ioctl_exit;
> -		}
> -
> -	switch (cmd) {
> -	case DK_CXLFLASH_ATTACH:
> -	case DK_CXLFLASH_USER_DIRECT:
> -	case DK_CXLFLASH_RELEASE:
> -	case DK_CXLFLASH_DETACH:
> -	case DK_CXLFLASH_VERIFY:
> -	case DK_CXLFLASH_RECOVER_AFU:
> -	case DK_CXLFLASH_USER_VIRTUAL:
> -	case DK_CXLFLASH_VLUN_RESIZE:
> -	case DK_CXLFLASH_VLUN_CLONE:
> -		dev_dbg(dev, "%s: %s (%08X) on dev(%d/%d/%d/%llu)\n",
> -			__func__, decode_ioctl(cmd), cmd, shost->host_no,
> -			sdev->channel, sdev->id, sdev->lun);
> -		rc = ioctl_common(sdev, cmd);
> -		if (unlikely(rc))
> -			goto cxlflash_ioctl_exit;
> -
> -		fallthrough;
> -
> -	case DK_CXLFLASH_MANAGE_LUN:
> -		known_ioctl = true;
> -		idx = _IOC_NR(cmd) - _IOC_NR(DK_CXLFLASH_ATTACH);
> -		size = ioctl_tbl[idx].size;
> -		do_ioctl = ioctl_tbl[idx].ioctl;
> -
> -		if (likely(do_ioctl))
> -			break;
> -
> -		fallthrough;
> -	default:
> -		rc = -EINVAL;
> -		goto cxlflash_ioctl_exit;
> -	}
> -
> -	if (unlikely(copy_from_user(&buf, arg, size))) {
> -		dev_err(dev, "%s: copy_from_user() fail size=%lu cmd=%u (%s) arg=%p\n",
> -			__func__, size, cmd, decode_ioctl(cmd), arg);
> -		rc = -EFAULT;
> -		goto cxlflash_ioctl_exit;
> -	}
> -
> -	hdr = (struct dk_cxlflash_hdr *)&buf;
> -	if (hdr->version != DK_CXLFLASH_VERSION_0) {
> -		dev_dbg(dev, "%s: Version %u not supported for %s\n",
> -			__func__, hdr->version, decode_ioctl(cmd));
> -		rc = -EINVAL;
> -		goto cxlflash_ioctl_exit;
> -	}
> -
> -	if (hdr->rsvd[0] || hdr->rsvd[1] || hdr->rsvd[2] || hdr->return_flags) {
> -		dev_dbg(dev, "%s: Reserved/rflags populated\n", __func__);
> -		rc = -EINVAL;
> -		goto cxlflash_ioctl_exit;
> -	}
> -
> -	rc = do_ioctl(sdev, (void *)&buf);
> -	if (likely(!rc))
> -		if (unlikely(copy_to_user(arg, &buf, size))) {
> -			dev_err(dev, "%s: copy_to_user() fail size=%lu cmd=%u (%s) arg=%p\n",
> -				__func__, size, cmd, decode_ioctl(cmd), arg);
> -			rc = -EFAULT;
> -		}
> -
> -	/* fall through to exit */
> -
> -cxlflash_ioctl_exit:
> -	up_read(&cfg->ioctl_rwsem);
> -	if (unlikely(rc && known_ioctl))
> -		dev_err(dev, "%s: ioctl %s (%08X) on dev(%d/%d/%d/%llu) "
> -			"returned rc %d\n", __func__,
> -			decode_ioctl(cmd), cmd, shost->host_no,
> -			sdev->channel, sdev->id, sdev->lun, rc);
> -	else
> -		dev_dbg(dev, "%s: ioctl %s (%08X) on dev(%d/%d/%d/%llu) "
> -			"returned rc %d\n", __func__, decode_ioctl(cmd),
> -			cmd, shost->host_no, sdev->channel, sdev->id,
> -			sdev->lun, rc);
> -	return rc;
> -}
> diff --git a/drivers/scsi/cxlflash/superpipe.h b/drivers/scsi/cxlflash/superpipe.h
> deleted file mode 100644
> index fe8c975d13d7..000000000000
> --- a/drivers/scsi/cxlflash/superpipe.h
> +++ /dev/null
> @@ -1,150 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * CXL Flash Device Driver
> - *
> - * Written by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>, IBM Corporation
> - *             Matthew R. Ochs <mrochs@linux.vnet.ibm.com>, IBM Corporation
> - *
> - * Copyright (C) 2015 IBM Corporation
> - */
> -
> -#ifndef _CXLFLASH_SUPERPIPE_H
> -#define _CXLFLASH_SUPERPIPE_H
> -
> -extern struct cxlflash_global global;
> -
> -/*
> - * Terminology: use afu (and not adapter) to refer to the HW.
> - * Adapter is the entire slot and includes PSL out of which
> - * only the AFU is visible to user space.
> - */
> -
> -/* Chunk size parms: note sislite minimum chunk size is
> - * 0x10000 LBAs corresponding to a NMASK or 16.
> - */
> -#define MC_CHUNK_SIZE     (1 << MC_RHT_NMASK)	/* in LBAs */
> -
> -#define CMD_TIMEOUT 30  /* 30 secs */
> -#define CMD_RETRIES 5   /* 5 retries for scsi_execute */
> -
> -#define MAX_SECTOR_UNIT  512 /* max_sector is in 512 byte multiples */
> -
> -enum lun_mode {
> -	MODE_NONE = 0,
> -	MODE_VIRTUAL,
> -	MODE_PHYSICAL
> -};
> -
> -/* Global (entire driver, spans adapters) lun_info structure */
> -struct glun_info {
> -	u64 max_lba;		/* from read cap(16) */
> -	u32 blk_len;		/* from read cap(16) */
> -	enum lun_mode mode;	/* NONE, VIRTUAL, PHYSICAL */
> -	int users;		/* Number of users w/ references to LUN */
> -
> -	u8 wwid[16];
> -
> -	struct mutex mutex;
> -
> -	struct blka blka;
> -	struct list_head list;
> -};
> -
> -/* Local (per-adapter) lun_info structure */
> -struct llun_info {
> -	u64 lun_id[MAX_FC_PORTS]; /* from REPORT_LUNS */
> -	u32 lun_index;		/* Index in the LUN table */
> -	u32 host_no;		/* host_no from Scsi_host */
> -	u32 port_sel;		/* What port to use for this LUN */
> -	bool in_table;		/* Whether a LUN table entry was created */
> -
> -	u8 wwid[16];		/* Keep a duplicate copy here? */
> -
> -	struct glun_info *parent; /* Pointer to entry in global LUN structure */
> -	struct scsi_device *sdev;
> -	struct list_head list;
> -};
> -
> -struct lun_access {
> -	struct llun_info *lli;
> -	struct scsi_device *sdev;
> -	struct list_head list;
> -};
> -
> -enum ctx_ctrl {
> -	CTX_CTRL_CLONE		= (1 << 1),
> -	CTX_CTRL_ERR		= (1 << 2),
> -	CTX_CTRL_ERR_FALLBACK	= (1 << 3),
> -	CTX_CTRL_NOPID		= (1 << 4),
> -	CTX_CTRL_FILE		= (1 << 5)
> -};
> -
> -#define ENCODE_CTXID(_ctx, _id)	(((((u64)_ctx) & 0xFFFFFFFF0ULL) << 28) | _id)
> -#define DECODE_CTXID(_val)	(_val & 0xFFFFFFFF)
> -
> -struct ctx_info {
> -	struct sisl_ctrl_map __iomem *ctrl_map; /* initialized at startup */
> -	struct sisl_rht_entry *rht_start; /* 1 page (req'd for alignment),
> -					   * alloc/free on attach/detach
> -					   */
> -	u32 rht_out;		/* Number of checked out RHT entries */
> -	u32 rht_perms;		/* User-defined permissions for RHT entries */
> -	struct llun_info **rht_lun;       /* Mapping of RHT entries to LUNs */
> -	u8 *rht_needs_ws;	/* User-desired write-same function per RHTE */
> -
> -	u64 ctxid;
> -	u64 irqs; /* Number of interrupts requested for context */
> -	pid_t pid;
> -	bool initialized;
> -	bool unavail;
> -	bool err_recovery_active;
> -	struct mutex mutex; /* Context protection */
> -	struct kref kref;
> -	void *ctx;
> -	struct cxlflash_cfg *cfg;
> -	struct list_head luns;	/* LUNs attached to this context */
> -	const struct vm_operations_struct *cxl_mmap_vmops;
> -	struct file *file;
> -	struct list_head list; /* Link contexts in error recovery */
> -};
> -
> -struct cxlflash_global {
> -	struct mutex mutex;
> -	struct list_head gluns;/* list of glun_info structs */
> -	struct page *err_page; /* One page of all 0xF for error notification */
> -};
> -
> -int cxlflash_vlun_resize(struct scsi_device *sdev, void *resize);
> -int _cxlflash_vlun_resize(struct scsi_device *sdev, struct ctx_info *ctxi,
> -			  struct dk_cxlflash_resize *resize);
> -
> -int cxlflash_disk_release(struct scsi_device *sdev,
> -			  void *release);
> -int _cxlflash_disk_release(struct scsi_device *sdev, struct ctx_info *ctxi,
> -			   struct dk_cxlflash_release *release);
> -
> -int cxlflash_disk_clone(struct scsi_device *sdev, void *arg);
> -
> -int cxlflash_disk_virtual_open(struct scsi_device *sdev, void *arg);
> -
> -int cxlflash_lun_attach(struct glun_info *gli, enum lun_mode mode, bool locked);
> -void cxlflash_lun_detach(struct glun_info *gli);
> -
> -struct ctx_info *get_context(struct cxlflash_cfg *cfg, u64 rctxit, void *arg,
> -			     enum ctx_ctrl ctrl);
> -void put_context(struct ctx_info *ctxi);
> -
> -struct sisl_rht_entry *get_rhte(struct ctx_info *ctxi, res_hndl_t rhndl,
> -				struct llun_info *lli);
> -
> -struct sisl_rht_entry *rhte_checkout(struct ctx_info *ctxi,
> -				     struct llun_info *lli);
> -void rhte_checkin(struct ctx_info *ctxi, struct sisl_rht_entry *rhte);
> -
> -void cxlflash_ba_terminate(struct ba_lun *ba_lun);
> -
> -int cxlflash_manage_lun(struct scsi_device *sdev, void *manage);
> -
> -int check_state(struct cxlflash_cfg *cfg);
> -
> -#endif /* ifndef _CXLFLASH_SUPERPIPE_H */
> diff --git a/drivers/scsi/cxlflash/vlun.c b/drivers/scsi/cxlflash/vlun.c
> deleted file mode 100644
> index 32e807703377..000000000000
> --- a/drivers/scsi/cxlflash/vlun.c
> +++ /dev/null
> @@ -1,1336 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * CXL Flash Device Driver
> - *
> - * Written by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>, IBM Corporation
> - *             Matthew R. Ochs <mrochs@linux.vnet.ibm.com>, IBM Corporation
> - *
> - * Copyright (C) 2015 IBM Corporation
> - */
> -
> -#include <linux/interrupt.h>
> -#include <linux/pci.h>
> -#include <linux/syscalls.h>
> -#include <linux/unaligned.h>
> -#include <asm/bitsperlong.h>
> -
> -#include <scsi/scsi_cmnd.h>
> -#include <scsi/scsi_host.h>
> -#include <uapi/scsi/cxlflash_ioctl.h>
> -
> -#include "sislite.h"
> -#include "common.h"
> -#include "vlun.h"
> -#include "superpipe.h"
> -
> -/**
> - * marshal_virt_to_resize() - translate uvirtual to resize structure
> - * @virt:	Source structure from which to translate/copy.
> - * @resize:	Destination structure for the translate/copy.
> - */
> -static void marshal_virt_to_resize(struct dk_cxlflash_uvirtual *virt,
> -				   struct dk_cxlflash_resize *resize)
> -{
> -	resize->hdr = virt->hdr;
> -	resize->context_id = virt->context_id;
> -	resize->rsrc_handle = virt->rsrc_handle;
> -	resize->req_size = virt->lun_size;
> -	resize->last_lba = virt->last_lba;
> -}
> -
> -/**
> - * marshal_clone_to_rele() - translate clone to release structure
> - * @clone:	Source structure from which to translate/copy.
> - * @release:	Destination structure for the translate/copy.
> - */
> -static void marshal_clone_to_rele(struct dk_cxlflash_clone *clone,
> -				  struct dk_cxlflash_release *release)
> -{
> -	release->hdr = clone->hdr;
> -	release->context_id = clone->context_id_dst;
> -}
> -
> -/**
> - * ba_init() - initializes a block allocator
> - * @ba_lun:	Block allocator to initialize.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int ba_init(struct ba_lun *ba_lun)
> -{
> -	struct ba_lun_info *bali = NULL;
> -	int lun_size_au = 0, i = 0;
> -	int last_word_underflow = 0;
> -	u64 *lam;
> -
> -	pr_debug("%s: Initializing LUN: lun_id=%016llx "
> -		 "ba_lun->lsize=%lx ba_lun->au_size=%lX\n",
> -		__func__, ba_lun->lun_id, ba_lun->lsize, ba_lun->au_size);
> -
> -	/* Calculate bit map size */
> -	lun_size_au = ba_lun->lsize / ba_lun->au_size;
> -	if (lun_size_au == 0) {
> -		pr_debug("%s: Requested LUN size of 0!\n", __func__);
> -		return -EINVAL;
> -	}
> -
> -	/* Allocate lun information container */
> -	bali = kzalloc(sizeof(struct ba_lun_info), GFP_KERNEL);
> -	if (unlikely(!bali)) {
> -		pr_err("%s: Failed to allocate lun_info lun_id=%016llx\n",
> -		       __func__, ba_lun->lun_id);
> -		return -ENOMEM;
> -	}
> -
> -	bali->total_aus = lun_size_au;
> -	bali->lun_bmap_size = lun_size_au / BITS_PER_LONG;
> -
> -	if (lun_size_au % BITS_PER_LONG)
> -		bali->lun_bmap_size++;
> -
> -	/* Allocate bitmap space */
> -	bali->lun_alloc_map = kzalloc((bali->lun_bmap_size * sizeof(u64)),
> -				      GFP_KERNEL);
> -	if (unlikely(!bali->lun_alloc_map)) {
> -		pr_err("%s: Failed to allocate lun allocation map: "
> -		       "lun_id=%016llx\n", __func__, ba_lun->lun_id);
> -		kfree(bali);
> -		return -ENOMEM;
> -	}
> -
> -	/* Initialize the bit map size and set all bits to '1' */
> -	bali->free_aun_cnt = lun_size_au;
> -
> -	for (i = 0; i < bali->lun_bmap_size; i++)
> -		bali->lun_alloc_map[i] = 0xFFFFFFFFFFFFFFFFULL;
> -
> -	/* If the last word not fully utilized, mark extra bits as allocated */
> -	last_word_underflow = (bali->lun_bmap_size * BITS_PER_LONG);
> -	last_word_underflow -= bali->free_aun_cnt;
> -	if (last_word_underflow > 0) {
> -		lam = &bali->lun_alloc_map[bali->lun_bmap_size - 1];
> -		for (i = (HIBIT - last_word_underflow + 1);
> -		     i < BITS_PER_LONG;
> -		     i++)
> -			clear_bit(i, (ulong *)lam);
> -	}
> -
> -	/* Initialize high elevator index, low/curr already at 0 from kzalloc */
> -	bali->free_high_idx = bali->lun_bmap_size;
> -
> -	/* Allocate clone map */
> -	bali->aun_clone_map = kzalloc((bali->total_aus * sizeof(u8)),
> -				      GFP_KERNEL);
> -	if (unlikely(!bali->aun_clone_map)) {
> -		pr_err("%s: Failed to allocate clone map: lun_id=%016llx\n",
> -		       __func__, ba_lun->lun_id);
> -		kfree(bali->lun_alloc_map);
> -		kfree(bali);
> -		return -ENOMEM;
> -	}
> -
> -	/* Pass the allocated LUN info as a handle to the user */
> -	ba_lun->ba_lun_handle = bali;
> -
> -	pr_debug("%s: Successfully initialized the LUN: "
> -		 "lun_id=%016llx bitmap size=%x, free_aun_cnt=%llx\n",
> -		__func__, ba_lun->lun_id, bali->lun_bmap_size,
> -		bali->free_aun_cnt);
> -	return 0;
> -}
> -
> -/**
> - * find_free_range() - locates a free bit within the block allocator
> - * @low:	First word in block allocator to start search.
> - * @high:	Last word in block allocator to search.
> - * @bali:	LUN information structure owning the block allocator to search.
> - * @bit_word:	Passes back the word in the block allocator owning the free bit.
> - *
> - * Return: The bit position within the passed back word, -1 on failure
> - */
> -static int find_free_range(u32 low,
> -			   u32 high,
> -			   struct ba_lun_info *bali, int *bit_word)
> -{
> -	int i;
> -	u64 bit_pos = -1;
> -	ulong *lam, num_bits;
> -
> -	for (i = low; i < high; i++)
> -		if (bali->lun_alloc_map[i] != 0) {
> -			lam = (ulong *)&bali->lun_alloc_map[i];
> -			num_bits = (sizeof(*lam) * BITS_PER_BYTE);
> -			bit_pos = find_first_bit(lam, num_bits);
> -
> -			pr_devel("%s: Found free bit %llu in LUN "
> -				 "map entry %016llx at bitmap index = %d\n",
> -				 __func__, bit_pos, bali->lun_alloc_map[i], i);
> -
> -			*bit_word = i;
> -			bali->free_aun_cnt--;
> -			clear_bit(bit_pos, lam);
> -			break;
> -		}
> -
> -	return bit_pos;
> -}
> -
> -/**
> - * ba_alloc() - allocates a block from the block allocator
> - * @ba_lun:	Block allocator from which to allocate a block.
> - *
> - * Return: The allocated block, -1 on failure
> - */
> -static u64 ba_alloc(struct ba_lun *ba_lun)
> -{
> -	u64 bit_pos = -1;
> -	int bit_word = 0;
> -	struct ba_lun_info *bali = NULL;
> -
> -	bali = ba_lun->ba_lun_handle;
> -
> -	pr_debug("%s: Received block allocation request: "
> -		 "lun_id=%016llx free_aun_cnt=%llx\n",
> -		 __func__, ba_lun->lun_id, bali->free_aun_cnt);
> -
> -	if (bali->free_aun_cnt == 0) {
> -		pr_debug("%s: No space left on LUN: lun_id=%016llx\n",
> -			 __func__, ba_lun->lun_id);
> -		return -1ULL;
> -	}
> -
> -	/* Search to find a free entry, curr->high then low->curr */
> -	bit_pos = find_free_range(bali->free_curr_idx,
> -				  bali->free_high_idx, bali, &bit_word);
> -	if (bit_pos == -1) {
> -		bit_pos = find_free_range(bali->free_low_idx,
> -					  bali->free_curr_idx,
> -					  bali, &bit_word);
> -		if (bit_pos == -1) {
> -			pr_debug("%s: Could not find an allocation unit on LUN:"
> -				 " lun_id=%016llx\n", __func__, ba_lun->lun_id);
> -			return -1ULL;
> -		}
> -	}
> -
> -	/* Update the free_curr_idx */
> -	if (bit_pos == HIBIT)
> -		bali->free_curr_idx = bit_word + 1;
> -	else
> -		bali->free_curr_idx = bit_word;
> -
> -	pr_debug("%s: Allocating AU number=%llx lun_id=%016llx "
> -		 "free_aun_cnt=%llx\n", __func__,
> -		 ((bit_word * BITS_PER_LONG) + bit_pos), ba_lun->lun_id,
> -		 bali->free_aun_cnt);
> -
> -	return (u64) ((bit_word * BITS_PER_LONG) + bit_pos);
> -}
> -
> -/**
> - * validate_alloc() - validates the specified block has been allocated
> - * @bali:		LUN info owning the block allocator.
> - * @aun:		Block to validate.
> - *
> - * Return: 0 on success, -1 on failure
> - */
> -static int validate_alloc(struct ba_lun_info *bali, u64 aun)
> -{
> -	int idx = 0, bit_pos = 0;
> -
> -	idx = aun / BITS_PER_LONG;
> -	bit_pos = aun % BITS_PER_LONG;
> -
> -	if (test_bit(bit_pos, (ulong *)&bali->lun_alloc_map[idx]))
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/**
> - * ba_free() - frees a block from the block allocator
> - * @ba_lun:	Block allocator from which to allocate a block.
> - * @to_free:	Block to free.
> - *
> - * Return: 0 on success, -1 on failure
> - */
> -static int ba_free(struct ba_lun *ba_lun, u64 to_free)
> -{
> -	int idx = 0, bit_pos = 0;
> -	struct ba_lun_info *bali = NULL;
> -
> -	bali = ba_lun->ba_lun_handle;
> -
> -	if (validate_alloc(bali, to_free)) {
> -		pr_debug("%s: AUN %llx is not allocated on lun_id=%016llx\n",
> -			 __func__, to_free, ba_lun->lun_id);
> -		return -1;
> -	}
> -
> -	pr_debug("%s: Received a request to free AU=%llx lun_id=%016llx "
> -		 "free_aun_cnt=%llx\n", __func__, to_free, ba_lun->lun_id,
> -		 bali->free_aun_cnt);
> -
> -	if (bali->aun_clone_map[to_free] > 0) {
> -		pr_debug("%s: AUN %llx lun_id=%016llx cloned. Clone count=%x\n",
> -			 __func__, to_free, ba_lun->lun_id,
> -			 bali->aun_clone_map[to_free]);
> -		bali->aun_clone_map[to_free]--;
> -		return 0;
> -	}
> -
> -	idx = to_free / BITS_PER_LONG;
> -	bit_pos = to_free % BITS_PER_LONG;
> -
> -	set_bit(bit_pos, (ulong *)&bali->lun_alloc_map[idx]);
> -	bali->free_aun_cnt++;
> -
> -	if (idx < bali->free_low_idx)
> -		bali->free_low_idx = idx;
> -	else if (idx > bali->free_high_idx)
> -		bali->free_high_idx = idx;
> -
> -	pr_debug("%s: Successfully freed AU bit_pos=%x bit map index=%x "
> -		 "lun_id=%016llx free_aun_cnt=%llx\n", __func__, bit_pos, idx,
> -		 ba_lun->lun_id, bali->free_aun_cnt);
> -
> -	return 0;
> -}
> -
> -/**
> - * ba_clone() - Clone a chunk of the block allocation table
> - * @ba_lun:	Block allocator from which to allocate a block.
> - * @to_clone:	Block to clone.
> - *
> - * Return: 0 on success, -1 on failure
> - */
> -static int ba_clone(struct ba_lun *ba_lun, u64 to_clone)
> -{
> -	struct ba_lun_info *bali = ba_lun->ba_lun_handle;
> -
> -	if (validate_alloc(bali, to_clone)) {
> -		pr_debug("%s: AUN=%llx not allocated on lun_id=%016llx\n",
> -			 __func__, to_clone, ba_lun->lun_id);
> -		return -1;
> -	}
> -
> -	pr_debug("%s: Received a request to clone AUN %llx on lun_id=%016llx\n",
> -		 __func__, to_clone, ba_lun->lun_id);
> -
> -	if (bali->aun_clone_map[to_clone] == MAX_AUN_CLONE_CNT) {
> -		pr_debug("%s: AUN %llx on lun_id=%016llx hit max clones already\n",
> -			 __func__, to_clone, ba_lun->lun_id);
> -		return -1;
> -	}
> -
> -	bali->aun_clone_map[to_clone]++;
> -
> -	return 0;
> -}
> -
> -/**
> - * ba_space() - returns the amount of free space left in the block allocator
> - * @ba_lun:	Block allocator.
> - *
> - * Return: Amount of free space in block allocator
> - */
> -static u64 ba_space(struct ba_lun *ba_lun)
> -{
> -	struct ba_lun_info *bali = ba_lun->ba_lun_handle;
> -
> -	return bali->free_aun_cnt;
> -}
> -
> -/**
> - * cxlflash_ba_terminate() - frees resources associated with the block allocator
> - * @ba_lun:	Block allocator.
> - *
> - * Safe to call in a partially allocated state.
> - */
> -void cxlflash_ba_terminate(struct ba_lun *ba_lun)
> -{
> -	struct ba_lun_info *bali = ba_lun->ba_lun_handle;
> -
> -	if (bali) {
> -		kfree(bali->aun_clone_map);
> -		kfree(bali->lun_alloc_map);
> -		kfree(bali);
> -		ba_lun->ba_lun_handle = NULL;
> -	}
> -}
> -
> -/**
> - * init_vlun() - initializes a LUN for virtual use
> - * @lli:	LUN information structure that owns the block allocator.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int init_vlun(struct llun_info *lli)
> -{
> -	int rc = 0;
> -	struct glun_info *gli = lli->parent;
> -	struct blka *blka = &gli->blka;
> -
> -	memset(blka, 0, sizeof(*blka));
> -	mutex_init(&blka->mutex);
> -
> -	/* LUN IDs are unique per port, save the index instead */
> -	blka->ba_lun.lun_id = lli->lun_index;
> -	blka->ba_lun.lsize = gli->max_lba + 1;
> -	blka->ba_lun.lba_size = gli->blk_len;
> -
> -	blka->ba_lun.au_size = MC_CHUNK_SIZE;
> -	blka->nchunk = blka->ba_lun.lsize / MC_CHUNK_SIZE;
> -
> -	rc = ba_init(&blka->ba_lun);
> -	if (unlikely(rc))
> -		pr_debug("%s: cannot init block_alloc, rc=%d\n", __func__, rc);
> -
> -	pr_debug("%s: returning rc=%d lli=%p\n", __func__, rc, lli);
> -	return rc;
> -}
> -
> -/**
> - * write_same16() - sends a SCSI WRITE_SAME16 (0) command to specified LUN
> - * @sdev:	SCSI device associated with LUN.
> - * @lba:	Logical block address to start write same.
> - * @nblks:	Number of logical blocks to write same.
> - *
> - * The SCSI WRITE_SAME16 can take quite a while to complete. Should an EEH occur
> - * while in scsi_execute_cmd(), the EEH handler will attempt to recover. As
> - * part of the recovery, the handler drains all currently running ioctls,
> - * waiting until they have completed before proceeding with a reset. As this
> - * routine is used on the ioctl path, this can create a condition where the
> - * EEH handler becomes stuck, infinitely waiting for this ioctl thread. To
> - * avoid this behavior, temporarily unmark this thread as an ioctl thread by
> - * releasing the ioctl read semaphore. This will allow the EEH handler to
> - * proceed with a recovery while this thread is still running. Once the
> - * scsi_execute_cmd() returns, reacquire the ioctl read semaphore and check the
> - * adapter state in case it changed while inside of scsi_execute_cmd(). The
> - * state check will wait if the adapter is still being recovered or return a
> - * failure if the recovery failed. In the event that the adapter reset failed,
> - * simply return the failure as the ioctl would be unable to continue.
> - *
> - * Note that the above puts a requirement on this routine to only be called on
> - * an ioctl thread.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int write_same16(struct scsi_device *sdev,
> -			u64 lba,
> -			u32 nblks)
> -{
> -	u8 *cmd_buf = NULL;
> -	u8 *scsi_cmd = NULL;
> -	int rc = 0;
> -	int result = 0;
> -	u64 offset = lba;
> -	int left = nblks;
> -	struct cxlflash_cfg *cfg = shost_priv(sdev->host);
> -	struct device *dev = &cfg->dev->dev;
> -	const u32 s = ilog2(sdev->sector_size) - 9;
> -	const u32 to = sdev->request_queue->rq_timeout;
> -	const u32 ws_limit =
> -		sdev->request_queue->limits.max_write_zeroes_sectors >> s;
> -
> -	cmd_buf = kzalloc(CMD_BUFSIZE, GFP_KERNEL);
> -	scsi_cmd = kzalloc(MAX_COMMAND_SIZE, GFP_KERNEL);
> -	if (unlikely(!cmd_buf || !scsi_cmd)) {
> -		rc = -ENOMEM;
> -		goto out;
> -	}
> -
> -	while (left > 0) {
> -
> -		scsi_cmd[0] = WRITE_SAME_16;
> -		scsi_cmd[1] = cfg->ws_unmap ? 0x8 : 0;
> -		put_unaligned_be64(offset, &scsi_cmd[2]);
> -		put_unaligned_be32(ws_limit < left ? ws_limit : left,
> -				   &scsi_cmd[10]);
> -
> -		/* Drop the ioctl read semaphore across lengthy call */
> -		up_read(&cfg->ioctl_rwsem);
> -		result = scsi_execute_cmd(sdev, scsi_cmd, REQ_OP_DRV_OUT,
> -					  cmd_buf, CMD_BUFSIZE, to,
> -					  CMD_RETRIES, NULL);
> -		down_read(&cfg->ioctl_rwsem);
> -		rc = check_state(cfg);
> -		if (rc) {
> -			dev_err(dev, "%s: Failed state result=%08x\n",
> -				__func__, result);
> -			rc = -ENODEV;
> -			goto out;
> -		}
> -
> -		if (result) {
> -			dev_err_ratelimited(dev, "%s: command failed for "
> -					    "offset=%lld result=%08x\n",
> -					    __func__, offset, result);
> -			rc = -EIO;
> -			goto out;
> -		}
> -		left -= ws_limit;
> -		offset += ws_limit;
> -	}
> -
> -out:
> -	kfree(cmd_buf);
> -	kfree(scsi_cmd);
> -	dev_dbg(dev, "%s: returning rc=%d\n", __func__, rc);
> -	return rc;
> -}
> -
> -/**
> - * grow_lxt() - expands the translation table associated with the specified RHTE
> - * @afu:	AFU associated with the host.
> - * @sdev:	SCSI device associated with LUN.
> - * @ctxid:	Context ID of context owning the RHTE.
> - * @rhndl:	Resource handle associated with the RHTE.
> - * @rhte:	Resource handle entry (RHTE).
> - * @new_size:	Number of translation entries associated with RHTE.
> - *
> - * By design, this routine employs a 'best attempt' allocation and will
> - * truncate the requested size down if there is not sufficient space in
> - * the block allocator to satisfy the request but there does exist some
> - * amount of space. The user is made aware of this by returning the size
> - * allocated.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int grow_lxt(struct afu *afu,
> -		    struct scsi_device *sdev,
> -		    ctx_hndl_t ctxid,
> -		    res_hndl_t rhndl,
> -		    struct sisl_rht_entry *rhte,
> -		    u64 *new_size)
> -{
> -	struct cxlflash_cfg *cfg = shost_priv(sdev->host);
> -	struct device *dev = &cfg->dev->dev;
> -	struct sisl_lxt_entry *lxt = NULL, *lxt_old = NULL;
> -	struct llun_info *lli = sdev->hostdata;
> -	struct glun_info *gli = lli->parent;
> -	struct blka *blka = &gli->blka;
> -	u32 av_size;
> -	u32 ngrps, ngrps_old;
> -	u64 aun;		/* chunk# allocated by block allocator */
> -	u64 delta = *new_size - rhte->lxt_cnt;
> -	u64 my_new_size;
> -	int i, rc = 0;
> -
> -	/*
> -	 * Check what is available in the block allocator before re-allocating
> -	 * LXT array. This is done up front under the mutex which must not be
> -	 * released until after allocation is complete.
> -	 */
> -	mutex_lock(&blka->mutex);
> -	av_size = ba_space(&blka->ba_lun);
> -	if (unlikely(av_size <= 0)) {
> -		dev_dbg(dev, "%s: ba_space error av_size=%d\n",
> -			__func__, av_size);
> -		mutex_unlock(&blka->mutex);
> -		rc = -ENOSPC;
> -		goto out;
> -	}
> -
> -	if (av_size < delta)
> -		delta = av_size;
> -
> -	lxt_old = rhte->lxt_start;
> -	ngrps_old = LXT_NUM_GROUPS(rhte->lxt_cnt);
> -	ngrps = LXT_NUM_GROUPS(rhte->lxt_cnt + delta);
> -
> -	if (ngrps != ngrps_old) {
> -		/* reallocate to fit new size */
> -		lxt = kzalloc((sizeof(*lxt) * LXT_GROUP_SIZE * ngrps),
> -			      GFP_KERNEL);
> -		if (unlikely(!lxt)) {
> -			mutex_unlock(&blka->mutex);
> -			rc = -ENOMEM;
> -			goto out;
> -		}
> -
> -		/* copy over all old entries */
> -		memcpy(lxt, lxt_old, (sizeof(*lxt) * rhte->lxt_cnt));
> -	} else
> -		lxt = lxt_old;
> -
> -	/* nothing can fail from now on */
> -	my_new_size = rhte->lxt_cnt + delta;
> -
> -	/* add new entries to the end */
> -	for (i = rhte->lxt_cnt; i < my_new_size; i++) {
> -		/*
> -		 * Due to the earlier check of available space, ba_alloc
> -		 * cannot fail here. If it did due to internal error,
> -		 * leave a rlba_base of -1u which will likely be a
> -		 * invalid LUN (too large).
> -		 */
> -		aun = ba_alloc(&blka->ba_lun);
> -		if ((aun == -1ULL) || (aun >= blka->nchunk))
> -			dev_dbg(dev, "%s: ba_alloc error allocated chunk=%llu "
> -				"max=%llu\n", __func__, aun, blka->nchunk - 1);
> -
> -		/* select both ports, use r/w perms from RHT */
> -		lxt[i].rlba_base = ((aun << MC_CHUNK_SHIFT) |
> -				    (lli->lun_index << LXT_LUNIDX_SHIFT) |
> -				    (RHT_PERM_RW << LXT_PERM_SHIFT |
> -				     lli->port_sel));
> -	}
> -
> -	mutex_unlock(&blka->mutex);
> -
> -	/*
> -	 * The following sequence is prescribed in the SISlite spec
> -	 * for syncing up with the AFU when adding LXT entries.
> -	 */
> -	dma_wmb(); /* Make LXT updates are visible */
> -
> -	rhte->lxt_start = lxt;
> -	dma_wmb(); /* Make RHT entry's LXT table update visible */
> -
> -	rhte->lxt_cnt = my_new_size;
> -	dma_wmb(); /* Make RHT entry's LXT table size update visible */
> -
> -	rc = cxlflash_afu_sync(afu, ctxid, rhndl, AFU_LW_SYNC);
> -	if (unlikely(rc))
> -		rc = -EAGAIN;
> -
> -	/* free old lxt if reallocated */
> -	if (lxt != lxt_old)
> -		kfree(lxt_old);
> -	*new_size = my_new_size;
> -out:
> -	dev_dbg(dev, "%s: returning rc=%d\n", __func__, rc);
> -	return rc;
> -}
> -
> -/**
> - * shrink_lxt() - reduces translation table associated with the specified RHTE
> - * @afu:	AFU associated with the host.
> - * @sdev:	SCSI device associated with LUN.
> - * @rhndl:	Resource handle associated with the RHTE.
> - * @rhte:	Resource handle entry (RHTE).
> - * @ctxi:	Context owning resources.
> - * @new_size:	Number of translation entries associated with RHTE.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int shrink_lxt(struct afu *afu,
> -		      struct scsi_device *sdev,
> -		      res_hndl_t rhndl,
> -		      struct sisl_rht_entry *rhte,
> -		      struct ctx_info *ctxi,
> -		      u64 *new_size)
> -{
> -	struct cxlflash_cfg *cfg = shost_priv(sdev->host);
> -	struct device *dev = &cfg->dev->dev;
> -	struct sisl_lxt_entry *lxt, *lxt_old;
> -	struct llun_info *lli = sdev->hostdata;
> -	struct glun_info *gli = lli->parent;
> -	struct blka *blka = &gli->blka;
> -	ctx_hndl_t ctxid = DECODE_CTXID(ctxi->ctxid);
> -	bool needs_ws = ctxi->rht_needs_ws[rhndl];
> -	bool needs_sync = !ctxi->err_recovery_active;
> -	u32 ngrps, ngrps_old;
> -	u64 aun;		/* chunk# allocated by block allocator */
> -	u64 delta = rhte->lxt_cnt - *new_size;
> -	u64 my_new_size;
> -	int i, rc = 0;
> -
> -	lxt_old = rhte->lxt_start;
> -	ngrps_old = LXT_NUM_GROUPS(rhte->lxt_cnt);
> -	ngrps = LXT_NUM_GROUPS(rhte->lxt_cnt - delta);
> -
> -	if (ngrps != ngrps_old) {
> -		/* Reallocate to fit new size unless new size is 0 */
> -		if (ngrps) {
> -			lxt = kzalloc((sizeof(*lxt) * LXT_GROUP_SIZE * ngrps),
> -				      GFP_KERNEL);
> -			if (unlikely(!lxt)) {
> -				rc = -ENOMEM;
> -				goto out;
> -			}
> -
> -			/* Copy over old entries that will remain */
> -			memcpy(lxt, lxt_old,
> -			       (sizeof(*lxt) * (rhte->lxt_cnt - delta)));
> -		} else
> -			lxt = NULL;
> -	} else
> -		lxt = lxt_old;
> -
> -	/* Nothing can fail from now on */
> -	my_new_size = rhte->lxt_cnt - delta;
> -
> -	/*
> -	 * The following sequence is prescribed in the SISlite spec
> -	 * for syncing up with the AFU when removing LXT entries.
> -	 */
> -	rhte->lxt_cnt = my_new_size;
> -	dma_wmb(); /* Make RHT entry's LXT table size update visible */
> -
> -	rhte->lxt_start = lxt;
> -	dma_wmb(); /* Make RHT entry's LXT table update visible */
> -
> -	if (needs_sync) {
> -		rc = cxlflash_afu_sync(afu, ctxid, rhndl, AFU_HW_SYNC);
> -		if (unlikely(rc))
> -			rc = -EAGAIN;
> -	}
> -
> -	if (needs_ws) {
> -		/*
> -		 * Mark the context as unavailable, so that we can release
> -		 * the mutex safely.
> -		 */
> -		ctxi->unavail = true;
> -		mutex_unlock(&ctxi->mutex);
> -	}
> -
> -	/* Free LBAs allocated to freed chunks */
> -	mutex_lock(&blka->mutex);
> -	for (i = delta - 1; i >= 0; i--) {
> -		aun = lxt_old[my_new_size + i].rlba_base >> MC_CHUNK_SHIFT;
> -		if (needs_ws)
> -			write_same16(sdev, aun, MC_CHUNK_SIZE);
> -		ba_free(&blka->ba_lun, aun);
> -	}
> -	mutex_unlock(&blka->mutex);
> -
> -	if (needs_ws) {
> -		/* Make the context visible again */
> -		mutex_lock(&ctxi->mutex);
> -		ctxi->unavail = false;
> -	}
> -
> -	/* Free old lxt if reallocated */
> -	if (lxt != lxt_old)
> -		kfree(lxt_old);
> -	*new_size = my_new_size;
> -out:
> -	dev_dbg(dev, "%s: returning rc=%d\n", __func__, rc);
> -	return rc;
> -}
> -
> -/**
> - * _cxlflash_vlun_resize() - changes the size of a virtual LUN
> - * @sdev:	SCSI device associated with LUN owning virtual LUN.
> - * @ctxi:	Context owning resources.
> - * @resize:	Resize ioctl data structure.
> - *
> - * On successful return, the user is informed of the new size (in blocks)
> - * of the virtual LUN in last LBA format. When the size of the virtual
> - * LUN is zero, the last LBA is reflected as -1. See comment in the
> - * prologue for _cxlflash_disk_release() regarding AFU syncs and contexts
> - * on the error recovery list.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -int _cxlflash_vlun_resize(struct scsi_device *sdev,
> -			  struct ctx_info *ctxi,
> -			  struct dk_cxlflash_resize *resize)
> -{
> -	struct cxlflash_cfg *cfg = shost_priv(sdev->host);
> -	struct device *dev = &cfg->dev->dev;
> -	struct llun_info *lli = sdev->hostdata;
> -	struct glun_info *gli = lli->parent;
> -	struct afu *afu = cfg->afu;
> -	bool put_ctx = false;
> -
> -	res_hndl_t rhndl = resize->rsrc_handle;
> -	u64 new_size;
> -	u64 nsectors;
> -	u64 ctxid = DECODE_CTXID(resize->context_id),
> -	    rctxid = resize->context_id;
> -
> -	struct sisl_rht_entry *rhte;
> -
> -	int rc = 0;
> -
> -	/*
> -	 * The requested size (req_size) is always assumed to be in 4k blocks,
> -	 * so we have to convert it here from 4k to chunk size.
> -	 */
> -	nsectors = (resize->req_size * CXLFLASH_BLOCK_SIZE) / gli->blk_len;
> -	new_size = DIV_ROUND_UP(nsectors, MC_CHUNK_SIZE);
> -
> -	dev_dbg(dev, "%s: ctxid=%llu rhndl=%llu req_size=%llu new_size=%llu\n",
> -		__func__, ctxid, resize->rsrc_handle, resize->req_size,
> -		new_size);
> -
> -	if (unlikely(gli->mode != MODE_VIRTUAL)) {
> -		dev_dbg(dev, "%s: LUN mode does not support resize mode=%d\n",
> -			__func__, gli->mode);
> -		rc = -EINVAL;
> -		goto out;
> -
> -	}
> -
> -	if (!ctxi) {
> -		ctxi = get_context(cfg, rctxid, lli, CTX_CTRL_ERR_FALLBACK);
> -		if (unlikely(!ctxi)) {
> -			dev_dbg(dev, "%s: Bad context ctxid=%llu\n",
> -				__func__, ctxid);
> -			rc = -EINVAL;
> -			goto out;
> -		}
> -
> -		put_ctx = true;
> -	}
> -
> -	rhte = get_rhte(ctxi, rhndl, lli);
> -	if (unlikely(!rhte)) {
> -		dev_dbg(dev, "%s: Bad resource handle rhndl=%u\n",
> -			__func__, rhndl);
> -		rc = -EINVAL;
> -		goto out;
> -	}
> -
> -	if (new_size > rhte->lxt_cnt)
> -		rc = grow_lxt(afu, sdev, ctxid, rhndl, rhte, &new_size);
> -	else if (new_size < rhte->lxt_cnt)
> -		rc = shrink_lxt(afu, sdev, rhndl, rhte, ctxi, &new_size);
> -	else {
> -		/*
> -		 * Rare case where there is already sufficient space, just
> -		 * need to perform a translation sync with the AFU. This
> -		 * scenario likely follows a previous sync failure during
> -		 * a resize operation. Accordingly, perform the heavyweight
> -		 * form of translation sync as it is unknown which type of
> -		 * resize failed previously.
> -		 */
> -		rc = cxlflash_afu_sync(afu, ctxid, rhndl, AFU_HW_SYNC);
> -		if (unlikely(rc)) {
> -			rc = -EAGAIN;
> -			goto out;
> -		}
> -	}
> -
> -	resize->hdr.return_flags = 0;
> -	resize->last_lba = (new_size * MC_CHUNK_SIZE * gli->blk_len);
> -	resize->last_lba /= CXLFLASH_BLOCK_SIZE;
> -	resize->last_lba--;
> -
> -out:
> -	if (put_ctx)
> -		put_context(ctxi);
> -	dev_dbg(dev, "%s: resized to %llu returning rc=%d\n",
> -		__func__, resize->last_lba, rc);
> -	return rc;
> -}
> -
> -int cxlflash_vlun_resize(struct scsi_device *sdev, void *resize)
> -{
> -	return _cxlflash_vlun_resize(sdev, NULL, resize);
> -}
> -
> -/**
> - * cxlflash_restore_luntable() - Restore LUN table to prior state
> - * @cfg:	Internal structure associated with the host.
> - */
> -void cxlflash_restore_luntable(struct cxlflash_cfg *cfg)
> -{
> -	struct llun_info *lli, *temp;
> -	u32 lind;
> -	int k;
> -	struct device *dev = &cfg->dev->dev;
> -	__be64 __iomem *fc_port_luns;
> -
> -	mutex_lock(&global.mutex);
> -
> -	list_for_each_entry_safe(lli, temp, &cfg->lluns, list) {
> -		if (!lli->in_table)
> -			continue;
> -
> -		lind = lli->lun_index;
> -		dev_dbg(dev, "%s: Virtual LUNs on slot %d:\n", __func__, lind);
> -
> -		for (k = 0; k < cfg->num_fc_ports; k++)
> -			if (lli->port_sel & (1 << k)) {
> -				fc_port_luns = get_fc_port_luns(cfg, k);
> -				writeq_be(lli->lun_id[k], &fc_port_luns[lind]);
> -				dev_dbg(dev, "\t%d=%llx\n", k, lli->lun_id[k]);
> -			}
> -	}
> -
> -	mutex_unlock(&global.mutex);
> -}
> -
> -/**
> - * get_num_ports() - compute number of ports from port selection mask
> - * @psm:	Port selection mask.
> - *
> - * Return: Population count of port selection mask
> - */
> -static inline u8 get_num_ports(u32 psm)
> -{
> -	static const u8 bits[16] = { 0, 1, 1, 2, 1, 2, 2, 3,
> -				     1, 2, 2, 3, 2, 3, 3, 4 };
> -
> -	return bits[psm & 0xf];
> -}
> -
> -/**
> - * init_luntable() - write an entry in the LUN table
> - * @cfg:	Internal structure associated with the host.
> - * @lli:	Per adapter LUN information structure.
> - *
> - * On successful return, a LUN table entry is created:
> - *	- at the top for LUNs visible on multiple ports.
> - *	- at the bottom for LUNs visible only on one port.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int init_luntable(struct cxlflash_cfg *cfg, struct llun_info *lli)
> -{
> -	u32 chan;
> -	u32 lind;
> -	u32 nports;
> -	int rc = 0;
> -	int k;
> -	struct device *dev = &cfg->dev->dev;
> -	__be64 __iomem *fc_port_luns;
> -
> -	mutex_lock(&global.mutex);
> -
> -	if (lli->in_table)
> -		goto out;
> -
> -	nports = get_num_ports(lli->port_sel);
> -	if (nports == 0 || nports > cfg->num_fc_ports) {
> -		WARN(1, "Unsupported port configuration nports=%u", nports);
> -		rc = -EIO;
> -		goto out;
> -	}
> -
> -	if (nports > 1) {
> -		/*
> -		 * When LUN is visible from multiple ports, we will put
> -		 * it in the top half of the LUN table.
> -		 */
> -		for (k = 0; k < cfg->num_fc_ports; k++) {
> -			if (!(lli->port_sel & (1 << k)))
> -				continue;
> -
> -			if (cfg->promote_lun_index == cfg->last_lun_index[k]) {
> -				rc = -ENOSPC;
> -				goto out;
> -			}
> -		}
> -
> -		lind = lli->lun_index = cfg->promote_lun_index;
> -		dev_dbg(dev, "%s: Virtual LUNs on slot %d:\n", __func__, lind);
> -
> -		for (k = 0; k < cfg->num_fc_ports; k++) {
> -			if (!(lli->port_sel & (1 << k)))
> -				continue;
> -
> -			fc_port_luns = get_fc_port_luns(cfg, k);
> -			writeq_be(lli->lun_id[k], &fc_port_luns[lind]);
> -			dev_dbg(dev, "\t%d=%llx\n", k, lli->lun_id[k]);
> -		}
> -
> -		cfg->promote_lun_index++;
> -	} else {
> -		/*
> -		 * When LUN is visible only from one port, we will put
> -		 * it in the bottom half of the LUN table.
> -		 */
> -		chan = PORTMASK2CHAN(lli->port_sel);
> -		if (cfg->promote_lun_index == cfg->last_lun_index[chan]) {
> -			rc = -ENOSPC;
> -			goto out;
> -		}
> -
> -		lind = lli->lun_index = cfg->last_lun_index[chan];
> -		fc_port_luns = get_fc_port_luns(cfg, chan);
> -		writeq_be(lli->lun_id[chan], &fc_port_luns[lind]);
> -		cfg->last_lun_index[chan]--;
> -		dev_dbg(dev, "%s: Virtual LUNs on slot %d:\n\t%d=%llx\n",
> -			__func__, lind, chan, lli->lun_id[chan]);
> -	}
> -
> -	lli->in_table = true;
> -out:
> -	mutex_unlock(&global.mutex);
> -	dev_dbg(dev, "%s: returning rc=%d\n", __func__, rc);
> -	return rc;
> -}
> -
> -/**
> - * cxlflash_disk_virtual_open() - open a virtual disk of specified size
> - * @sdev:	SCSI device associated with LUN owning virtual LUN.
> - * @arg:	UVirtual ioctl data structure.
> - *
> - * On successful return, the user is informed of the resource handle
> - * to be used to identify the virtual LUN and the size (in blocks) of
> - * the virtual LUN in last LBA format. When the size of the virtual LUN
> - * is zero, the last LBA is reflected as -1.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -int cxlflash_disk_virtual_open(struct scsi_device *sdev, void *arg)
> -{
> -	struct cxlflash_cfg *cfg = shost_priv(sdev->host);
> -	struct device *dev = &cfg->dev->dev;
> -	struct llun_info *lli = sdev->hostdata;
> -	struct glun_info *gli = lli->parent;
> -
> -	struct dk_cxlflash_uvirtual *virt = (struct dk_cxlflash_uvirtual *)arg;
> -	struct dk_cxlflash_resize resize;
> -
> -	u64 ctxid = DECODE_CTXID(virt->context_id),
> -	    rctxid = virt->context_id;
> -	u64 lun_size = virt->lun_size;
> -	u64 last_lba = 0;
> -	u64 rsrc_handle = -1;
> -
> -	int rc = 0;
> -
> -	struct ctx_info *ctxi = NULL;
> -	struct sisl_rht_entry *rhte = NULL;
> -
> -	dev_dbg(dev, "%s: ctxid=%llu ls=%llu\n", __func__, ctxid, lun_size);
> -
> -	/* Setup the LUNs block allocator on first call */
> -	mutex_lock(&gli->mutex);
> -	if (gli->mode == MODE_NONE) {
> -		rc = init_vlun(lli);
> -		if (rc) {
> -			dev_err(dev, "%s: init_vlun failed rc=%d\n",
> -				__func__, rc);
> -			rc = -ENOMEM;
> -			goto err0;
> -		}
> -	}
> -
> -	rc = cxlflash_lun_attach(gli, MODE_VIRTUAL, true);
> -	if (unlikely(rc)) {
> -		dev_err(dev, "%s: Failed attach to LUN (VIRTUAL)\n", __func__);
> -		goto err0;
> -	}
> -	mutex_unlock(&gli->mutex);
> -
> -	rc = init_luntable(cfg, lli);
> -	if (rc) {
> -		dev_err(dev, "%s: init_luntable failed rc=%d\n", __func__, rc);
> -		goto err1;
> -	}
> -
> -	ctxi = get_context(cfg, rctxid, lli, 0);
> -	if (unlikely(!ctxi)) {
> -		dev_err(dev, "%s: Bad context ctxid=%llu\n", __func__, ctxid);
> -		rc = -EINVAL;
> -		goto err1;
> -	}
> -
> -	rhte = rhte_checkout(ctxi, lli);
> -	if (unlikely(!rhte)) {
> -		dev_err(dev, "%s: too many opens ctxid=%llu\n",
> -			__func__, ctxid);
> -		rc = -EMFILE;	/* too many opens  */
> -		goto err1;
> -	}
> -
> -	rsrc_handle = (rhte - ctxi->rht_start);
> -
> -	/* Populate RHT format 0 */
> -	rhte->nmask = MC_RHT_NMASK;
> -	rhte->fp = SISL_RHT_FP(0U, ctxi->rht_perms);
> -
> -	/* Resize even if requested size is 0 */
> -	marshal_virt_to_resize(virt, &resize);
> -	resize.rsrc_handle = rsrc_handle;
> -	rc = _cxlflash_vlun_resize(sdev, ctxi, &resize);
> -	if (rc) {
> -		dev_err(dev, "%s: resize failed rc=%d\n", __func__, rc);
> -		goto err2;
> -	}
> -	last_lba = resize.last_lba;
> -
> -	if (virt->hdr.flags & DK_CXLFLASH_UVIRTUAL_NEED_WRITE_SAME)
> -		ctxi->rht_needs_ws[rsrc_handle] = true;
> -
> -	virt->hdr.return_flags = 0;
> -	virt->last_lba = last_lba;
> -	virt->rsrc_handle = rsrc_handle;
> -
> -	if (get_num_ports(lli->port_sel) > 1)
> -		virt->hdr.return_flags |= DK_CXLFLASH_ALL_PORTS_ACTIVE;
> -out:
> -	if (likely(ctxi))
> -		put_context(ctxi);
> -	dev_dbg(dev, "%s: returning handle=%llu rc=%d llba=%llu\n",
> -		__func__, rsrc_handle, rc, last_lba);
> -	return rc;
> -
> -err2:
> -	rhte_checkin(ctxi, rhte);
> -err1:
> -	cxlflash_lun_detach(gli);
> -	goto out;
> -err0:
> -	/* Special common cleanup prior to successful LUN attach */
> -	cxlflash_ba_terminate(&gli->blka.ba_lun);
> -	mutex_unlock(&gli->mutex);
> -	goto out;
> -}
> -
> -/**
> - * clone_lxt() - copies translation tables from source to destination RHTE
> - * @afu:	AFU associated with the host.
> - * @blka:	Block allocator associated with LUN.
> - * @ctxid:	Context ID of context owning the RHTE.
> - * @rhndl:	Resource handle associated with the RHTE.
> - * @rhte:	Destination resource handle entry (RHTE).
> - * @rhte_src:	Source resource handle entry (RHTE).
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static int clone_lxt(struct afu *afu,
> -		     struct blka *blka,
> -		     ctx_hndl_t ctxid,
> -		     res_hndl_t rhndl,
> -		     struct sisl_rht_entry *rhte,
> -		     struct sisl_rht_entry *rhte_src)
> -{
> -	struct cxlflash_cfg *cfg = afu->parent;
> -	struct device *dev = &cfg->dev->dev;
> -	struct sisl_lxt_entry *lxt = NULL;
> -	bool locked = false;
> -	u32 ngrps;
> -	u64 aun;		/* chunk# allocated by block allocator */
> -	int j;
> -	int i = 0;
> -	int rc = 0;
> -
> -	ngrps = LXT_NUM_GROUPS(rhte_src->lxt_cnt);
> -
> -	if (ngrps) {
> -		/* allocate new LXTs for clone */
> -		lxt = kzalloc((sizeof(*lxt) * LXT_GROUP_SIZE * ngrps),
> -				GFP_KERNEL);
> -		if (unlikely(!lxt)) {
> -			rc = -ENOMEM;
> -			goto out;
> -		}
> -
> -		/* copy over */
> -		memcpy(lxt, rhte_src->lxt_start,
> -		       (sizeof(*lxt) * rhte_src->lxt_cnt));
> -
> -		/* clone the LBAs in block allocator via ref_cnt, note that the
> -		 * block allocator mutex must be held until it is established
> -		 * that this routine will complete without the need for a
> -		 * cleanup.
> -		 */
> -		mutex_lock(&blka->mutex);
> -		locked = true;
> -		for (i = 0; i < rhte_src->lxt_cnt; i++) {
> -			aun = (lxt[i].rlba_base >> MC_CHUNK_SHIFT);
> -			if (ba_clone(&blka->ba_lun, aun) == -1ULL) {
> -				rc = -EIO;
> -				goto err;
> -			}
> -		}
> -	}
> -
> -	/*
> -	 * The following sequence is prescribed in the SISlite spec
> -	 * for syncing up with the AFU when adding LXT entries.
> -	 */
> -	dma_wmb(); /* Make LXT updates are visible */
> -
> -	rhte->lxt_start = lxt;
> -	dma_wmb(); /* Make RHT entry's LXT table update visible */
> -
> -	rhte->lxt_cnt = rhte_src->lxt_cnt;
> -	dma_wmb(); /* Make RHT entry's LXT table size update visible */
> -
> -	rc = cxlflash_afu_sync(afu, ctxid, rhndl, AFU_LW_SYNC);
> -	if (unlikely(rc)) {
> -		rc = -EAGAIN;
> -		goto err2;
> -	}
> -
> -out:
> -	if (locked)
> -		mutex_unlock(&blka->mutex);
> -	dev_dbg(dev, "%s: returning rc=%d\n", __func__, rc);
> -	return rc;
> -err2:
> -	/* Reset the RHTE */
> -	rhte->lxt_cnt = 0;
> -	dma_wmb();
> -	rhte->lxt_start = NULL;
> -	dma_wmb();
> -err:
> -	/* free the clones already made */
> -	for (j = 0; j < i; j++) {
> -		aun = (lxt[j].rlba_base >> MC_CHUNK_SHIFT);
> -		ba_free(&blka->ba_lun, aun);
> -	}
> -	kfree(lxt);
> -	goto out;
> -}
> -
> -/**
> - * cxlflash_disk_clone() - clone a context by making snapshot of another
> - * @sdev:	SCSI device associated with LUN owning virtual LUN.
> - * @arg:	Clone ioctl data structure.
> - *
> - * This routine effectively performs cxlflash_disk_open operation for each
> - * in-use virtual resource in the source context. Note that the destination
> - * context must be in pristine state and cannot have any resource handles
> - * open at the time of the clone.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -int cxlflash_disk_clone(struct scsi_device *sdev, void *arg)
> -{
> -	struct dk_cxlflash_clone *clone = arg;
> -	struct cxlflash_cfg *cfg = shost_priv(sdev->host);
> -	struct device *dev = &cfg->dev->dev;
> -	struct llun_info *lli = sdev->hostdata;
> -	struct glun_info *gli = lli->parent;
> -	struct blka *blka = &gli->blka;
> -	struct afu *afu = cfg->afu;
> -	struct dk_cxlflash_release release = { { 0 }, 0 };
> -
> -	struct ctx_info *ctxi_src = NULL,
> -			*ctxi_dst = NULL;
> -	struct lun_access *lun_access_src, *lun_access_dst;
> -	u32 perms;
> -	u64 ctxid_src = DECODE_CTXID(clone->context_id_src),
> -	    ctxid_dst = DECODE_CTXID(clone->context_id_dst),
> -	    rctxid_src = clone->context_id_src,
> -	    rctxid_dst = clone->context_id_dst;
> -	int i, j;
> -	int rc = 0;
> -	bool found;
> -	LIST_HEAD(sidecar);
> -
> -	dev_dbg(dev, "%s: ctxid_src=%llu ctxid_dst=%llu\n",
> -		__func__, ctxid_src, ctxid_dst);
> -
> -	/* Do not clone yourself */
> -	if (unlikely(rctxid_src == rctxid_dst)) {
> -		rc = -EINVAL;
> -		goto out;
> -	}
> -
> -	if (unlikely(gli->mode != MODE_VIRTUAL)) {
> -		rc = -EINVAL;
> -		dev_dbg(dev, "%s: Only supported on virtual LUNs mode=%u\n",
> -			__func__, gli->mode);
> -		goto out;
> -	}
> -
> -	ctxi_src = get_context(cfg, rctxid_src, lli, CTX_CTRL_CLONE);
> -	ctxi_dst = get_context(cfg, rctxid_dst, lli, 0);
> -	if (unlikely(!ctxi_src || !ctxi_dst)) {
> -		dev_dbg(dev, "%s: Bad context ctxid_src=%llu ctxid_dst=%llu\n",
> -			__func__, ctxid_src, ctxid_dst);
> -		rc = -EINVAL;
> -		goto out;
> -	}
> -
> -	/* Verify there is no open resource handle in the destination context */
> -	for (i = 0; i < MAX_RHT_PER_CONTEXT; i++)
> -		if (ctxi_dst->rht_start[i].nmask != 0) {
> -			rc = -EINVAL;
> -			goto out;
> -		}
> -
> -	/* Clone LUN access list */
> -	list_for_each_entry(lun_access_src, &ctxi_src->luns, list) {
> -		found = false;
> -		list_for_each_entry(lun_access_dst, &ctxi_dst->luns, list)
> -			if (lun_access_dst->sdev == lun_access_src->sdev) {
> -				found = true;
> -				break;
> -			}
> -
> -		if (!found) {
> -			lun_access_dst = kzalloc(sizeof(*lun_access_dst),
> -						 GFP_KERNEL);
> -			if (unlikely(!lun_access_dst)) {
> -				dev_err(dev, "%s: lun_access allocation fail\n",
> -					__func__);
> -				rc = -ENOMEM;
> -				goto out;
> -			}
> -
> -			*lun_access_dst = *lun_access_src;
> -			list_add(&lun_access_dst->list, &sidecar);
> -		}
> -	}
> -
> -	if (unlikely(!ctxi_src->rht_out)) {
> -		dev_dbg(dev, "%s: Nothing to clone\n", __func__);
> -		goto out_success;
> -	}
> -
> -	/* User specified permission on attach */
> -	perms = ctxi_dst->rht_perms;
> -
> -	/*
> -	 * Copy over checked-out RHT (and their associated LXT) entries by
> -	 * hand, stopping after we've copied all outstanding entries and
> -	 * cleaning up if the clone fails.
> -	 *
> -	 * Note: This loop is equivalent to performing cxlflash_disk_open and
> -	 * cxlflash_vlun_resize. As such, LUN accounting needs to be taken into
> -	 * account by attaching after each successful RHT entry clone. In the
> -	 * event that a clone failure is experienced, the LUN detach is handled
> -	 * via the cleanup performed by _cxlflash_disk_release.
> -	 */
> -	for (i = 0; i < MAX_RHT_PER_CONTEXT; i++) {
> -		if (ctxi_src->rht_out == ctxi_dst->rht_out)
> -			break;
> -		if (ctxi_src->rht_start[i].nmask == 0)
> -			continue;
> -
> -		/* Consume a destination RHT entry */
> -		ctxi_dst->rht_out++;
> -		ctxi_dst->rht_start[i].nmask = ctxi_src->rht_start[i].nmask;
> -		ctxi_dst->rht_start[i].fp =
> -		    SISL_RHT_FP_CLONE(ctxi_src->rht_start[i].fp, perms);
> -		ctxi_dst->rht_lun[i] = ctxi_src->rht_lun[i];
> -
> -		rc = clone_lxt(afu, blka, ctxid_dst, i,
> -			       &ctxi_dst->rht_start[i],
> -			       &ctxi_src->rht_start[i]);
> -		if (rc) {
> -			marshal_clone_to_rele(clone, &release);
> -			for (j = 0; j < i; j++) {
> -				release.rsrc_handle = j;
> -				_cxlflash_disk_release(sdev, ctxi_dst,
> -						       &release);
> -			}
> -
> -			/* Put back the one we failed on */
> -			rhte_checkin(ctxi_dst, &ctxi_dst->rht_start[i]);
> -			goto err;
> -		}
> -
> -		cxlflash_lun_attach(gli, gli->mode, false);
> -	}
> -
> -out_success:
> -	list_splice(&sidecar, &ctxi_dst->luns);
> -
> -	/* fall through */
> -out:
> -	if (ctxi_src)
> -		put_context(ctxi_src);
> -	if (ctxi_dst)
> -		put_context(ctxi_dst);
> -	dev_dbg(dev, "%s: returning rc=%d\n", __func__, rc);
> -	return rc;
> -
> -err:
> -	list_for_each_entry_safe(lun_access_src, lun_access_dst, &sidecar, list)
> -		kfree(lun_access_src);
> -	goto out;
> -}
> diff --git a/drivers/scsi/cxlflash/vlun.h b/drivers/scsi/cxlflash/vlun.h
> deleted file mode 100644
> index 68e3ea52fe80..000000000000
> --- a/drivers/scsi/cxlflash/vlun.h
> +++ /dev/null
> @@ -1,82 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * CXL Flash Device Driver
> - *
> - * Written by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>, IBM Corporation
> - *             Matthew R. Ochs <mrochs@linux.vnet.ibm.com>, IBM Corporation
> - *
> - * Copyright (C) 2015 IBM Corporation
> - */
> -
> -#ifndef _CXLFLASH_VLUN_H
> -#define _CXLFLASH_VLUN_H
> -
> -/* RHT - Resource Handle Table */
> -#define MC_RHT_NMASK      16	/* in bits */
> -#define MC_CHUNK_SHIFT    MC_RHT_NMASK	/* shift to go from LBA to chunk# */
> -
> -#define HIBIT             (BITS_PER_LONG - 1)
> -
> -#define MAX_AUN_CLONE_CNT 0xFF
> -
> -/*
> - * LXT - LBA Translation Table
> - *
> - * +-------+-------+-------+-------+-------+-------+-------+---+---+
> - * | RLBA_BASE                                     |LUN_IDX| P |SEL|
> - * +-------+-------+-------+-------+-------+-------+-------+---+---+
> - *
> - * The LXT Entry contains the physical LBA where the chunk starts (RLBA_BASE).
> - * AFU ORes the low order bits from the virtual LBA (offset into the chunk)
> - * with RLBA_BASE. The result is the physical LBA to be sent to storage.
> - * The LXT Entry also contains an index to a LUN TBL and a bitmask of which
> - * outgoing (FC) * ports can be selected. The port select bit-mask is ANDed
> - * with a global port select bit-mask maintained by the driver.
> - * In addition, it has permission bits that are ANDed with the
> - * RHT permissions to arrive at the final permissions for the chunk.
> - *
> - * LXT tables are allocated dynamically in groups. This is done to avoid
> - * a malloc/free overhead each time the LXT has to grow or shrink.
> - *
> - * Based on the current lxt_cnt (used), it is always possible to know
> - * how many are allocated (used+free). The number of allocated entries is
> - * not stored anywhere.
> - *
> - * The LXT table is re-allocated whenever it needs to cross into another group.
> - */
> -#define LXT_GROUP_SIZE          8
> -#define LXT_NUM_GROUPS(lxt_cnt) (((lxt_cnt) + 7)/8)	/* alloc'ed groups */
> -#define LXT_LUNIDX_SHIFT  8	/* LXT entry, shift for LUN index */
> -#define LXT_PERM_SHIFT    4	/* LXT entry, shift for permission bits */
> -
> -struct ba_lun_info {
> -	u64 *lun_alloc_map;
> -	u32 lun_bmap_size;
> -	u32 total_aus;
> -	u64 free_aun_cnt;
> -
> -	/* indices to be used for elevator lookup of free map */
> -	u32 free_low_idx;
> -	u32 free_curr_idx;
> -	u32 free_high_idx;
> -
> -	u8 *aun_clone_map;
> -};
> -
> -struct ba_lun {
> -	u64 lun_id;
> -	u64 wwpn;
> -	size_t lsize;		/* LUN size in number of LBAs             */
> -	size_t lba_size;	/* LBA size in number of bytes            */
> -	size_t au_size;		/* Allocation Unit size in number of LBAs */
> -	struct ba_lun_info *ba_lun_handle;
> -};
> -
> -/* Block Allocator */
> -struct blka {
> -	struct ba_lun ba_lun;
> -	u64 nchunk;		/* number of chunks */
> -	struct mutex mutex;
> -};
> -
> -#endif /* ifndef _CXLFLASH_SUPERPIPE_H */
> diff --git a/include/uapi/scsi/cxlflash_ioctl.h b/include/uapi/scsi/cxlflash_ioctl.h
> deleted file mode 100644
> index 513da47aa5ab..000000000000
> --- a/include/uapi/scsi/cxlflash_ioctl.h
> +++ /dev/null
> @@ -1,276 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> -/*
> - * CXL Flash Device Driver
> - *
> - * Written by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>, IBM Corporation
> - *             Matthew R. Ochs <mrochs@linux.vnet.ibm.com>, IBM Corporation
> - *
> - * Copyright (C) 2015 IBM Corporation
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * as published by the Free Software Foundation; either version
> - * 2 of the License, or (at your option) any later version.
> - */
> -
> -#ifndef _CXLFLASH_IOCTL_H
> -#define _CXLFLASH_IOCTL_H
> -
> -#include <linux/types.h>
> -
> -/*
> - * Structure and definitions for all CXL Flash ioctls
> - */
> -#define CXLFLASH_WWID_LEN		16
> -
> -/*
> - * Structure and flag definitions CXL Flash superpipe ioctls
> - */
> -
> -#define DK_CXLFLASH_VERSION_0	0
> -
> -struct dk_cxlflash_hdr {
> -	__u16 version;			/* Version data */
> -	__u16 rsvd[3];			/* Reserved for future use */
> -	__u64 flags;			/* Input flags */
> -	__u64 return_flags;		/* Returned flags */
> -};
> -
> -/*
> - * Return flag definitions available to all superpipe ioctls
> - *
> - * Similar to the input flags, these are grown from the bottom-up with the
> - * intention that ioctl-specific return flag definitions would grow from the
> - * top-down, allowing the two sets to co-exist. While not required/enforced
> - * at this time, this provides future flexibility.
> - */
> -#define DK_CXLFLASH_ALL_PORTS_ACTIVE	0x0000000000000001ULL
> -#define DK_CXLFLASH_APP_CLOSE_ADAP_FD	0x0000000000000002ULL
> -#define DK_CXLFLASH_CONTEXT_SQ_CMD_MODE	0x0000000000000004ULL
> -
> -/*
> - * General Notes:
> - * -------------
> - * The 'context_id' field of all ioctl structures contains the context
> - * identifier for a context in the lower 32-bits (upper 32-bits are not
> - * to be used when identifying a context to the AFU). That said, the value
> - * in its entirety (all 64-bits) is to be treated as an opaque cookie and
> - * should be presented as such when issuing ioctls.
> - */
> -
> -/*
> - * DK_CXLFLASH_ATTACH Notes:
> - * ------------------------
> - * Read/write access permissions are specified via the O_RDONLY, O_WRONLY,
> - * and O_RDWR flags defined in the fcntl.h header file.
> - *
> - * A valid adapter file descriptor (fd >= 0) is only returned on the initial
> - * attach (successful) of a context. When a context is shared(reused), the user
> - * is expected to already 'know' the adapter file descriptor associated with the
> - * context.
> - */
> -#define DK_CXLFLASH_ATTACH_REUSE_CONTEXT	0x8000000000000000ULL
> -
> -struct dk_cxlflash_attach {
> -	struct dk_cxlflash_hdr hdr;	/* Common fields */
> -	__u64 num_interrupts;		/* Requested number of interrupts */
> -	__u64 context_id;		/* Returned context */
> -	__u64 mmio_size;		/* Returned size of MMIO area */
> -	__u64 block_size;		/* Returned block size, in bytes */
> -	__u64 adap_fd;			/* Returned adapter file descriptor */
> -	__u64 last_lba;			/* Returned last LBA on the device */
> -	__u64 max_xfer;			/* Returned max transfer size, blocks */
> -	__u64 reserved[8];		/* Reserved for future use */
> -};
> -
> -struct dk_cxlflash_detach {
> -	struct dk_cxlflash_hdr hdr;	/* Common fields */
> -	__u64 context_id;		/* Context to detach */
> -	__u64 reserved[8];		/* Reserved for future use */
> -};
> -
> -struct dk_cxlflash_udirect {
> -	struct dk_cxlflash_hdr hdr;	/* Common fields */
> -	__u64 context_id;		/* Context to own physical resources */
> -	__u64 rsrc_handle;		/* Returned resource handle */
> -	__u64 last_lba;			/* Returned last LBA on the device */
> -	__u64 reserved[8];		/* Reserved for future use */
> -};
> -
> -#define DK_CXLFLASH_UVIRTUAL_NEED_WRITE_SAME	0x8000000000000000ULL
> -
> -struct dk_cxlflash_uvirtual {
> -	struct dk_cxlflash_hdr hdr;	/* Common fields */
> -	__u64 context_id;		/* Context to own virtual resources */
> -	__u64 lun_size;			/* Requested size, in 4K blocks */
> -	__u64 rsrc_handle;		/* Returned resource handle */
> -	__u64 last_lba;			/* Returned last LBA of LUN */
> -	__u64 reserved[8];		/* Reserved for future use */
> -};
> -
> -struct dk_cxlflash_release {
> -	struct dk_cxlflash_hdr hdr;	/* Common fields */
> -	__u64 context_id;		/* Context owning resources */
> -	__u64 rsrc_handle;		/* Resource handle to release */
> -	__u64 reserved[8];		/* Reserved for future use */
> -};
> -
> -struct dk_cxlflash_resize {
> -	struct dk_cxlflash_hdr hdr;	/* Common fields */
> -	__u64 context_id;		/* Context owning resources */
> -	__u64 rsrc_handle;		/* Resource handle of LUN to resize */
> -	__u64 req_size;			/* New requested size, in 4K blocks */
> -	__u64 last_lba;			/* Returned last LBA of LUN */
> -	__u64 reserved[8];		/* Reserved for future use */
> -};
> -
> -struct dk_cxlflash_clone {
> -	struct dk_cxlflash_hdr hdr;	/* Common fields */
> -	__u64 context_id_src;		/* Context to clone from */
> -	__u64 context_id_dst;		/* Context to clone to */
> -	__u64 adap_fd_src;		/* Source context adapter fd */
> -	__u64 reserved[8];		/* Reserved for future use */
> -};
> -
> -#define DK_CXLFLASH_VERIFY_SENSE_LEN	18
> -#define DK_CXLFLASH_VERIFY_HINT_SENSE	0x8000000000000000ULL
> -
> -struct dk_cxlflash_verify {
> -	struct dk_cxlflash_hdr hdr;	/* Common fields */
> -	__u64 context_id;		/* Context owning resources to verify */
> -	__u64 rsrc_handle;		/* Resource handle of LUN */
> -	__u64 hint;			/* Reasons for verify */
> -	__u64 last_lba;			/* Returned last LBA of device */
> -	__u8 sense_data[DK_CXLFLASH_VERIFY_SENSE_LEN]; /* SCSI sense data */
> -	__u8 pad[6];			/* Pad to next 8-byte boundary */
> -	__u64 reserved[8];		/* Reserved for future use */
> -};
> -
> -#define DK_CXLFLASH_RECOVER_AFU_CONTEXT_RESET	0x8000000000000000ULL
> -
> -struct dk_cxlflash_recover_afu {
> -	struct dk_cxlflash_hdr hdr;	/* Common fields */
> -	__u64 reason;			/* Reason for recovery request */
> -	__u64 context_id;		/* Context to recover / updated ID */
> -	__u64 mmio_size;		/* Returned size of MMIO area */
> -	__u64 adap_fd;			/* Returned adapter file descriptor */
> -	__u64 reserved[8];		/* Reserved for future use */
> -};
> -
> -#define DK_CXLFLASH_MANAGE_LUN_WWID_LEN			CXLFLASH_WWID_LEN
> -#define DK_CXLFLASH_MANAGE_LUN_ENABLE_SUPERPIPE		0x8000000000000000ULL
> -#define DK_CXLFLASH_MANAGE_LUN_DISABLE_SUPERPIPE	0x4000000000000000ULL
> -#define DK_CXLFLASH_MANAGE_LUN_ALL_PORTS_ACCESSIBLE	0x2000000000000000ULL
> -
> -struct dk_cxlflash_manage_lun {
> -	struct dk_cxlflash_hdr hdr;			/* Common fields */
> -	__u8 wwid[DK_CXLFLASH_MANAGE_LUN_WWID_LEN];	/* Page83 WWID, NAA-6 */
> -	__u64 reserved[8];				/* Rsvd, future use */
> -};
> -
> -union cxlflash_ioctls {
> -	struct dk_cxlflash_attach attach;
> -	struct dk_cxlflash_detach detach;
> -	struct dk_cxlflash_udirect udirect;
> -	struct dk_cxlflash_uvirtual uvirtual;
> -	struct dk_cxlflash_release release;
> -	struct dk_cxlflash_resize resize;
> -	struct dk_cxlflash_clone clone;
> -	struct dk_cxlflash_verify verify;
> -	struct dk_cxlflash_recover_afu recover_afu;
> -	struct dk_cxlflash_manage_lun manage_lun;
> -};
> -
> -#define MAX_CXLFLASH_IOCTL_SZ	(sizeof(union cxlflash_ioctls))
> -
> -#define CXL_MAGIC 0xCA
> -#define CXL_IOWR(_n, _s)	_IOWR(CXL_MAGIC, _n, struct _s)
> -
> -/*
> - * CXL Flash superpipe ioctls start at base of the reserved CXL_MAGIC
> - * region (0x80) and grow upwards.
> - */
> -#define DK_CXLFLASH_ATTACH		CXL_IOWR(0x80, dk_cxlflash_attach)
> -#define DK_CXLFLASH_USER_DIRECT		CXL_IOWR(0x81, dk_cxlflash_udirect)
> -#define DK_CXLFLASH_RELEASE		CXL_IOWR(0x82, dk_cxlflash_release)
> -#define DK_CXLFLASH_DETACH		CXL_IOWR(0x83, dk_cxlflash_detach)
> -#define DK_CXLFLASH_VERIFY		CXL_IOWR(0x84, dk_cxlflash_verify)
> -#define DK_CXLFLASH_RECOVER_AFU		CXL_IOWR(0x85, dk_cxlflash_recover_afu)
> -#define DK_CXLFLASH_MANAGE_LUN		CXL_IOWR(0x86, dk_cxlflash_manage_lun)
> -#define DK_CXLFLASH_USER_VIRTUAL	CXL_IOWR(0x87, dk_cxlflash_uvirtual)
> -#define DK_CXLFLASH_VLUN_RESIZE		CXL_IOWR(0x88, dk_cxlflash_resize)
> -#define DK_CXLFLASH_VLUN_CLONE		CXL_IOWR(0x89, dk_cxlflash_clone)
> -
> -/*
> - * Structure and flag definitions CXL Flash host ioctls
> - */
> -
> -#define HT_CXLFLASH_VERSION_0  0
> -
> -struct ht_cxlflash_hdr {
> -	__u16 version;		/* Version data */
> -	__u16 subcmd;		/* Sub-command */
> -	__u16 rsvd[2];		/* Reserved for future use */
> -	__u64 flags;		/* Input flags */
> -	__u64 return_flags;	/* Returned flags */
> -};
> -
> -/*
> - * Input flag definitions available to all host ioctls
> - *
> - * These are grown from the bottom-up with the intention that ioctl-specific
> - * input flag definitions would grow from the top-down, allowing the two sets
> - * to co-exist. While not required/enforced at this time, this provides future
> - * flexibility.
> - */
> -#define HT_CXLFLASH_HOST_READ				0x0000000000000000ULL
> -#define HT_CXLFLASH_HOST_WRITE				0x0000000000000001ULL
> -
> -#define HT_CXLFLASH_LUN_PROVISION_SUBCMD_CREATE_LUN	0x0001
> -#define HT_CXLFLASH_LUN_PROVISION_SUBCMD_DELETE_LUN	0x0002
> -#define HT_CXLFLASH_LUN_PROVISION_SUBCMD_QUERY_PORT	0x0003
> -
> -struct ht_cxlflash_lun_provision {
> -	struct ht_cxlflash_hdr hdr; /* Common fields */
> -	__u16 port;		    /* Target port for provision request */
> -	__u16 reserved16[3];	    /* Reserved for future use */
> -	__u64 size;		    /* Size of LUN (4K blocks) */
> -	__u64 lun_id;		    /* SCSI LUN ID */
> -	__u8 wwid[CXLFLASH_WWID_LEN];/* Page83 WWID, NAA-6 */
> -	__u64 max_num_luns;	    /* Maximum number of LUNs provisioned */
> -	__u64 cur_num_luns;	    /* Current number of LUNs provisioned */
> -	__u64 max_cap_port;	    /* Total capacity for port (4K blocks) */
> -	__u64 cur_cap_port;	    /* Current capacity for port (4K blocks) */
> -	__u64 reserved[8];	    /* Reserved for future use */
> -};
> -
> -#define	HT_CXLFLASH_AFU_DEBUG_MAX_DATA_LEN		262144	/* 256K */
> -#define HT_CXLFLASH_AFU_DEBUG_SUBCMD_LEN		12
> -struct ht_cxlflash_afu_debug {
> -	struct ht_cxlflash_hdr hdr; /* Common fields */
> -	__u8 reserved8[4];	    /* Reserved for future use */
> -	__u8 afu_subcmd[HT_CXLFLASH_AFU_DEBUG_SUBCMD_LEN]; /* AFU subcommand,
> -							    * (pass through)
> -							    */
> -	__u64 data_ea;		    /* Data buffer effective address */
> -	__u32 data_len;		    /* Data buffer length */
> -	__u32 reserved32;	    /* Reserved for future use */
> -	__u64 reserved[8];	    /* Reserved for future use */
> -};
> -
> -union cxlflash_ht_ioctls {
> -	struct ht_cxlflash_lun_provision lun_provision;
> -	struct ht_cxlflash_afu_debug afu_debug;
> -};
> -
> -#define MAX_HT_CXLFLASH_IOCTL_SZ	(sizeof(union cxlflash_ht_ioctls))
> -
> -/*
> - * CXL Flash host ioctls start at the top of the reserved CXL_MAGIC
> - * region (0xBF) and grow downwards.
> - */
> -#define HT_CXLFLASH_LUN_PROVISION CXL_IOWR(0xBF, ht_cxlflash_lun_provision)
> -#define HT_CXLFLASH_AFU_DEBUG	  CXL_IOWR(0xBE, ht_cxlflash_afu_debug)
> -
> -
> -#endif /* ifndef _CXLFLASH_IOCTL_H */
> diff --git a/tools/testing/selftests/filesystems/statmount/statmount_test.c b/tools/testing/selftests/filesystems/statmount/statmount_test.c
> index 8eb6aa606a0d..3ef652da7758 100644
> --- a/tools/testing/selftests/filesystems/statmount/statmount_test.c
> +++ b/tools/testing/selftests/filesystems/statmount/statmount_test.c
> @@ -26,13 +26,12 @@ static const char *const known_fs[] = {
>   	"hfsplus", "hostfs", "hpfs", "hugetlbfs", "ibmasmfs", "iomem",
>   	"ipathfs", "iso9660", "jffs2", "jfs", "minix", "mqueue", "msdos",
>   	"nfs", "nfs4", "nfsd", "nilfs2", "nsfs", "ntfs", "ntfs3", "ocfs2",
> -	"ocfs2_dlmfs", "ocxlflash", "omfs", "openpromfs", "overlay", "pipefs",
> -	"proc", "pstore", "pvfs2", "qnx4", "qnx6", "ramfs",
> -	"resctrl", "romfs", "rootfs", "rpc_pipefs", "s390_hypfs", "secretmem",
> -	"securityfs", "selinuxfs", "smackfs", "smb3", "sockfs", "spufs",
> -	"squashfs", "sysfs", "sysv", "tmpfs", "tracefs", "ubifs", "udf",
> -	"ufs", "v7", "vboxsf", "vfat", "virtiofs", "vxfs", "xenfs", "xfs",
> -	"zonefs", NULL };
> +	"ocfs2_dlmfs", "omfs", "openpromfs", "overlay", "pipefs", "proc",
> +	"pstore", "pvfs2", "qnx4", "qnx6", "ramfs", "resctrl", "romfs",
> +	"rootfs", "rpc_pipefs", "s390_hypfs", "secretmem", "securityfs",
> +	"selinuxfs", "smackfs", "smb3", "sockfs", "spufs", "squashfs", "sysfs",
> +	"sysv", "tmpfs", "tracefs", "ubifs", "udf", "ufs", "v7", "vboxsf",
> +	"vfat", "virtiofs", "vxfs", "xenfs", "xfs", "zonefs", NULL };
>   
>   static struct statmount *statmount_alloc(uint64_t mnt_id, uint64_t mask, unsigned int flags)
>   {



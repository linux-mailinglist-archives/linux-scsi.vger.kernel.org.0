Return-Path: <linux-scsi+bounces-4829-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5E18BA598
	for <lists+linux-scsi@lfdr.de>; Fri,  3 May 2024 05:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15D2A1C226A7
	for <lists+linux-scsi@lfdr.de>; Fri,  3 May 2024 03:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C0D1BF31;
	Fri,  3 May 2024 03:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PODfveGS"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446F01C2BD;
	Fri,  3 May 2024 03:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714706172; cv=none; b=F28OQua0DzCqYo5DZRGEurQQ0owru157nYR/Of6pJ6NEdmuuoLViG/4oA1vav4zPbT3eDDRAhjxlTx+UX72ba/LLPDIBCMfKk1fPHoxqimB6gupoUHjBCAEDuW44Q8BDfBqJTW6jV411RcAWsGwEU4n8tQm6xHWqoE2l6CBLE4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714706172; c=relaxed/simple;
	bh=LBvd+4AnWIITGW/nEbgX7CcF19HFn3qs1efUYxElWhw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P2P166Ei35h60ZjI/uJQZ8HScvY6dakTEOXfOYVhtYFLja9AdtLJiTY3kSprlomK9yYTHE+InHrWlAErNo2na3ZRdpyjDs8q2ZP78T8KUSAzFwbqlYQbcCk1T9mObaNq4ppgXZgC9bILl+H912NSCOlruJN4/UB1YB7iTa5BeY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PODfveGS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44332mu5006052;
	Fri, 3 May 2024 03:16:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=FUEPZyeQ6E9X+YqiM07yuAll3kHUaB/2iLvb4DKr34U=;
 b=PODfveGSIpUJGZs+LVLLYNKzTCFw6wwySWH4yEozSzGzydBtrRz7CCnHvAEhEzvLCHnX
 3iaSwd1tamkdtLCTkEThHf2R/DX4hx4CWGCXnEFuCfoNtm9lJvuOe61iv4tYoKtvQLMx
 x9jXiwfGYYV/VFGt5LIai02IgWee6P0ZcX6sgSG4xeSZXXgdu423AKLTqJCQP84ITAaN
 uzVfhj19AebihLfrQhwRESr1jpp9hZPxuESWsJ9Dpg8jz/FcAdHF33K4fJPycTgOq8CD
 0f/i4ErzxVSyKobXr3yRj+F9mb7CDZGeWN/sw9CH1LOdMBYG/vYLu6YoZLSLke0FLugH 6w== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xvqnng0rf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 May 2024 03:16:04 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4431FKKQ027546;
	Fri, 3 May 2024 03:16:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xsc30unav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 May 2024 03:16:03 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4433FxtO50856426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 May 2024 03:16:01 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61BF620043;
	Fri,  3 May 2024 03:15:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E259820040;
	Fri,  3 May 2024 03:15:58 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  3 May 2024 03:15:58 +0000 (GMT)
Received: from jarvis.ozlabs.ibm.com (unknown [9.36.16.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 9BF5D6013D;
	Fri,  3 May 2024 13:15:52 +1000 (AEST)
Message-ID: <33cf08b4fe751af156b1a7c17f69a0ca37dc5eed.camel@linux.ibm.com>
Subject: Re: [PATCH 2/2] MAINTAINERS: Make cxl obsolete
From: Andrew Donnellan <ajd@linux.ibm.com>
To: Michael Ellerman <michaele@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc: manoj@linux.ibm.com, ukrishn@linux.ibm.com, fbarrat@linux.ibm.com
Date: Fri, 03 May 2024 13:15:42 +1000
In-Reply-To: <87bk6jb17s.fsf@mail.lhotse>
References: <20240409031027.41587-1-ajd@linux.ibm.com>
	 <20240409031027.41587-2-ajd@linux.ibm.com> <87bk6jb17s.fsf@mail.lhotse>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rQH_kHX4eTTFmHxf5Hj-M8yOj7YKSTE3
X-Proofpoint-ORIG-GUID: rQH_kHX4eTTFmHxf5Hj-M8yOj7YKSTE3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_01,2024-05-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 mlxscore=0 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=768 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405030021

On Tue, 2024-04-09 at 14:37 +1000, Michael Ellerman wrote:
>=20
> Something like the patch below. Anyone who has an existing config and
> runs oldconfig will get a prompt, eg:
>=20
> =C2=A0 Deprecated support for IBM Coherent Accelerators (CXL)
> (DEPRECATED_CXL) [N/m/y/?] (NEW)
>=20
> Folks who just use defconfig etc. won't notice any change which is a
> pity. We could also change the default to n, but that risks breaking
> someone's machine. Maybe we do that in a another releases time.
>=20
> cheers
>=20
> diff --git a/drivers/misc/cxl/Kconfig b/drivers/misc/cxl/Kconfig
> index 5efc4151bf58..e3fd3fcaf62a 100644
> --- a/drivers/misc/cxl/Kconfig
> +++ b/drivers/misc/cxl/Kconfig
> @@ -9,11 +9,18 @@ config CXL_BASE
> =C2=A0	select PPC_64S_HASH_MMU
> =C2=A0
> =C2=A0config CXL
> -	tristate "Support for IBM Coherent Accelerators (CXL)"
> +	def_bool y
> +	depends on DEPRECATED_CXL
> +
> +config DEPRECATED_CXL
> +	tristate "Deprecated support for IBM Coherent Accelerators
> (CXL)"

This doesn't seem quite right to me, I don't think we can just redefine
CONFIG_CXL as a bool, but I'll do something like this. Probably won't
bother for CXLFLASH since they'll see it for CXL anyway, but I might
add a warning message on probe to both drivers.

> =C2=A0	depends on PPC_POWERNV && PCI_MSI && EEH
> =C2=A0	select CXL_BASE
> =C2=A0	default m
> =C2=A0	help
> +	=C2=A0 The cxl driver is no longer actively maintained and we
> intend to
> +	=C2=A0 remove it in a future kernel release.
> +
> =C2=A0	=C2=A0 Select this option to enable driver support for IBM
> Coherent
> =C2=A0	=C2=A0 Accelerators (CXL).=C2=A0 CXL is otherwise known as Coheren=
t
> Accelerator
> =C2=A0	=C2=A0 Processor Interface (CAPI).=C2=A0 CAPI allows accelerators =
in
> FPGAs to be

--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited


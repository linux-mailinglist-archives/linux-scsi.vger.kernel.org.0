Return-Path: <linux-scsi+bounces-1900-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A8783C03D
	for <lists+linux-scsi@lfdr.de>; Thu, 25 Jan 2024 12:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D84CF1F2193A
	for <lists+linux-scsi@lfdr.de>; Thu, 25 Jan 2024 11:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEB150A8E;
	Thu, 25 Jan 2024 10:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="oYSPy01E"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8331BF32
	for <linux-scsi@vger.kernel.org>; Thu, 25 Jan 2024 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179806; cv=fail; b=ivmn4mVfc0O1wosOQCqjPMQvL8bRWG1ry6+HRo74Jyo+MMdy72qitxiHB21KWE+HOW3IlAfAhh3GK1tk3IrYkmfHe2bXLj4R9lFTzVahohTG8GdGAZxnUyR0RTd0vNN0Hgd8WEYEvJYBbT4bSAhyR1DPYZDs/ns+Ln9XWRlOMMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179806; c=relaxed/simple;
	bh=hTZ2ugUIFTidCXrnvNaacqGYxGvvp+xG3RBxICCkUpk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kNVreaFkyAABEhOtYveHPw5oVsF4BZba0aOgL0up3tyUEGf3DXq+prp/GbMBoM2iGrq5fZ5dTrCOQ2qW9UaH6nvscB1mAKC2jT64dp3dHX0WtsJ31EoEleDNmIg5oM5mHuzEFQ5rd+d2kTqr8W/TgQNVcn0W2XPvfTXDXHOaIOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b=oYSPy01E; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40P5MO5h001507;
	Thu, 25 Jan 2024 02:50:00 -0800
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3vuhehrwte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 02:49:59 -0800 (PST)
Received: from m0045849.ppops.net (m0045849.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.24/8.17.1.24) with ESMTP id 40PAU8rG031936;
	Thu, 25 Jan 2024 02:49:59 -0800
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3vuhehrwtc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 02:49:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnA5+CmuHiVTd70IgAKV2IZ/RJVnjUFdWEky0Wr64dSI48mam2sRRs8SinWC6b/BuYkMenqdd66767MfQwLGwl6zlvR+YQT/xCghU2KfkPrwkLhsbjkGnEduSFYk6zqE83U+4Drg8wrNp2iw77nRxEwBWUp+1ZZ8nO+ClP0q70gqUtWbNehigPhYjdaEeV2w5ijyMqf4NwE4XRM2hO1ttPNjGv+aRFOFpm5S3PwxJkk+zjnLjy0Ptp/Y8KI9C8xtLu9fG9jUM6u202AHkXIDLkzVakYVd3MUjj40IuaLB08/v+9MCOyKq5w0d4KLMAAMvNIVBGvvOBWToGdloguaOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8wOOvZhKNCfIWk30zMzU/hxK/CCBJAktIL4tI6TKmM=;
 b=Ib3XppYw9u6YpOTr2hJa+o3J5Z9Hg817Nu4/zHcbKHGGMtrh5fQeiQa15vYZaN8jWnbdAvyNG7IsP9jtGYwUTKG1sJZH1d6VLF6rorLHzm0V/3FpbAIFqhLxqhGwZiNfD22pQYD0QuLR6YXtUOKDgb9xCU/29yQH/OlN8d3w7H/H+J7b2md7jUnmdR6BPnalCXIdlSxbHSC+G1lDnrRfJzM662Qx9wQrRsOQosZpnZAwSVzPy+v5eM6gPZsERJHUhK1QPvsag7nzs5Lg86ctxjQWeDCWzdVdl/OWggiTuYFxiykgiKWr/2BB11Aufpe09RCfLxni7xPwzV6oCvzP4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8wOOvZhKNCfIWk30zMzU/hxK/CCBJAktIL4tI6TKmM=;
 b=oYSPy01ErzYqFc9DDzspU1PdF/Ti+OIdE27Nm4MB88ajp/X1yGtIdSYssbkQF7iSS1jLpfMnmvsiE6TEm8cbwCdpj0kIdSGa1ylg/HSC+IjK6vNMDCemNahZMFndugq4mszuAUUVoOSs30w0UovvaFxjJazXvkBMhrnsYyYUSW8=
Received: from CO6PR18MB4500.namprd18.prod.outlook.com (2603:10b6:5:356::24)
 by BN9PR18MB4283.namprd18.prod.outlook.com (2603:10b6:408:11c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.15; Thu, 25 Jan
 2024 10:49:56 +0000
Received: from CO6PR18MB4500.namprd18.prod.outlook.com
 ([fe80::739c:1689:1669:2677]) by CO6PR18MB4500.namprd18.prod.outlook.com
 ([fe80::739c:1689:1669:2677%7]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 10:49:56 +0000
From: Nilesh Javali <njavali@marvell.com>
To: Chris Leech <cleech@redhat.com>
CC: "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "lduncan@suse.com" <lduncan@suse.com>,
        "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>,
        GR-QLogic-Storage-Upstream
	<GR-QLogic-Storage-Upstream@marvell.com>,
        "jmeneghi@redhat.com"
	<jmeneghi@redhat.com>,
        Kaushal Desai <kdesai@marvell.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
Subject: RE: [EXT] Re: [PATCH v3 1/3] uio: introduce UIO_MEM_DMA_COHERENT type
Thread-Topic: [EXT] Re: [PATCH v3 1/3] uio: introduce UIO_MEM_DMA_COHERENT
 type
Thread-Index: AQHaQvWFTDwtAbRnjEOm6HOKHPwhkrDptm+AgAC3DEA=
Date: Thu, 25 Jan 2024 10:49:56 +0000
Message-ID: 
 <CO6PR18MB4500FF2280015A78C0669B7EAF7A2@CO6PR18MB4500.namprd18.prod.outlook.com>
References: <20240109121458.26475-1-njavali@marvell.com>
 <20240109121458.26475-2-njavali@marvell.com>
 <ZbGfB2tqASg5Jiaq@rhel-developer-toolbox-latest>
In-Reply-To: <ZbGfB2tqASg5Jiaq@rhel-developer-toolbox-latest>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: 
 =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbmphdmFsaVxh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLTc4OTc1ZmEzLWJiNmYtMTFlZS05NGIzLWY4NGU1?=
 =?us-ascii?Q?ODllYWQzOVxhbWUtdGVzdFw3ODk3NWZhNC1iYjZmLTExZWUtOTRiMy1mODRl?=
 =?us-ascii?Q?NTg5ZWFkMzlib2R5LnR4dCIgc3o9IjUwNzIiIHQ9IjEzMzUwNjUzMzk0NjM5?=
 =?us-ascii?Q?MTQxOSIgaD0iUDBwNjRGYTFacGhSSkhqbmJrUG1TOFRUUko0PSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQmdXQUFC?=
 =?us-ascii?Q?N2V4RTdmRS9hQVVZS0l2SW1JZ1QyUmdvaThpWWlCUFlaQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUhBQUFBQnVEd0FBM2c4QUFEb0dBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQVFFQkFBQUE5UmVuTHdDQUFRQUFBQUFBQUFBQUFKNEFBQUJoQUdRQVpB?=
 =?us-ascii?Q?QnlBR1VBY3dCekFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHTUFkUUJ6QUhRQWJ3QnRBRjhBY0FC?=
 =?us-ascii?Q?bEFISUFjd0J2QUc0QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFB?=
 =?us-ascii?Q?QUFBQ2VBQUFBWXdCMUFITUFkQUJ2QUcwQVh3QndBR2dBYndCdUFHVUFiZ0Ix?=
 =?us-ascii?Q?QUcwQVlnQmxBSElBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQmpBSFVB?=
 =?us-ascii?Q?Y3dCMEFHOEFiUUJmQUhNQWN3QnVBRjhBWkFCaEFITUFhQUJmQUhZQU1BQXlB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refone: 
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdN?=
 =?us-ascii?Q?QWRRQnpBSFFBYndCdEFGOEFjd0J6QUc0QVh3QnJBR1VBZVFCM0FHOEFjZ0Jr?=
 =?us-ascii?Q?QUhNQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFZd0IxQUhNQWRBQnZBRzBB?=
 =?us-ascii?Q?WHdCekFITUFiZ0JmQUc0QWJ3QmtBR1VBYkFCcEFHMEFhUUIwQUdVQWNnQmZB?=
 =?us-ascii?Q?SFlBTUFBeUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFB?=
 =?us-ascii?Q?QUFJQUFBQUFBSjRBQUFCakFIVUFjd0IwQUc4QWJRQmZBSE1BY3dCdUFGOEFj?=
 =?us-ascii?Q?d0J3QUdFQVl3QmxBRjhBZGdBd0FESUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFB?=
 =?us-ascii?Q?R1FBYkFCd0FGOEFjd0JyQUhrQWNBQmxBRjhBWXdCb0FHRUFkQUJmQUcwQVpR?=
 =?us-ascii?Q?QnpBSE1BWVFCbkFHVUFYd0IyQURBQU1nQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVpBQnNBSEFBWHdCekFH?=
 =?us-ascii?Q?d0FZUUJqQUdzQVh3QmpBR2dBWVFCMEFGOEFiUUJsQUhNQWN3QmhBR2NBWlFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo: 
 =?us-ascii?Q?QUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJrQUd3QWNBQmZB?=
 =?us-ascii?Q?SFFBWlFCaEFHMEFjd0JmQUc4QWJnQmxBR1FBY2dCcEFIWUFaUUJmQUdZQWFR?=
 =?us-ascii?Q?QnNBR1VBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFB?=
 =?us-ascii?Q?QUFBQUFBQUFnQUFBQUFBbmdBQUFHVUFiUUJoQUdrQWJBQmZBR0VBWkFCa0FI?=
 =?us-ascii?Q?SUFaUUJ6QUhNQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFCZ0FBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFB?=
 =?us-ascii?Q?Q2VBQUFBYlFCaEFISUFkZ0JsQUd3QVh3QndBSElBYndCcUFHVUFZd0IwQUY4?=
 =?us-ascii?Q?QWJnQmhBRzBBWlFCekFGOEFZd0J2QUc0QVpnQnBBR1FBWlFCdUFIUUFhUUJo?=
 =?us-ascii?Q?QUd3QVh3QmhBR3dBYndCdUFHVUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQnRBR0VBY2dC?=
 =?us-ascii?Q?MkFHVUFiQUJmQUhBQWNnQnZBR29BWlFCakFIUUFYd0J1QUdFQWJRQmxBSE1B?=
 =?us-ascii?Q?WHdCeUFHVUFjd0IwQUhJQWFRQmpBSFFBWlFCa0FGOEFZUUJzQUc4QWJnQmxB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUcwQVlRQnlBSFlBWlFCc0FGOEFjQUJ5?=
 =?us-ascii?Q?QUc4QWFnQmxBR01BZEFCZkFHNEFZUUJ0QUdVQWN3QmZBSElBWlFCekFIUUFj?=
 =?us-ascii?Q?Z0JwQUdNQWRBQmxBR1FBWHdCb0FHVUFlQUJqQUc4QVpBQmxBSE1BQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFHRUFjZ0J0QUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refthree: 
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJ?=
 =?us-ascii?Q?QUFBQUFBSjRBQUFCdEFHRUFjZ0IyQUdVQWJBQnNBRjhBWndCdkFHOEFad0Jz?=
 =?us-ascii?Q?QUdVQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBRzBB?=
 =?us-ascii?Q?WVFCeUFIWUFaUUJzQUd3QVh3QndBSElBYndCcUFHVUFZd0IwQUY4QVl3QnZB?=
 =?us-ascii?Q?R1FBWlFCekFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQWJRQmhBSElBZGdCbEFHd0Fi?=
 =?us-ascii?Q?QUJmQUhBQWNnQnZBR29BWlFCakFIUUFYd0JqQUc4QVpBQmxBSE1BWHdCa0FH?=
 =?us-ascii?Q?a0FZd0IwQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFB?=
 =?us-ascii?Q?QUlBQUFBQUFKNEFBQUJ0QUdFQWNnQjJBR1VBYkFCc0FGOEFjQUJ5QUc4QWFn?=
 =?us-ascii?Q?QmxBR01BZEFCZkFHNEFZUUJ0QUdVQWN3QmZBR01BYndCdUFHWUFhUUJrQUdV?=
 =?us-ascii?Q?QWJnQjBBR2tBWVFCc0FGOEFiUUJoQUhJQWRnQmxBR3dBYkFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFH?=
 =?us-ascii?Q?MEFZUUJ5QUhZQVpRQnNBR3dBWHdCd0FISUFid0JxQUdVQVl3QjBBRjhBYmdC?=
 =?us-ascii?Q?aEFHMEFaUUJ6QUY4QVl3QnZBRzRBWmdCcEFHUUFaUUJ1QUhRQWFRQmhBR3dB?=
 =?us-ascii?Q?WHdCdEFHRUFjZ0IyQUdVQWJBQnNBRjhBYndCeUFGOEFZUUJ5QUcwQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reffour: 
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VB?=
 =?us-ascii?Q?QUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBSEFBY2dCdkFHb0FaUUJqQUhRQVh3?=
 =?us-ascii?Q?QnVBR0VBYlFCbEFITUFYd0JqQUc4QWJnQm1BR2tBWkFCbEFHNEFkQUJwQUdF?=
 =?us-ascii?Q?QWJBQmZBRzBBWVFCeUFIWUFaUUJzQUd3QVh3QnZBSElBWHdCbkFHOEFid0Ju?=
 =?us-ascii?Q?QUd3QVpRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQnRBR0VBY2dCMkFH?=
 =?us-ascii?Q?VUFiQUJzQUY4QWNBQnlBRzhBYWdCbEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dC?=
 =?us-ascii?Q?ZkFISUFaUUJ6QUhRQWNnQnBBR01BZEFCbEFHUUFYd0J0QUdFQWNnQjJBR1VB?=
 =?us-ascii?Q?YkFCc0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFB?=
 =?us-ascii?Q?QUFBQUFBQWdBQUFBQUFuZ0FBQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J3QUhJ?=
 =?us-ascii?Q?QWJ3QnFBR1VBWXdCMEFGOEFiZ0JoQUcwQVpRQnpBRjhBY2dCbEFITUFkQUJ5?=
 =?us-ascii?Q?QUdrQVl3QjBBR1VBWkFCZkFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdCdkFISUFY?=
 =?us-ascii?Q?d0JoQUhJQWJRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFD?=
 =?us-ascii?Q?ZUFBQUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFIUUFaUUJ5QUcwQWFRQnVBSFVB?=
 =?us-ascii?Q?Y3dBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCdEFHRUFjZ0Iy?=
 =?us-ascii?Q?QUdVQWJBQnNBRjhBZHdCdkFISUFaQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFBQUFBQUVB?=
 =?us-ascii?Q?QUFBQUFBQUFBZ0FBQUFBQU9nWUFBQUFBQUFBSUFBQUFBQUFBQUFnQUFBQUFB?=
 =?us-ascii?Q?QUFBQ0FBQUFBQUFBQUFhQmdBQUdRQUFBQmdB?=
x-dg-reffive: 
 =?us-ascii?Q?QUFBQkFBQUFZUUJrQUdRQWNnQmxBSE1BY3dBQUFDUUFBQUFCQUFBQVl3QjFB?=
 =?us-ascii?Q?SE1BZEFCdkFHMEFYd0J3QUdVQWNnQnpBRzhBYmdBQUFDNEFBQUFBQUFBQVl3?=
 =?us-ascii?Q?QjFBSE1BZEFCdkFHMEFYd0J3QUdnQWJ3QnVBR1VBYmdCMUFHMEFZZ0JsQUhJ?=
 =?us-ascii?Q?QUFBQXdBQUFBQUFBQUFHTUFkUUJ6QUhRQWJ3QnRBRjhBY3dCekFHNEFYd0Jr?=
 =?us-ascii?Q?QUdFQWN3Qm9BRjhBZGdBd0FESUFBQUF3QUFBQUFBQUFBR01BZFFCekFIUUFi?=
 =?us-ascii?Q?d0J0QUY4QWN3QnpBRzRBWHdCckFHVUFlUUIzQUc4QWNnQmtBSE1BQUFBK0FB?=
 =?us-ascii?Q?QUFBQUFBQUdNQWRRQnpBSFFBYndCdEFGOEFjd0J6QUc0QVh3QnVBRzhBWkFC?=
 =?us-ascii?Q?bEFHd0FhUUJ0QUdrQWRBQmxBSElBWHdCMkFEQUFNZ0FBQURJQUFBQUFBQUFB?=
 =?us-ascii?Q?WXdCMUFITUFkQUJ2QUcwQVh3QnpBSE1BYmdCZkFITUFjQUJoQUdNQVpRQmZB?=
 =?us-ascii?Q?SFlBTUFBeUFBQUFQZ0FBQUFBQUFBQmtBR3dBY0FCZkFITUFhd0I1QUhBQVpR?=
 =?us-ascii?Q?QmZBR01BYUFCaEFIUUFYd0J0QUdVQWN3QnpBR0VBWndCbEFGOEFkZ0F3QURJ?=
 =?us-ascii?Q?QUFBQTJBQUFBQUFBQUFHUUFiQUJ3QUY4QWN3QnNBR0VBWXdCckFGOEFZd0Jv?=
 =?us-ascii?Q?QUdFQWRBQmZBRzBBWlFCekFITUFZUUJuQUdVQUFBQTRBQUFBQUFBQUFHUUFi?=
 =?us-ascii?Q?QUJ3QUY4QWRBQmxBR0VBYlFCekFGOEFid0J1QUdVQVpBQnlBR2tBZGdCbEFG?=
 =?us-ascii?Q?OEFaZ0JwQUd3QVpRQUFBQ1FBQUFBR0FBQUFaUUJ0QUdFQWFRQnNBRjhBWVFC?=
 =?us-ascii?Q?a0FHUUFjZ0JsQUhNQWN3QUFBRmdBQUFBQUFBQUFiUUJoQUhJQWRnQmxBR3dB?=
 =?us-ascii?Q?WHdCd0FISUFid0JxQUdVQVl3QjBBRjhBYmdCaEFHMEFaUUJ6QUY4QVl3QnZB?=
 =?us-ascii?Q?RzRBWmdCcEFHUUFaUUJ1QUhRQWFRQmhBR3dBWHdCaEFHd0Fid0J1QUdVQUFB?=
 =?us-ascii?Q?QlVBQUFBQUFBQUFHMEFZUUJ5QUhZQVpRQnNBRjhBY0FCeUFHOEFhZ0JsQUdN?=
 =?us-ascii?Q?QWRBQmZBRzRBWVFCdEFHVUFjd0JmQUhJQVpRQnpBSFFBY2dCcEFHTUFkQUJs?=
 =?us-ascii?Q?QUdRQVh3QmhBR3dBYndCdUFHVUFBQUJhQUFBQUFBQUFBRzBBWVFCeUFIWUFa?=
 =?us-ascii?Q?UUJzQUY4QWNBQnlBRzhBYWdCbEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFI?=
 =?us-ascii?Q?SUFaUUJ6QUhRQWNnQnBBR01BZEFCbEFHUUFYd0JvQUdVQWVBQmpBRzhBWkFC?=
 =?us-ascii?Q?bEFITUFBQUFnQUFBQUFBQUFBRzBBWVFCeUFIWUFaUUJzQUd3QVh3QmhBSElB?=
 =?us-ascii?Q?YlFBQUFDWUFBQUFBQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUdjQWJ3QnZB?=
 =?us-ascii?Q?R2NBYkFCbEFBQUFOQUFBQUFBQUFBQnRBR0VB?=
x-dg-refsix: 
 =?us-ascii?Q?Y2dCMkFHVUFiQUJzQUY4QWNBQnlBRzhBYWdCbEFHTUFkQUJmQUdNQWJ3QmtB?=
 =?us-ascii?Q?R1VBY3dBQUFENEFBQUFBQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUhBQWNn?=
 =?us-ascii?Q?QnZBR29BWlFCakFIUUFYd0JqQUc4QVpBQmxBSE1BWHdCa0FHa0FZd0IwQUFB?=
 =?us-ascii?Q?QVhnQUFBQUFBQUFCdEFHRUFjZ0IyQUdVQWJBQnNBRjhBY0FCeUFHOEFhZ0Js?=
 =?us-ascii?Q?QUdNQWRBQmZBRzRBWVFCdEFHVUFjd0JmQUdNQWJ3QnVBR1lBYVFCa0FHVUFi?=
 =?us-ascii?Q?Z0IwQUdrQVlRQnNBRjhBYlFCaEFISUFkZ0JsQUd3QWJBQUFBR3dBQUFBQUFB?=
 =?us-ascii?Q?QUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFIQUFjZ0J2QUdvQVpRQmpBSFFBWHdC?=
 =?us-ascii?Q?dUFHRUFiUUJsQUhNQVh3QmpBRzhBYmdCbUFHa0FaQUJsQUc0QWRBQnBBR0VB?=
 =?us-ascii?Q?YkFCZkFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdCdkFISUFYd0JoQUhJQWJRQUFB?=
 =?us-ascii?Q?SElBQUFBQUFBQUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFIQUFjZ0J2QUdvQVpR?=
 =?us-ascii?Q?QmpBSFFBWHdCdUFHRUFiUUJsQUhNQVh3QmpBRzhBYmdCbUFHa0FaQUJsQUc0?=
 =?us-ascii?Q?QWRBQnBBR0VBYkFCZkFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdCdkFISUFYd0Ju?=
 =?us-ascii?Q?QUc4QWJ3Qm5BR3dBWlFBQUFGb0FBQUFBQUFBQWJRQmhBSElBZGdCbEFHd0Fi?=
 =?us-ascii?Q?QUJmQUhBQWNnQnZBR29BWlFCakFIUUFYd0J1QUdFQWJRQmxBSE1BWHdCeUFH?=
 =?us-ascii?Q?VUFjd0IwQUhJQWFRQmpBSFFBWlFCa0FGOEFiUUJoQUhJQWRnQmxBR3dBYkFB?=
 =?us-ascii?Q?QUFHZ0FBQUFBQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUhBQWNnQnZBR29B?=
 =?us-ascii?Q?WlFCakFIUUFYd0J1QUdFQWJRQmxBSE1BWHdCeUFHVUFjd0IwQUhJQWFRQmpB?=
 =?us-ascii?Q?SFFBWlFCa0FGOEFiUUJoQUhJQWRnQmxBR3dBYkFCZkFHOEFjZ0JmQUdFQWNn?=
 =?us-ascii?Q?QnRBQUFBS2dBQUFBQUFBQUJ0QUdFQWNnQjJBR1VBYkFCc0FGOEFkQUJsQUhJ?=
 =?us-ascii?Q?QWJRQnBBRzRBZFFCekFBQUFJZ0FBQUFFQUFBQnRBR0VBY2dCMkFHVUFiQUJz?=
 =?us-ascii?Q?QUY4QWR3QnZBSElBWkFBQUFBPT0iLz48L21ldGE+?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4500:EE_|BN9PR18MB4283:EE_
x-ms-office365-filtering-correlation-id: 25d3dd44-fbc7-4e18-7830-08dc1d935ed5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Hb7De6DjxNWDVsv/1WwaSqhGocSBAzj3ZWab8jXnAspp4OC2ejhUQgHaR/xt239z/rnU4HGB/Ju45ZzoBE8JWzfl/TffZelMndww0iZFiYMdempArm9bW4FIxYvDzb8yvAcgXLB2GTK8f0YgFzWZZcOY3hp09kG7r6PLY2tNUu7mNltvMx03tBH72bv2K4r7lb3dG63txckySRWghnvRl91O0lZrKk3Okp8uV+K3x4bh/6r8qjxx2kobJXQ9hkSl/7BQ6exdwzwggKJD2HqnattCxwg8dRNATxNX9tsOjsU9fCkFQb6GO5dAdpXRrXadHn1D5wPOk5AAzOi85jVKsjCpWjuRewJ0EQlSk9MeMxc2a0pibNT6u8tkE1N1m8m9NN1RZ1Yyg5SHHOfePl9v7TJuPwGaper9l5rCNqZlkQuR/NUo9Cx8INVbp3HN0zVJ3f6ULBL8DD5XLsQzZVCB6isMV4OyOigRoPDvDLMke7ROW6riI09E/4/xerTKcP1l8y9fD/5U6L7YvJeduaVd08fAcnqVY20nBiWXvjz4XtuJt3PlkQXn8wN/LX6wPR0hxVbmSPI/iFIXmrJh8Nfwgqrg/9uRIRmcBlM9wcmmmJzr4yoVfiRdQsYC9Be8gWUeKHkCi5JwTEIXgaadqCmmNvLniHXPFks2Vow2eUxb8TE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4500.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(39860400002)(376002)(366004)(230922051799003)(230273577357003)(230173577357003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(53546011)(38100700002)(71200400001)(26005)(122000001)(9686003)(8676002)(4326008)(5660300002)(8936002)(52536014)(41300700001)(2906002)(6506007)(478600001)(7696005)(6916009)(66446008)(66476007)(66556008)(64756008)(54906003)(66946007)(316002)(76116006)(33656002)(86362001)(38070700009)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?liApAbJnvzznMsoUz9e3BjoKt00zZZId28ot3R7qWZWB+7hWjQTsL7+GRU0y?=
 =?us-ascii?Q?0vqGsPPaM/CUztCuWgeSmgHMPSm+49aaTeqUwS7XeUCEleDCKysf+OjLKPif?=
 =?us-ascii?Q?b+D6l4Ss2yBnjFIpmA7r1PtNb6kw81F8skd5TZhFBgKTnqQrwNK6z24jxY8k?=
 =?us-ascii?Q?Ir6kce3xI1JyaWvou+Ip9K2pmsH2AiefNtb5hzyzjPg79LuwNnBQvNRcOsU3?=
 =?us-ascii?Q?iGx9ovPHOXVfHMunMQTpsVrwbgqDXk+EeadKpBChPnXPujhYXHg5bwmNETzz?=
 =?us-ascii?Q?m7cJlvWX5PjvJ8CZKvZplB0pN+zTOanZFG+hzvuwxeQuXIkStUgrMBgG+bLw?=
 =?us-ascii?Q?czI7Kll7m7IL+MK3ECUG+3j6eREXNzilULeWDBip9G5wDWfoRThZ4e4HcDap?=
 =?us-ascii?Q?OZz3p1/JqOPyVmcy0+ilKWEqe00KzKeXI25UaRUIO2pAYrwqanKxExaQ7/va?=
 =?us-ascii?Q?mQOEvSCvy7r9h1b2BhklSWmg1yKU47Igpx9mLZRRLg37K5//6vCQfuDla5LL?=
 =?us-ascii?Q?HukQJ0nCPyDUJ1KZTtW3fUYimm0mSVXVydfptB6ppH3wozoKDPf3L9JCRsSO?=
 =?us-ascii?Q?fyG+zI/dZxMysGjVb4b4VP+OxZC68o5Iz8ptILmLRzz+vlGe8mNoN/pzj2gw?=
 =?us-ascii?Q?lvplEifERHm4zpko7dxGWD7fV2GNmnaAXDXWqUOEEhJbAAINA2iq9wfwXON/?=
 =?us-ascii?Q?6DXGZ6osg6SJRy8va6aGUD81mUakW6iSJBxqRiQq++RZERCNBdsM0NPyDeiC?=
 =?us-ascii?Q?hIX7OFRhJsTL2m/i/NRdinE0/5RA1N4JjXcUALXW2qiCkGjn85TD4PI387b3?=
 =?us-ascii?Q?34bfH8DHPE3BAJwqLnlxgDBugZ/jSrRPQc0/EmPv3bjOTLRnIZizH0YeA9IF?=
 =?us-ascii?Q?TIyr3OYHeMje6tvlRRS8bcIWdonXzJEN5Ep/mdkWlsvyiXVWBze9+ufw4DtJ?=
 =?us-ascii?Q?L4jzWXmpLFXxP/zz2lJKcyzA0zC3Ons79HzxjppWLRYRxmDHv9rNs0gF/S9y?=
 =?us-ascii?Q?mbmmBCkInkzFnKMkCYqdSKlq5kFfjP0HTfRvUlg2PgNfb5NzkpTvf7lOMJiQ?=
 =?us-ascii?Q?DGZ/yNaz62tmUlGNc5QgaOrYhRzJaNrSkXs4L7RsTq7JrHqTwE2iEPyCPMhY?=
 =?us-ascii?Q?DJ4DZb6Jrd8G5C5eUZF01CnLV7/ExWeu6Uih11R8CcoGvSjG7oINQ0uPhHX1?=
 =?us-ascii?Q?3gcrEilyjClD7W/r7zOeINiLJfqddKusQKVty8JnE5MwHVGcpoawIO+sQYMn?=
 =?us-ascii?Q?r+pCa4v2XUsG8CiRs9GcnLoVfB3pdfY+QsIj37AQvVrD7qKp6KuOXsn1XP22?=
 =?us-ascii?Q?mZl9WD9Cz+30IUSA2gLyQD7DCN//U8A2ASlBc7uuq3ZzaLoJ1HjHcc+q4Qzi?=
 =?us-ascii?Q?RP83yCoQfvG78Bu6Hp9cyRqKWFD6CpKsMb2roFALStGGQJvCDPsbQCKt1slD?=
 =?us-ascii?Q?Ccsvk6cEthai/Hv6T6Ryayvfus/zCqmTc3EiRqR0vbRtIZ/oIvPtQj2OWbnQ?=
 =?us-ascii?Q?9nI7YzpztlA6S/b22mltjJzMb1MIzygY2xEBGszDmTH1c7J2YS+WiONy1nk3?=
 =?us-ascii?Q?dwIw8S4IEob2p+WhytBaAuWHAWCoWXRzuaeOCKBF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4500.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d3dd44-fbc7-4e18-7830-08dc1d935ed5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2024 10:49:56.7632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CFVUeLjtNGjxGFaYZQjxjtTkXjtvaP4GDE8OXEImKmcS9kroylgjRxVKu+i2LprhIDnIY52VHKxYqplar9x3hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR18MB4283
X-Proofpoint-ORIG-GUID: zQv4a80-YROnrGVVE6D-TvM013xbrRSF
X-Proofpoint-GUID: qZe_zoJiiXAJs8DGifcIEAiljWTPUGpi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_06,2024-01-25_01,2023-05-22_02

Chris,

> -----Original Message-----
> From: Chris Leech <cleech@redhat.com>
> Sent: Thursday, January 25, 2024 5:07 AM
> To: Nilesh Javali <njavali@marvell.com>
> Cc: martin.petersen@oracle.com; lduncan@suse.com; linux-
> scsi@vger.kernel.org; GR-QLogic-Storage-Upstream <GR-QLogic-Storage-
> Upstream@marvell.com>; jmeneghi@redhat.com
> Subject: [EXT] Re: [PATCH v3 1/3] uio: introduce UIO_MEM_DMA_COHERENT
> type
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> Nilesh,
>=20
> On Tue, Jan 09, 2024 at 05:44:56PM +0530, Nilesh Javali wrote:
> > +	ret =3D dma_mmap_coherent(&idev->dev,
> > +				vma,
> > +				addr,
> > +				mem->dma_addr,
> > +				vma->vm_end - vma->vm_start);
>=20
> When I asked about the use of idev->dev here in the v2 posting, you
> repled as follows.
>=20
> > While the cnic loads, it registers the cnic_uio_dev->pdev->dev with
> > uio and the uio attaches its device to cnic device as it's parent. So
> > uio and cnic are attached to the same PCI device.
>=20
> I still don't think the sysfs parent relationship is enough to get the
> correct behavior out of the DMA APIs on all platforms, and
> dma_mmap_coherent needs to be using the same device struct as
> dma_alloc_coherent.
>=20
> I had some testing done on an AMD system, where your v2 patch set was
> failing with the iommu enabled, and my original changes were reported to
> work.  And I believe these v3 patches are functionally the same.

We have extensively verified this patch set with IOMMU enabled and see
no regression when VT and SRIOV are enabled. However issues are observed
only when VT, VT-D and SRIOV are enabled in the HW BIOS.
In the failure case, with VT-D enabled, we observe the OS fails to boot wit=
h
DMAR timeout error.

"  **] A start job is running for Network Manager (2min 6s / no limit)
[ 147.069016] DMAR: VT-d detected Invalidation Time-out Error: SID 0
[ 147.069016] DMAR: DRHD: handling fault status reg 40
[ 147.080924] DMAR: QI HEAD: Device-TLB Invalidation qw0 =3D 0xaf0300100003=
, qw1 =3D 0x7ffffffffffff001
[ 147.090207] DMAR: QI PRIOR: Invalidation Wait qw0 =3D 0x200000025, qw1 =
=3D 0x10005f634".

With your proposed changes, please confirm if you see no issues with VT-D e=
nabled on Intel/AMD platform.

Also based on our observation the issue with VT-D enabled is not related to=
 the current patch set under test.

Thanks,
Nilesh


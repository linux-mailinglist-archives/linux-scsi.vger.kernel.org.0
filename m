Return-Path: <linux-scsi+bounces-5750-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 050939080CD
	for <lists+linux-scsi@lfdr.de>; Fri, 14 Jun 2024 03:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93735283EEE
	for <lists+linux-scsi@lfdr.de>; Fri, 14 Jun 2024 01:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC56183083;
	Fri, 14 Jun 2024 01:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RWUA2iwy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dGkD3PhZ"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E30718306F;
	Fri, 14 Jun 2024 01:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718329273; cv=fail; b=C7zgNOG0pASaRG4it1mRe0Fqtci6PVIhrYjk3mkCh41zhGVMT34t80WtI6GQLqmxrDV/ivziECUJJTpiI+DiVwyST9IZUR0fUcug4RpWkuDCN2N3Om4qUgCN2m1Nj8b2D3p4eE0GvNqIzjFLJwwlmI195Ie55TS9/WROzQXmpwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718329273; c=relaxed/simple;
	bh=VSbxKqxfFiT85w9qYHqFcGzLOH4TMMURNRlcoMjfhHA=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=HMq2tQQIqayIkZzM86QmLAl6P6LhFR/2O3myIbjupyO7I8ev3hd7da7mRgT7yVfJmPyedlVcfQEhPjFdN3VeZeHZ7HZ+rMlU+01B0ldaBB2R305/uN2cuGfC7KKJem2t956riFY5Li2FpsYgjQKy7kpJTnQZ22oRZ8JvfUfPwhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RWUA2iwy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dGkD3PhZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45E1Nn6l029010;
	Fri, 14 Jun 2024 01:40:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to
	:cc:subject:from:in-reply-to:message-id:references:date
	:content-type:mime-version; s=corp-2023-11-20; bh=cdpb33YGoTEW2L
	kfrQ++Ln+DMyW5J1BVoHL3IH4GnVc=; b=RWUA2iwyHFf90pk5+sY6dbXDN3pnPt
	tcDujhYJyf2/vwUDob3rW//I4tyzfmHoAWnxmM4OIsiPLFIepBhOysQIT5KRyDA7
	k0dQePA9k6D+ErhGLl+gBiKLtWAVF9IzeAlpIHLdxwdvxiwJ4mDPg51OzvrHaYVH
	/NczqtQjIm5BFggOXcTe6aVx8wDkHznyzXdcWscE/iY5PW5MFSQD7pvp1wuFuGuy
	x2SWmjVV4ONBodm2VB6sNEy66RDJ8/VlvT8QZPNcDKdrcywZfzMU8TidPIPW+h/o
	ayED7UWajU8EyrHc1B6T30N4Tx7GaTG7e3nJ7qnOHX9U+q3/iJ1VPHsQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh7dts7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 01:40:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45E1PiWv020108;
	Fri, 14 Jun 2024 01:40:34 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ync91yn1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 01:40:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrreEC16uiTGQVotfJQjQGPKxbRNEA1++DqOzclNRPyaRv9LVJtUND43YY06As2fXeSSuOMrUZ0g/1hovByNND+XSWMvv3V6ZtnqHpnaZzIgS0TYrPH2PPfVCAj7lCjb9glxzzHr5INwQIjzg8S4hMES480XmwDACdfQUBmg9U1GPi8FRWVD+N4D+7CzBdlbjbVoaIZUDU3O28dB0iw59xYWc2/e19IAsvlgtBuzfx8/YeI3zb9S5yKaf1B4GkbgocuXXwbajS4MTYDxN90Y0jtuI71XrwCwFt2g9Av/mmoFXJjvVqcyaDpfKX5X4QBENXxNWc+t7R6tULzcWQ/wqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdpb33YGoTEW2LkfrQ++Ln+DMyW5J1BVoHL3IH4GnVc=;
 b=GfE3hoy/1rynPLd8G+/Nw8upzelhJ0HPa4wg/aj+WrwrZ1ZivvV0C3Xp7zDtAKMgb/Mt2zL1S541TD+oBU+Kl5iWtHhtD57X0H/v9tis4m4rrCdaEikYxBO/MFC7MEeMCneBHKzOC/FaQdrHiulkMA1ER5ndmIh9dQkU+qIXsKe8Wl9qs4TbAhiJpyYMs8+Wmc0obad8QXfkqLUsPbLoexb2fQQuQGIsr9Tik0rx4g+JI3g+NVlCdbCbg21zttVCu9vkcqO2pZpkIws0DZQ5BfAqAYIaZHp+aEIFoblOhyUKk9cS5rAr47bJ1uTeh2yYeSpKbrwFtQox+PvBewDq3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdpb33YGoTEW2LkfrQ++Ln+DMyW5J1BVoHL3IH4GnVc=;
 b=dGkD3PhZ+boz2qVxHXGoBDXdJNx0oYeV4n2bv9JyPydtnTZQHfGmt92Dubx3QtfV+PdICBzyy1/m1uYoSGJbb4OeU1obi/+50IBg3olYqprwgelub7r+cHIx6aSA/V+mNZuhK/REyGgpY0jSUS8heCJVGSwnLN+mS3+A1r2702M=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB5755.namprd10.prod.outlook.com (2603:10b6:510:149::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Fri, 14 Jun
 2024 01:40:30 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7%4]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 01:40:29 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen"
 <martin.petersen@oracle.com>,
        Richard Weinberger <richard@nod.at>,
        Anton
 Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg
 <johannes@sipsolutions.net>,
        Josef Bacik <josef@toxicpanda.com>, Ilya
 Dryomov <idryomov@gmail.com>,
        Dongsheng Yang
 <dongsheng.yang@easystack.cn>,
        Roger Pau =?utf-8?Q?Monn=C3=A9?=
 <roger.pau@citrix.com>,
        linux-um@lists.infradead.org, linux-block@vger.kernel.org,
        nbd@other.debian.org, ceph-devel@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org,
        Bart Van
 Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 04/14] block: take io_opt and io_min into account for
 max_sectors
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240531074837.1648501-5-hch@lst.de> (Christoph Hellwig's
	message of "Fri, 31 May 2024 09:47:59 +0200")
Organization: Oracle Corporation
Message-ID: <yq1frtgti7y.fsf@ca-mkp.ca.oracle.com>
References: <20240531074837.1648501-1-hch@lst.de>
	<20240531074837.1648501-5-hch@lst.de>
Date: Thu, 13 Jun 2024 21:40:27 -0400
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0055.namprd08.prod.outlook.com
 (2603:10b6:a03:117::32) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH0PR10MB5755:EE_
X-MS-Office365-Filtering-Correlation-Id: bfd42842-d075-4403-2b5f-08dc8c12f931
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|7416009|376009;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?U94yYsVBZh7eSvjyTZ8nV2PakJWOZD5IsSFdoSS9v3qh+1vLJ3f3Xc+Ri5XB?=
 =?us-ascii?Q?5/6Hu4YRLkGtjGz1Ble0oNhx1zye1PAZ23ViHWc+YVw43kwz9I3vLO5ok+Ng?=
 =?us-ascii?Q?oo+3S8CCNQONsC6QREQ5vO9lGChJwpzhZkYJ8IJBWCHNqxtfFXVvYq40292+?=
 =?us-ascii?Q?Ys0PhDVwpSymnKk1jFzHEWdkSk9igfOmBwWBcVbYkfopHQNLQo8l/FjliKXz?=
 =?us-ascii?Q?ehnm9+zUM/gT096Ec7l2lRzBUWakjMLQhd5JPcxsIoidPisiHpIW0sjzy0Nn?=
 =?us-ascii?Q?O+9DzHnPuhtueSBNsWDtZDelmxpgN8vk5Sd9jGNZvLQW/Iap2XCQ5LTavjN7?=
 =?us-ascii?Q?ihmc66it32PMdbnsx37eGvzLNsY2ZIhGXmMpEe9ZojC4fJWU4RwaZy9Nm386?=
 =?us-ascii?Q?pmhhYf7OqOfvhl9jg24m0Qp/2+nWysbLA0nCNn7TalblK1ftP1CNQSE9v9yr?=
 =?us-ascii?Q?kZhDNsWdEWKOk2NopBxMiPFWVYUqmhlKzYw7Jqxm2i9civYlttL6RIJ7opdC?=
 =?us-ascii?Q?XKspDrzuCiPDIyeasVjPl/qTpPhyL+Q1+3Zj5ydy8Qnck6dkkptqKVvwPCaC?=
 =?us-ascii?Q?3bDwOkXBsnj2OIryCaKUAEhm2XIt62YrmPp/pD1GfYRX9qI0WZqMG8OzeC5o?=
 =?us-ascii?Q?8HIRlXL/XP0yu6ingJa2Sw/5pz9LKW7ybA3tU4bt0kso1yakEziSns3RITmL?=
 =?us-ascii?Q?MDQ0a4jXOxWAohEs8Qp3/PKTL1eeom8a0yiMdGXHYoxyI1CqyLaOeOew7VpU?=
 =?us-ascii?Q?58NLP0Uxbsf82Xfe91b/n534yAb5uKK9tHOSzB6eYxalT/7iVz2aotthP3KZ?=
 =?us-ascii?Q?3CzxtfeqE+RQlwrNzy7dpFxPS/KnsRiEQn3YFKWsnH6TYtm3yCmnLuxu3ebQ?=
 =?us-ascii?Q?4yna3YFbb6z59yFT0HIHvJTDfn7OFQcyrge7gfdQ7MhzuDjWGflYT9Fsq7U9?=
 =?us-ascii?Q?ZD/NajYpO+jU4miRZRAEcSbtVC+ylilE19UQsGNii7HW420zAJVWRZfbuIju?=
 =?us-ascii?Q?f9WNJ5H4KaUUh83j4+3TEX/AY8cD3zcN0eYcVXlWe1MZk612CsKboWYpgErB?=
 =?us-ascii?Q?Ps5A166dAKGtOXce3Z17eEyPqHDcbCnE79J0bW6NX4c6MtdBV/bitLgcxafX?=
 =?us-ascii?Q?QqqR1mbeYUA1LSo759pIOJ5hhPpZ7XUFCc6NZTjIvYc1n+WFuZjg0h4C9VY2?=
 =?us-ascii?Q?tT63mkPYjoD3k9J5ycQCeJKu7OsJoSYPZlq/HlNNqZ+X9D2yTTmkzYOWunOi?=
 =?us-ascii?Q?3KY58KieN1wwodrtM9fMI70eU9D+6OLgX82C+6ua3zkwbUswlu66v/mGn7FZ?=
 =?us-ascii?Q?Ov0S7IFcnzJX+CzBftLTnjaQ?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(7416009)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?B739H1GS1MAdn5dFR6h7xhHSM78J4mWTklMcJI+lPDAczi1RgMx18WSrlPeJ?=
 =?us-ascii?Q?ceADOqfTj4HLvvwdV0Xy2uatDZSQX+NybsxYaWQ+Oy3bqYDT+yh0Nn25Fuql?=
 =?us-ascii?Q?2ER0lw2Xw7ZSxhrEw02ruAogXb40drMQXw0l8uXJ6BL7IHRri6HkHqy7Bd62?=
 =?us-ascii?Q?v8ebYedzUuuf2xLR5tPxBqS0FZpANXRE42GY8mDAFacEdx9IZlbLDsLLwwMK?=
 =?us-ascii?Q?S6eqybSpchkDh77BB6JaoQUZOJHnkr5vQs+3Jx2vQSfB6oyTrKN6iT82Rrtg?=
 =?us-ascii?Q?HeE6DB6WwZ/1LGDsjEmr/xE5e0rgndPDdEnIc0ydGPM5Rh0mlWMK7RC1ESt9?=
 =?us-ascii?Q?Xc/h1VmzC3tLkxliXhSZOCOOjRWENf9g+U2TlcI7D86LC2YKYGaTh+FKNeDp?=
 =?us-ascii?Q?64iCNU/16UAxw0h3blS4u9mXfxknY7DEkf8/yjn/COUm0ewds4ULraCcIiCW?=
 =?us-ascii?Q?pXdbkY1ggdDtexrSO6e45pv+LjrtatBmzxQsw0W2yeiCv/9rNvNN+BIPJFLs?=
 =?us-ascii?Q?tc6/9VgOefxQ1p+czD1He5yZQ8+qnwaoW8ltErmJvJasOoGB9iAgYcUMN3Mj?=
 =?us-ascii?Q?HKCUi467YP7KS1aX0RDj1LSU4Xr0eKTqmY2pSX16p+d0lrFfBSZlteMYra6t?=
 =?us-ascii?Q?+d3hxGXT2LQKpOEZHtwDn6pWh/UzWFigezlUmU+E1po9xLWK00nqeIQ1xxf1?=
 =?us-ascii?Q?AN0S9TcsI1odoMHMcddLAOy8XNDyZk4dSmmROMUWFU+ciiGH4rOyQeaxRsx9?=
 =?us-ascii?Q?mroy9bK89SCQhQ8tSubiyHzuGAvuHycKi9A4+v5pqOt6M4ePG5vXHuhLneqM?=
 =?us-ascii?Q?wfcVnHlby5Hg52kszAJ9W8mAkEs4cM7eekYqfIq0ePjX88a8pejNEVbSk3h9?=
 =?us-ascii?Q?yEg/7pX1WhCh9mt2iCuREpSVMXKrkljt7YxvSTAZa5/knksfAKgVZbbrzQZz?=
 =?us-ascii?Q?y7Ev/dzQ/Gg8EuYC/aiefbiRpC57HVcgYRBOtZSlCpQf3Lav7QDHpZpxdTLP?=
 =?us-ascii?Q?oBC3/5cvdPXdw017PWMB7i7GIDthFEnhV8rWhwlzebjbL1MOEVJOKnA36/6M?=
 =?us-ascii?Q?rEqOjgSndKnKvv4C7vzy2yStul2xf6dboiZjyPjTgv5SCN1xZoH6pW71Pr2X?=
 =?us-ascii?Q?n+40hEs02Tpwdw32vKLnpiwSdfgWDMbxNVgkl9U3d1gD+CVApAntQEPpoITh?=
 =?us-ascii?Q?XScNsWzUAOachSnvxc8Fm195nVzUOWmfR0VkQCTlr4OrZAbPaj8BIRUwnuKY?=
 =?us-ascii?Q?bZW+qu1/g5/6fubUMDdBcwhoj3NZ7+KrkQmPa3BEWT29lT2pV5daG80LeId9?=
 =?us-ascii?Q?jNRLo60rfWY5GcIYj2qATbx3BI1dYIXp3IrJYyb3FaGj/lPp5NIZHLT+iK4t?=
 =?us-ascii?Q?DVAFmDwiuZ+0b+XwwobS/AJgVtxFmrLll7CZ7l70rAKYHqfv2pJRrnFCBMEb?=
 =?us-ascii?Q?J3S2Iz9PpV6WAkH/FjH8gGWz3/VB6CWJZUDJsdWQRb6LMBXnNFltOFXnx+Mt?=
 =?us-ascii?Q?SqRIxMLGhC+GE0ICZ5DTPR/OJC6KygV7Kvz+Jf0AlivpzXq+yiZYCVCHXIRR?=
 =?us-ascii?Q?NF+hmlAoOdBx/ILSl0djCy6PuZkb1s478y4IKJFrUSbmw3hX92Um8MR01FNF?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	e3w948HyPe6sqPX9w+YMaCxEM2WZt28d/cJHVrvDu8q+KANaFBIHjkJBsrory6UrxTbwC2yyskGXmK4tX2ZIyva1yzEwVk+rNA3g9Rkwt8+7HQxCLRTvBKCQ1nTZ7Iw8wOtXqTkEROd/6RuOYtvz1Dal4qPiMZG7GYKdG1aq0g1IM5SQNvO7Vl8DJ8wcb4xwTW59/TY5Gc6gF8hl7Yw8TzUOeUxYmCkOnqsSFCTopxpnJxi7Z4e0XIFPd+NrmpPHk+Wp6IyrfEN0Safd6Kc4FZ4qfB1ookATltOGwqtHN/ADQlAJpWgLRjuR+DTwss1+63rjY4WmhZBJzesr6ft72qwgSl8NrWcVO4ZKObpRH1GZNsupRsoxwVXACejzh7xYLMIX3gVM9uPv2+CfDzNGWs9B7KsCvcMBJMunPmFG92EOhW9kXFw+HrGxjpdYNmsvEU3Hur4xc5B/4qOEjmlachhB+n3q4KA9niug4LeyB8dJi465zvi7oyHRXXJJbGEIMmxENO6+t1On2aXFL6cfbwCNFWmI8+ZOggLBNXB1usSItmdsOL9rumtFBFnzjnab4g4aWigI3FcbHnlxp/BAsW3tVX3T7G+txVKl5nTjHAk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd42842-d075-4403-2b5f-08dc8c12f931
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 01:40:29.8716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mAe+SU7Af244vXx/5+RQM7m9f7Sq7WxDvf4/x7utGsCBBoNCX1NXBgGahs+M9xiMNwKXJcoNSLo8CPUPqQ9Jw1qXTF3VXsNCIRvma2aEMi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5755
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_15,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406140008
X-Proofpoint-GUID: hJPf2BKSYX5WRf11Xwi6ABAP3urTXXeZ
X-Proofpoint-ORIG-GUID: hJPf2BKSYX5WRf11Xwi6ABAP3urTXXeZ


Christoph,

> The soft max_sectors limit is normally capped by the hardware limits and
> an arbitrary upper limit enforced by the kernel, but can be modified by
> the user.  A few drivers want to increase this limit (nbd, rbd) or
> adjust it up or down based on hardware capabilities (sd).

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering


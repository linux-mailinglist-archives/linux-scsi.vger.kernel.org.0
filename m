Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BB479E5AC
	for <lists+linux-scsi@lfdr.de>; Wed, 13 Sep 2023 13:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237548AbjIMLEL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 13 Sep 2023 07:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjIMLEJ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 13 Sep 2023 07:04:09 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E20B1726
        for <linux-scsi@vger.kernel.org>; Wed, 13 Sep 2023 04:04:05 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38D8ipQ6026292;
        Wed, 13 Sep 2023 04:03:58 -0700
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3t2y862gq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 04:03:58 -0700
Received: from m0045851.ppops.net (m0045851.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38DB3vhZ019304;
        Wed, 13 Sep 2023 04:03:57 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3t2y862gpy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 04:03:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DpDfkG8IZqy+NXFHm1On6ScTjcm/t9A7qyzf+SYvncoyTLoyllQGzKUKQMJ+6yOoxxlnVfTUuyJrHH8tvMN2T/Fxpoi2orS7K6B9n0zdq5KuQIoLkBL44N6InD/b4uoYGwZoN/XNuaCyICFofDOea1/0D8ExU3uzygMxIj31PdgHqEHDiFr+slmU3ZjXuXTB+RqIPSrsxfMgXYk/dc+dea1MnVrIinQvxYPJz3AwPMmuIq4DUIXLro4G9NUfi4GoaXYRXujlR9Ng+ZfQ7WNvD+Wdfea9iiVY+U6X5BDEnmfzDh7Mu44QswtwoMT9ZqbvxFRUPVbMogzvaWPTXp4GzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/w9pRsMpXgK15ojYofSBT0wKXGmdcWTt6aHblMylrE=;
 b=HNnBm2E58IMjhI3ok30zC2Yva0jf7eLgMz07fMbggxH2c86IJytUJiiFkITcgi9Y7GcmiXJ4RAKZWBrnHWCu7Y2n2PjeoPJXb3Aca5NSzvMYYn2ozFgTuQcgjAczeYvM1QfnwKZWjSe8OogBCP6X76+ci4rD/PZIo9lhEDfYbv/XgVExsrKIhF8ApN22jvwkMzOxHBmJwjdnk9P0/KRW1JTKB6QAj3eA/it7CxN6tZUl8XQB5Lkkg0cPYsLcaRp/2vC4F/zWZripZ58A5TV/OSwSENuUzgFdnIaUQAv6hqsdZR57T4dhK/KlSGwCGENCMWj3DmQEONZSsstzM8iz/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/w9pRsMpXgK15ojYofSBT0wKXGmdcWTt6aHblMylrE=;
 b=Lu/D0+KsG3VAMgLGYULuBm/c2yzaC4TWq7ks20etsb6iCOJcZvVRNd684VPgVRblUgrmOpxztBgjtjI4XnRCoP6k6Dl5us+SbGIwZzjCiezopHYFC+zeSTaI5TN3AwXW4Kb7+4ss/bgSPpXjocATg3C90Cc41GYVbkjBbU7UMN8=
Received: from CO6PR18MB4500.namprd18.prod.outlook.com (2603:10b6:5:356::24)
 by SJ0PR18MB3819.namprd18.prod.outlook.com (2603:10b6:a03:2e3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 11:03:55 +0000
Received: from CO6PR18MB4500.namprd18.prod.outlook.com
 ([fe80::18c2:524d:c5db:960d]) by CO6PR18MB4500.namprd18.prod.outlook.com
 ([fe80::18c2:524d:c5db:960d%7]) with mapi id 15.20.6768.036; Wed, 13 Sep 2023
 11:03:55 +0000
From:   Nilesh Javali <njavali@marvell.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        GR-QLogic-Storage-Upstream <GR-QLogic-Storage-Upstream@marvell.com>,
        Anil Gurumurthy <agurumurthy@marvell.com>,
        Shreyas Deodhar <sdeodhar@marvell.com>
Subject: RE: [EXT] Re: [PATCH v3 1/9] qla2xxx: Add Unsolicited LS Request and
 Response Support for NVMe
Thread-Topic: [EXT] Re: [PATCH v3 1/9] qla2xxx: Add Unsolicited LS Request and
 Response Support for NVMe
Thread-Index: AQHZ1C+F9S2z9Ke4PUC+MimNIorwNbAEFakAgBSjbYCAAAIZAA==
Date:   Wed, 13 Sep 2023 11:03:55 +0000
Message-ID: <CO6PR18MB45006C1EE8882E5D5EA08C27AFF0A@CO6PR18MB4500.namprd18.prod.outlook.com>
References: <20230821130045.34850-1-njavali@marvell.com>
 <20230821130045.34850-2-njavali@marvell.com> <ZPBE8AS+mazj+pBQ@infradead.org>
 <ZQGU/4vIEllze8Gx@infradead.org>
In-Reply-To: <ZQGU/4vIEllze8Gx@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbmphdmFsaVxh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLTM4Y2Q4YWI3LTUyMjUtMTFlZS05NGE1LTA0Yjll?=
 =?us-ascii?Q?MzlkN2M5NlxhbWUtdGVzdFwzOGNkOGFiOS01MjI1LTExZWUtOTRhNS0wNGI5?=
 =?us-ascii?Q?ZTM5ZDdjOTZib2R5LnR4dCIgc3o9IjEzNDQiIHQ9IjEzMzM5MDc2NjMzODAy?=
 =?us-ascii?Q?ODMyMCIgaD0iRmVCKzJDbG11UjlCZTdiVk41TC9CTlhiOE13PSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBTjRQQUFB?=
 =?us-ascii?Q?Z00rWDdNZWJaQVErQUpKNjJST2NVRDRBa25yWkU1eFFaQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUhBQUFBQnVEd0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQVFFQkFBQUE5UmVuTHdDQUFRQUFBQUFBQUFBQUFKNEFBQUJoQUdRQVpB?=
 =?us-ascii?Q?QnlBR1VBY3dCekFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHTUFkUUJ6QUhRQWJ3QnRBRjhBY0FC?=
 =?us-ascii?Q?bEFISUFjd0J2QUc0QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFB?=
 =?us-ascii?Q?QUFBQ2VBQUFBWXdCMUFITUFkQUJ2QUcwQVh3QndBR2dBYndCdUFHVUFiZ0Ix?=
 =?us-ascii?Q?QUcwQVlnQmxBSElBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQmpBSFVB?=
 =?us-ascii?Q?Y3dCMEFHOEFiUUJmQUhNQWN3QnVBRjhBWkFCaEFITUFhQUJmQUhZQU1BQXlB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refone: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
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
x-dg-reftwo: =?us-ascii?Q?QUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJrQUd3QWNBQmZB?=
 =?us-ascii?Q?SFFBWlFCaEFHMEFjd0JmQUc4QWJnQmxBR1FBY2dCcEFIWUFaUUJmQUdZQWFR?=
 =?us-ascii?Q?QnNBR1VBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFB?=
 =?us-ascii?Q?QUFBQUFBQUFnQUFBQUFBbmdBQUFHVUFiUUJoQUdrQWJBQmZBR0VBWkFCa0FI?=
 =?us-ascii?Q?SUFaUUJ6QUhNQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFCd0FBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFB?=
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
x-dg-refthree: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
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
x-dg-reffour: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBZ0FBQUFBQSIvPjwvbWV0YT4=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4500:EE_|SJ0PR18MB3819:EE_
x-ms-office365-filtering-correlation-id: 411b814e-256d-4c80-202c-08dbb4491f7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dsb0EBBHueNmCwLI5mJUXpGpZkm3A+V9u7lmFzVHczAKZHrrdrirBLgA+r7DWKVAYZj5gT65UXsTdjRR/zzRGLKd6KkLgABkSV44D3YXDCXkiHXw5VAOxImlRz3jyCm/8NIAwK6BZxAsyDzIwvnw06UW4gIhSL68KuAsUoeZSlblZ1x8cUpUu8ty+oBwG9qcscHg7pNo5LM8F0kESAhcieBSQUMhhgRv4raCJ9uIkxVoFyckaxh2+4bhUCY1rv3jssTEExuZyMf3mwXmwFUXpGcl3vDeEOGKAXX6CHlnldGKld0aJMDcIILS/0Wd78/qBzPPBhZ5wO93+C2M821l/xUvCoPqwFu3E2+FGF92tap0c/EUomk5DwqT8HzTy7AtQZNbOUItPfWll3wFD4yq37dTqEpZZu9Dm/zhSJ/g72ynAYsD/Sas8y+JbMzovy2Jn94l3UExYyXsaT2LSZOTZkhCv1CAMiJbRI1/9h+nH1wpe++/FcvGDlpDXB2uGtaKXa5oOJ7wLyl2uObtyGFNNFmohl+3r9bwI6ofRrfM70WWZ4eGrpctZDcFL8FqVqbiP3nhmkp1w7DYyB/CdYENt1u2bNaL+vBCoQKqEFd/X2U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4500.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(366004)(376002)(186009)(451199024)(1800799009)(53546011)(71200400001)(122000001)(26005)(38070700005)(38100700002)(966005)(76116006)(9686003)(7696005)(478600001)(83380400001)(107886003)(86362001)(66946007)(4326008)(8936002)(6916009)(52536014)(8676002)(5660300002)(66446008)(66556008)(66476007)(54906003)(316002)(33656002)(41300700001)(64756008)(6506007)(55016003)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qbfWd41xhn4g0H5JUGrikPTGcXs/X3WQ/VlMjTDXBfvA0KV2PLtJzVF1o4ej?=
 =?us-ascii?Q?FCC6s4Xa/LIL0bzmTAuK7+n1fPYA+rV46UYMermodfaxsoW4juvT+8bdt3QT?=
 =?us-ascii?Q?jHuqk61Nh23aJK57rn8yH7GIj8hXeoc3PUEMWMd7qnZJao3nHcgrZRBl5F5F?=
 =?us-ascii?Q?JNsEx0KO1MVLk7qSgCFQ+2JO1xv2/b9mxv66iguKiU0/jpwzq/qmdH+2lXCp?=
 =?us-ascii?Q?CdCJn9pw4KbRspl/6sJat4lP/Yq83FfPSnblodavjGI6/Nd4XTqpOrZbaSl8?=
 =?us-ascii?Q?r13g/yb3xP0L6LojqYmboP2oCyjL0l2s+uzfhGkBxZAzRXJ7n4UyjPN8Nscd?=
 =?us-ascii?Q?Ikp6HYte42d8MtPNsU8cu5KVwjiQFbzzwNzsPP6N2wQe4su6+ceI3OxMD2Gf?=
 =?us-ascii?Q?lBVNyTJkfytcMh6aywfnFa/5u9l8vW5gzT8GFYIKxIGfbYvBmmfvtNqZHUgd?=
 =?us-ascii?Q?2Vm7lx5qoNLgv6TctjpNAFyXbHt6RLEYc7G+Q/zmLH2Rg4n5his9Xqr1COLs?=
 =?us-ascii?Q?KfRYoVGfbC/BLTLG6JBjStzPgoPn8fvEKhlxUwm4o+9QAUitsPMb+wN9LC2p?=
 =?us-ascii?Q?xERUbQYIusj7UWFK9hqU7p+zT2Gyw9rGv4rxWUemlnCRVs+VoVZyu6L7NmhD?=
 =?us-ascii?Q?/pYzvEhyjYRtMfUsPJ1vDGSWLrWs865qCrfarAexZRFGS5oWaMLs4PV/kjKJ?=
 =?us-ascii?Q?3p2dZHZf5SffbS9VMfKVZ0fB/wV+vMAr6XNHaTD/KJdqfcwLUUjfcFwHws9e?=
 =?us-ascii?Q?3qfEWcymXVMYVDPf+bWUchhr9F+zFl0SVtldKpuDavXQN0k+WlY8X9pMryLU?=
 =?us-ascii?Q?ecK/fAKSU6ymzMx/2KqlUYfdoxoLix6dSSqReM1iWAlWsyQU2Ow+2MHAv0Dt?=
 =?us-ascii?Q?cAs5Jzu0gno5tMCe0mSQUjXMSZK0z9v7jPBk0w/vN8lLdHc3iRfNE3qGCD85?=
 =?us-ascii?Q?p6JY5WDVcBRvMz36XmQHxrQWfh37VKEmzHK7tPUisnq5Lrxuq32ERJxWEaDc?=
 =?us-ascii?Q?qzYzzwXPFGF2xmpSvanqQgQUScucye2eMk2X/I0k400s/mn/QoTmpeOCFGg7?=
 =?us-ascii?Q?T+eNuRKXkorz5gW0/099HWy7My9yyrUpnFyOEhbrc1ApfOxdXOJ2Fu3Od6xF?=
 =?us-ascii?Q?UBrPE+bgjsr24oeG6wSNTfvQFZtSzFexkVNzGnhY7PkpPx5t8oPDDnVaQHxx?=
 =?us-ascii?Q?q1rVCpANHPg3fhJZVtHEkgtDPYtgdxvXe8dz2EHV+SN5zoDibPK1qDS0+V40?=
 =?us-ascii?Q?5n5GqGLufxJDKorqAIAzq+pKO5xb1bKGuSbRREgGtL5CCSfNNf8c0PtOCqny?=
 =?us-ascii?Q?T5WP1K1nKaV5dOKVGvC1QcxXOunIWxR5E+oh/jP8sXp+4AxZuStVHw1y7eGd?=
 =?us-ascii?Q?NhkmwLonKgceYG3cl7vl6SGPmaujePKeuDvVL+6cAsg1Ac7psmd/pEelIjpG?=
 =?us-ascii?Q?VNDnhQQmwlZFFavxGpmFhENuK4JEjSuyZoTaOfm+sOTkK5o9OJeDIEE+yxJu?=
 =?us-ascii?Q?YC2idVnjhUwimhcbzB+1M9d+gAttO+bOM9CtcJmYuJdeTnopp/ZdRYoxqSR0?=
 =?us-ascii?Q?17RJZOdyFPyiwHJpuk0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4500.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 411b814e-256d-4c80-202c-08dbb4491f7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 11:03:55.6357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kue+kP5g8GgqFqQdZski3zQ0U8vWfY9B+xqv8Xv1e6mm4KSEnFViaOhuRcCl/Ozxnc+NW6AILcFdUzpwx3nbVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB3819
X-Proofpoint-ORIG-GUID: dGFTBH3VW4YADbj-MnIvhCRudb7Xxnvz
X-Proofpoint-GUID: Cpifv9n6SC4kuAm2TlosvihsVmOwV7aB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_04,2023-09-13_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Christoph,

> -----Original Message-----
> From: Christoph Hellwig <hch@infradead.org>
> Sent: Wednesday, September 13, 2023 4:25 PM
> To: Nilesh Javali <njavali@marvell.com>
> Cc: martin.petersen@oracle.com; linux-scsi@vger.kernel.org; GR-QLogic-
> Storage-Upstream <GR-QLogic-Storage-Upstream@marvell.com>; Anil
> Gurumurthy <agurumurthy@marvell.com>; Shreyas Deodhar
> <sdeodhar@marvell.com>
> Subject: [EXT] Re: [PATCH v3 1/9] qla2xxx: Add Unsolicited LS Request and
> Response Support for NVMe
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On Thu, Aug 31, 2023 at 12:44:48AM -0700, Christoph Hellwig wrote:
> > Marting, I saw this made it to linux-next now, please revert it.
> > qla2xxx hsa absolutely no business changing nvme-fc-driver.h without
> > ACKs from the NVMe maintainers.
>=20
> .. and it now made it to mainline and causes sparse warnings in the
> core nvme-fc and lpfc code.
>=20
> Nilesh, Martin, James, can someone please fix this up now?

I have posted a fix for this in qla2xxx driver reverting changes done in nv=
me-fc-driver.h,
https://lore.kernel.org/r/20230831112146.32595-1-njavali@marvell.com

Thanks,
Nilesh

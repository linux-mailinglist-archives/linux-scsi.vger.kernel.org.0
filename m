Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8732C5F6C2
	for <lists+linux-scsi@lfdr.de>; Thu,  4 Jul 2019 12:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfGDKlH (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 4 Jul 2019 06:41:07 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:33710 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727519AbfGDKlG (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 4 Jul 2019 06:41:06 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6DA73C0AC1;
        Thu,  4 Jul 2019 10:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1562236866; bh=W9DiiVzGuE9bqsYZnpGDvwYFykAk+sgLIaGI3u84pTA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=YTgc7OytuhR/26auW4Fz2oeqe8zo7A6Dag+8Y/imU1zRDlFfsloYBYPwfSwHI+S4P
         r07+gIVUjxYNSKAvxftrB/UFGfB4cUGGlTSNTElAjyTcnrKnwXlot0emLfhQHNv8Io
         hxVtrsftOYotiXkirZi6IGPnAwDWYHvBplt9+CNdalDZzE+d8/cJJ7lfcTE2Su7s8K
         WSQmRLr+Bsdi3BREnHU1rYngXUCN6Thk9GoKMM3JJvHGtsdbST3zYXVgquDjlzlcQ+
         DdWh2ziacOaamQIjxejB7vn3Z4tmaNvEJl9uDrhXYWKKrEzXlp+XwjL6DB878J76kV
         lfBK20pYuNw9A==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id A9A44A009A;
        Thu,  4 Jul 2019 10:41:02 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 4 Jul 2019 03:40:02 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 4 Jul 2019 03:40:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQGQW7UhP/F0yZX/3SQcAmZoHOKnv/HAQVD4ZR+hTxw=;
 b=V2zKD57jxx5EC1Qt6az1RS2nXwHG1zEElcaENiE5lxHloDqMd1f7jWo++nXVtZBtpHcim4DXdjkEaVtbxFSHe2o97H8Ffg/zpyIJH8hlG5movC5sWtVSNHSUGL416eRcE7DoN939wH/J9DWJ5tTIiZezjdkySR5rJ33oH7oqJDE=
Received: from MN2PR12MB3167.namprd12.prod.outlook.com (20.179.80.95) by
 MN2PR12MB3325.namprd12.prod.outlook.com (20.178.243.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Thu, 4 Jul 2019 10:40:01 +0000
Received: from MN2PR12MB3167.namprd12.prod.outlook.com
 ([fe80::24d8:6500:f338:d9b]) by MN2PR12MB3167.namprd12.prod.outlook.com
 ([fe80::24d8:6500:f338:d9b%7]) with mapi id 15.20.2052.010; Thu, 4 Jul 2019
 10:40:01 +0000
From:   Pedro Sousa <PedroM.Sousa@synopsys.com>
To:     Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-@mx0a-00230701.pphosted.com" 
        <linux-@mx0a-00230701.pphosted.com>,
        "kernel@vger.kernel.org" <kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>
CC:     Stanley Chu <stanley.chu@mediatek.com>,
        Doug Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Avi Shchislowski <avi.shchislowski@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>,
        Arthur Simchaev <Arthur.Simchaev@sandisk.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: RE: [PATCH] Documentation: scsi: ufs: announce ufs-tool v1.0
Thread-Topic: [PATCH] Documentation: scsi: ufs: announce ufs-tool v1.0
Thread-Index: AQHVK1KrZze5mUE7CUiQGHdLfZqa4qa6TPUQ
Date:   Thu, 4 Jul 2019 10:40:00 +0000
Message-ID: <MN2PR12MB316796A709A4A0358D530A3CCCFA0@MN2PR12MB3167.namprd12.prod.outlook.com>
References: <1561466160-13512-1-git-send-email-Arthur.Simchaev@wdc.com>
In-Reply-To: <1561466160-13512-1-git-send-email-Arthur.Simchaev@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc291c2FcYXBw?=
 =?us-ascii?Q?ZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5?=
 =?us-ascii?Q?ZTM1Ylxtc2dzXG1zZy0xMTQ4ZjM0Ny05ZTQ4LTExZTktYmMwZi1iODA4Y2Yz?=
 =?us-ascii?Q?YjJlNWVcYW1lLXRlc3RcMTE0OGYzNDgtOWU0OC0xMWU5LWJjMGYtYjgwOGNm?=
 =?us-ascii?Q?M2IyZTVlYm9keS50eHQiIHN6PSIyNDEzIiB0PSIxMzIwNjcxMDM5OTEyMDE0?=
 =?us-ascii?Q?NDIiIGg9Ik5jenlYLzkyZEpmSlBBc1NXbURxSFFmL1ZNQT0iIGlkPSIiIGJs?=
 =?us-ascii?Q?PSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUJRSkFBQ2kv?=
 =?us-ascii?Q?dWpUVkRMVkFhTEhtczhESjBwMW9zZWF6d01uU25VT0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFIQUFBQUNrQ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFRQUJBQUFBMUN5NExnQUFBQUFBQUFBQUFBQUFBSjRBQUFCbUFHa0FiZ0Jo?=
 =?us-ascii?Q?QUc0QVl3QmxBRjhBY0FCc0FHRUFiZ0J1QUdrQWJnQm5BRjhBZHdCaEFIUUFa?=
 =?us-ascii?Q?UUJ5QUcwQVlRQnlBR3NBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVB?=
 =?us-ascii?Q?QUFBQUFBQUFBZ0FBQUFBQW5nQUFBR1lBYndCMUFHNEFaQUJ5QUhrQVh3QndB?=
 =?us-ascii?Q?R0VBY2dCMEFHNEFaUUJ5QUhNQVh3Qm5BR1lBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFB?=
 =?us-ascii?Q?QUNlQUFBQVpnQnZBSFVBYmdCa0FISUFlUUJmQUhBQVlRQnlBSFFBYmdCbEFI?=
 =?us-ascii?Q?SUFjd0JmQUhNQVlRQnRBSE1BZFFCdUFHY0FYd0JqQUc4QWJnQm1BQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJtQUc4QWRR?=
 =?us-ascii?Q?QnVBR1FBY2dCNUFGOEFjQUJoQUhJQWRBQnVBR1VBY2dCekFGOEFjd0JoQUcw?=
 =?us-ascii?Q?QWN3QjFBRzRBWndCZkFISUFaUUJ6QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHWUFid0IxQUc0QVpBQnlBSGtBWHdC?=
 =?us-ascii?Q?d0FHRUFjZ0IwQUc0QVpRQnlBSE1BWHdCekFHMEFhUUJqQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFB?=
 =?us-ascii?Q?QUFBQ2VBQUFBWmdCdkFIVUFiZ0JrQUhJQWVRQmZBSEFBWVFCeUFIUUFiZ0Js?=
 =?us-ascii?Q?QUhJQWN3QmZBSE1BZEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQm1BRzhB?=
 =?us-ascii?Q?ZFFCdUFHUUFjZ0I1QUY4QWNBQmhBSElBZEFCdUFHVUFjZ0J6QUY4QWRBQnpB?=
 =?us-ascii?Q?RzBBWXdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdZQWJ3QjFBRzRBWkFCeUFIa0FY?=
 =?us-ascii?Q?d0J3QUdFQWNnQjBBRzRBWlFCeUFITUFYd0IxQUcwQVl3QUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNB?=
 =?us-ascii?Q?QUFBQUFDZUFBQUFad0IwQUhNQVh3QndBSElBYndCa0FIVUFZd0IwQUY4QWRB?=
 =?us-ascii?Q?QnlBR0VBYVFCdUFHa0FiZ0JuQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCekFH?=
 =?us-ascii?Q?RUFiQUJsQUhNQVh3QmhBR01BWXdCdkFIVUFiZ0IwQUY4QWNBQnNBR0VBYmdB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBSE1BWVFCc0FHVUFjd0JmQUhF?=
 =?us-ascii?Q?QWRRQnZBSFFBWlFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFB?=
 =?us-ascii?Q?Q0FBQUFBQUNlQUFBQWN3QnVBSEFBY3dCZkFHd0FhUUJqQUdVQWJnQnpBR1VB?=
 =?us-ascii?Q?WHdCMEFHVUFjZ0J0QUY4QU1RQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ6?=
 =?us-ascii?Q?QUc0QWNBQnpBRjhBYkFCcEFHTUFaUUJ1QUhNQVpRQmZBSFFBWlFCeUFHMEFY?=
 =?us-ascii?Q?d0J6QUhRQWRRQmtBR1VBYmdCMEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFIWUFad0JmQUdzQVpRQjVB?=
 =?us-ascii?Q?SGNBYndCeUFHUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFB?=
 =?us-ascii?Q?QUFDQUFBQUFBQT0iLz48L21ldGE+?=
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sousa@synopsys.com; 
x-originating-ip: [83.174.63.141]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9c2678d-101e-4d66-9f0a-08d7006bf787
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR12MB3325;
x-ms-traffictypediagnostic: MN2PR12MB3325:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <MN2PR12MB33253162ADAA4BBE36CC36BECCFA0@MN2PR12MB3325.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39850400004)(136003)(396003)(376002)(189003)(199004)(8676002)(99286004)(81166006)(74316002)(7696005)(7736002)(81156014)(305945005)(71190400001)(71200400001)(966005)(6506007)(102836004)(14454004)(256004)(14444005)(186003)(26005)(66066001)(2501003)(76176011)(11346002)(446003)(6116002)(3846002)(476003)(478600001)(52536014)(2906002)(316002)(68736007)(110136005)(54906003)(73956011)(486006)(5660300002)(107886003)(76116006)(66946007)(33656002)(7416002)(6436002)(66556008)(25786009)(66476007)(64756008)(66446008)(86362001)(4326008)(8936002)(229853002)(6246003)(55016002)(6306002)(2201001)(53936002)(9686003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR12MB3325;H:MN2PR12MB3167.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0lluSPEWnSlGFyVOr/FyTTzFMXJARRhaR/EcvWlScyJpAfTFBcKC1cpu7hDzvn20yVFZIdvLwTBzE+VvFnQ2wwpsh9E0HzFRiwVo9GJHlF7UiDO2TUfoarnwETaSnIVeCD0dAY2tkBifmuWNmQqd8cPGKHomqoDg1493+maA0o96rRMMr5Zb8RB6U/dHFbZw6IKmqOEP2Ppt0u87cFiiMFBUz8h7AC2bzPdmU/6/tglvl186yWI+230pZVkpKDAA9xWxgihRzY16UEL+Hwk1z6oSGbapoMihuO5M255ZXIujqKj1ZV8k9ZH9CGEpYobCcM3cPyXtFmT3onxFIK1ji3JQujaWurE+DeM7kC5NRRYIAjhXm8riGJKEi26ZnZ0PAARee9FOQ1zGn9r2YDQMCS7ENGnfU4qOtIeisfCnJ5o=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c2678d-101e-4d66-9f0a-08d7006bf787
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 10:40:00.9516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sousa@synopsys.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3325
X-OriginatorOrg: synopsys.com
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hello Arthur,

Very glad to see the ufs-tool coming to light! I will try to give it a=20
run as soon as I get free time slot.

The "maintenance" of the tool will be through github, correct?=20
I took a fast look at the Bean Huo pull request (especially the UniPro=20
command part) and it would be very useful, if I get the time to test it=20
should I mention that in the github pull-request?

Thank you,
Pedro Sousa


From: Arthur Simchaev <Arthur.Simchaev@wdc.com>
Date: Tue, Jun 25, 2019 at 13:36:00

> From: Arthur Simchaev <Arthur.Simchaev@sandisk.com>
>=20
> The ufs-tool stable release v1.0 is available at
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_western=
digitalcorporation_ufs-2Dtool&d=3DDwIBAQ&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3Dg_q=
wcP4gtO-yTlPB3EORzwKHYiXOsyQ6rIu-FZXM-tQ&m=3DjLoVADGdO8Ujrm183cXHL72PszxSrs=
3HDz2EnwmBi_k&s=3D45exXIMsZKp_awsgelPGw8LnGOnWzaP5NZyi9ZJDQRY&e=3D=20
>=20
> Feedback and bug reports, as always, are welcomed.
>=20
> Signed-off-by: Arthur Simchaev <Arthur.Simchaev@wdc.com>
> ---
>  Documentation/scsi/ufs.txt | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/scsi/ufs.txt b/Documentation/scsi/ufs.txt
> index 1769f71..ae4643f 100644
> --- a/Documentation/scsi/ufs.txt
> +++ b/Documentation/scsi/ufs.txt
> @@ -158,6 +158,11 @@ send SG_IO with the applicable sg_io_v4:
>  If you wish to read or write a descriptor, use the appropriate xferp of
>  sg_io_v4.
> =20
> +The user-space tool that interacts with the ufs-bsg endpoint and uses it=
s
> +upiu-based protocol, is available at
> +https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_wester=
ndigitalcorporation_ufs-2Dtool&d=3DDwIBAQ&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3Dg_=
qwcP4gtO-yTlPB3EORzwKHYiXOsyQ6rIu-FZXM-tQ&m=3DjLoVADGdO8Ujrm183cXHL72PszxSr=
s3HDz2EnwmBi_k&s=3D45exXIMsZKp_awsgelPGw8LnGOnWzaP5NZyi9ZJDQRY&e=3D .
> +For more detailed information about the tool and the tool's supported
> +features, please see the tool's README.
> =20
>  UFS Specifications can be found at,
>  UFS - https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__www.jedec.or=
g_sites_default_files_docs_JESD220.pdf&d=3DDwIBAQ&c=3DDPL6_X_6JkXFx7AXWqB0t=
g&r=3Dg_qwcP4gtO-yTlPB3EORzwKHYiXOsyQ6rIu-FZXM-tQ&m=3DjLoVADGdO8Ujrm183cXHL=
72PszxSrs3HDz2EnwmBi_k&s=3DfmlYwpgHkwIeqSSwfVuYbwnQWldMsFZo4Z00TxEYElI&e=3D=
=20
> --=20
> 2.7.4



Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1003C7776D0
	for <lists+linux-scsi@lfdr.de>; Thu, 10 Aug 2023 13:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbjHJLWh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 10 Aug 2023 07:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbjHJLWf (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 10 Aug 2023 07:22:35 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2182690
        for <linux-scsi@vger.kernel.org>; Thu, 10 Aug 2023 04:22:35 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37AAUVep010059
        for <linux-scsi@vger.kernel.org>; Thu, 10 Aug 2023 04:22:35 -0700
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3scx7185bm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Thu, 10 Aug 2023 04:22:34 -0700
Received: from m0045849.ppops.net (m0045849.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37AB67cJ022570
        for <linux-scsi@vger.kernel.org>; Thu, 10 Aug 2023 04:22:34 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3scx7185bf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 04:22:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GeNWAxI0WS6KAI2fQRJdfvjd46wdRWSjMQfY3o6f8i2nEwWsJI/uBmjVTBekgn+fB1V9TK/GDGjrC/C4lkqAcT/+KrkAkxrNcqgcT1UG4XXEzjdy3KuEFv0RmH1P2LEUtlSBi4uksC47NwmYUCn154DlVQgIIcq3tux0jSOj4zy8dT6oAirFTyAnz/0NR3vbfws6dWWTFy55B9ZH8Sj5zqUr1IAuBdJsxlqBHOego+0Llt6Y7Nh4nq5VxqoV+gvakJ+B0TfKm+qLWEbH3jLb90tBt2HQNb7PuRKM/lM6q6pMgPzTzT4kaaHztvBtLBbeACte1L4CA4mGdWQbSoy3Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fY03BvmDhd7EKdgj6ep5wM3d8Laf7/Ic96muCWdxkI=;
 b=h+JzGknRfj1ppEVaamZoXA1EGK+r+60hYyHPS/mZ0pe0VLDnIuFJk8nEDav13wurqFXoq1yYUkHBanKxZft/RPPoHHxBnFcteZS5G3qohhmTCpGvIansd+MrAqvDjVcguJYGU0bHhrkkTEIxuhlevfJtD2ceccstPdQqygVQb1u8/qMLDUXZlyum6/FiYVQhS4RYL9TL2QH8yMdvlL3mOMAcRoCvy+UWTb6bmXSbQWHE2QazWOnr9JcAvlNIvmKFI6RrS25tF+V6qLWBk0SD+33NfQ+JzX/WwjYdIbcWXmE38mopMliYa6NZKaqACkE2AMdCwzpOuQx8QcDQp58oXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fY03BvmDhd7EKdgj6ep5wM3d8Laf7/Ic96muCWdxkI=;
 b=KMRSRNU9Cvw924P9QpvqAuDyDidfKZYwmk84cxb4cxyKQjW1RO60Yo8+854ijTky/B9ZObpP1bkPsxOVNIqI7vAhUb5c2FtFkR0fWQ+jhFvqysFbesGo6DV/bQZGYCDnaXRxFPgumDGvSVkAJb0FQDVGI8fxpK8apxMakpKlDWI=
Received: from CO6PR18MB4500.namprd18.prod.outlook.com (2603:10b6:5:356::24)
 by SA3PR18MB5580.namprd18.prod.outlook.com (2603:10b6:806:37f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 11:22:31 +0000
Received: from CO6PR18MB4500.namprd18.prod.outlook.com
 ([fe80::3d05:8ef7:4dca:995e]) by CO6PR18MB4500.namprd18.prod.outlook.com
 ([fe80::3d05:8ef7:4dca:995e%6]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 11:22:31 +0000
From:   Nilesh Javali <njavali@marvell.com>
To:     John Garry <john.g.garry@oracle.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        GR-QLogic-Storage-Upstream <GR-QLogic-Storage-Upstream@marvell.com>,
        Anil Gurumurthy <agurumurthy@marvell.com>,
        Shreyas Deodhar <sdeodhar@marvell.com>
Subject: RE: [EXT] Re: [PATCH v2 07/10] qla2xxx: Observed call trace in
 smp_processor_id()
Thread-Topic: [EXT] Re: [PATCH v2 07/10] qla2xxx: Observed call trace in
 smp_processor_id()
Thread-Index: AQHZySgt2EE9z7QFQUe5Qp+74eIhcK/ezYkAgAKqFECAAKNDgIABS7rQ
Date:   Thu, 10 Aug 2023 11:22:31 +0000
Message-ID: <CO6PR18MB4500364274A11D261DFAF021AF13A@CO6PR18MB4500.namprd18.prod.outlook.com>
References: <20230807120958.3730-1-njavali@marvell.com>
 <20230807120958.3730-8-njavali@marvell.com>
 <c010df11-79e2-15d2-135f-71ffa6a6e8c8@oracle.com>
 <CO6PR18MB4500AF34C81EAA0943260248AF12A@CO6PR18MB4500.namprd18.prod.outlook.com>
 <bc617ed8-ea8c-eb4c-30d1-a3099684bf59@oracle.com>
In-Reply-To: <bc617ed8-ea8c-eb4c-30d1-a3099684bf59@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm1waGRtRnNhVnhoY0hCa1lYUmhYSEp2WVcxcGJtZGNNRGxrT0RRNVlq?=
 =?utf-8?B?WXRNekprTXkwMFlUUXdMVGcxWldVdE5tSTROR0poTWpsbE16VmlYRzF6WjNO?=
 =?utf-8?B?Y2JYTm5MVEptTkRsaVpHTTRMVE0zTnpBdE1URmxaUzA1TkdFeUxXRXdOVEV3?=
 =?utf-8?B?WWpRMk1HSXlZbHhoYldVdGRHVnpkRnd5WmpRNVltUmpZUzB6Tnpjd0xURXha?=
 =?utf-8?B?V1V0T1RSaE1pMWhNRFV4TUdJME5qQmlNbUppYjJSNUxuUjRkQ0lnYzNvOUlq?=
 =?utf-8?B?RTVNemtpSUhROUlqRXpNek0yTVRRd01UUTVNamM0T1RrNE55SWdhRDBpUlVW?=
 =?utf-8?B?VFJrRXhRVVF5ZDJOeFF6a3JLMjlQZHk5M1RGVjJZamRGUFNJZ2FXUTlJaUln?=
 =?utf-8?B?WW13OUlqQWlJR0p2UFNJeElpQmphVDBpWTBGQlFVRkZVa2hWTVZKVFVsVkdU?=
 =?utf-8?B?a05uVlVGQlRqUlFRVUZFYWpKeWJubG1UWFphUVZKblVHWndLMnhqZEd0UFIw?=
 =?utf-8?B?RTVLMjQyVm5reVVUUmFRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVaEJRVUZCUW5WRWQwRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVWQlFWRkZRa0ZCUVVGSk4zRlVjRUZEUVVGUlFVRkJRVUZCUVVGQlFVRktO?=
 =?utf-8?B?RUZCUVVKb1FVZFJRVnBCUW5sQlIxVkJZM2RDZWtGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGRlFVRkJRVUZCUVVGQlFVRkJRVUZCUlVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?blFVRkJRVUZCYm1kQlFVRkhUVUZrVVVKNlFVaFJRV0ozUW5SQlJqaEJZMEZD?=
 =?utf-8?B?YkVGSVNVRmpkMEoyUVVjMFFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJVVUZCUVVGQlFVRkJRVUZCUVVGQlFWRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkRRVUZCUVVGQlEyVkJRVUZCV1hkQ01VRklUVUZrUVVKMlFV?=
 =?utf-8?B?Y3dRVmgzUW5kQlIyZEJZbmRDZFVGSFZVRmlaMEl4UVVjd1FWbG5RbXhCU0Vs?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUpCUVVGQlFVRkJRVUZCU1VGQlFVRkJRVW8wUVVGQlFtcEJTRlZC?=
 =?utf-8?B?WTNkQ01FRkhPRUZpVVVKbVFVaE5RV04zUW5WQlJqaEJXa0ZDYUVGSVRVRmhR?=
 =?utf-8?B?VUptUVVoWlFVMUJRWGxCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?Q?FBQUFB?=
x-dg-refone: =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGRlFVRkJRVUZCUVVGQlFXZEJRVUZCUVVGdVowRkJRVWRO?=
 =?utf-8?B?UVdSUlFucEJTRkZCWW5kQ2RFRkdPRUZqZDBKNlFVYzBRVmgzUW5KQlIxVkJa?=
 =?utf-8?B?VkZDTTBGSE9FRmpaMEpyUVVoTlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJVVUZCUVVGQlFVRkJRVU5CUVVGQlFV?=
 =?utf-8?B?RkRaVUZCUVVGWmQwSXhRVWhOUVdSQlFuWkJSekJCV0hkQ2VrRklUVUZpWjBK?=
 =?utf-8?B?bVFVYzBRV0ozUW10QlIxVkJZa0ZDY0VGSE1FRmhVVUl3UVVkVlFXTm5RbVpC?=
 =?utf-8?B?U0ZsQlRVRkJlVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUWtGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGSlFVRkJRVUZCU2pSQlFVRkNha0ZJVlVGamQwSXdRVWM0UVdKUlFtWkJT?=
 =?utf-8?B?RTFCWTNkQ2RVRkdPRUZqZDBKM1FVZEZRVmwzUW14QlJqaEJaR2RCZDBGRVNV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?VkJRVUZCUVVGQlFVRkJaMEZCUVVGQlFXNW5RVUZCUjFGQllrRkNkMEZHT0VG?=
 =?utf-8?B?amQwSnlRVWhyUVdOQlFteEJSamhCV1hkQ2IwRkhSVUZrUVVKbVFVY3dRVnBS?=
 =?utf-8?B?UW5wQlNFMUJXVkZDYmtGSFZVRllkMEl5UVVSQlFVMW5RVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZSUVVGQlFVRkJRVUZCUTBGQlFVRkJRVU5sUVVGQlFWcEJR?=
 =?utf-8?B?bk5CU0VGQldIZENla0ZIZDBGWlVVSnFRVWR6UVZoM1FtcEJSMmRCV1ZGQ01F?=
 =?utf-8?B?RkdPRUZpVVVKc1FVaE5RV04zUW1oQlIyTkJXbEZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?Q?FBQUFB?=
x-dg-reftwo: =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQ1FVRkJRVUZCUVVGQlFVbEJRVUZCUVVGS05FRkJR?=
 =?utf-8?B?VUpyUVVkM1FXTkJRbVpCU0ZGQldsRkNhRUZITUVGamQwSm1RVWM0UVdKblFt?=
 =?utf-8?B?eEJSMUZCWTJkQ2NFRklXVUZhVVVKbVFVZFpRV0ZSUW5OQlIxVkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZCUVVGQlFVRkJRVUZuUVVG?=
 =?utf-8?B?QlFVRkJibWRCUVVGSFZVRmlVVUpvUVVkclFXSkJRbVpCUjBWQldrRkNhMEZJ?=
 =?utf-8?B?U1VGYVVVSjZRVWhOUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQ1owRkJRVUZCUVVGQlFVRkJRVUZCUVZGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGRFFVRkJRVUZCUTJWQlFVRkJZbEZDYUVGSVNVRmtaMEpzUVVkM1FW?=
 =?utf-8?B?aDNRbmRCU0VsQlluZENjVUZIVlVGWmQwSXdRVVk0UVdKblFtaEJSekJCV2xG?=
 =?utf-8?B?Q2VrRkdPRUZaZDBKMlFVYzBRVnBuUW5CQlIxRkJXbEZDZFVGSVVVRmhVVUpv?=
 =?utf-8?B?UVVkM1FWaDNRbWhCUjNkQlluZENkVUZIVlVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVSkJRVUZCUVVGQlFVRkJTVUZCUVVGQlFVbzBRVUZCUW5SQlIwVkJZMmRD?=
 =?utf-8?B?TWtGSFZVRmlRVUptUVVoQlFXTm5RblpCUjI5QldsRkNha0ZJVVVGWWQwSjFR?=
 =?utf-8?B?VWRGUVdKUlFteEJTRTFCV0hkQ2VVRkhWVUZqZDBJd1FVaEpRV0ZSUW1wQlNG?=
 =?utf-8?B?RkJXbEZDYTBGR09FRlpVVUp6UVVjNFFXSm5RbXhCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZGUVVGQlFVRkJRVUZCUVdkQlFVRkJRVUZ1WjBGQlFV?=
 =?utf-8?B?Y3dRVmxSUW5sQlNGbEJXbEZDYzBGR09FRmpRVUo1UVVjNFFXRm5RbXhCUjAx?=
 =?utf-8?B?QlpFRkNaa0ZITkVGWlVVSjBRVWRWUVdOM1FtWkJTRWxCV2xGQ2VrRklVVUZq?=
 =?utf-8?B?WjBKd1FVZE5RV1JCUW14QlIxRkJXSGRDYjBGSFZVRmxRVUpxUVVjNFFWcEJR?=
 =?utf-8?B?bXhCU0UxQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlVVRkJRVUZCUVVGQlFVTkJRVUZC?=
 =?utf-8?B?UVVGRFpVRkJRVUZpVVVKb1FVaEpRV1JuUW14QlIzZEJZa0ZDWmtGSFJVRmpa?=
 =?utf-8?B?MEowUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?Q?FBQUFB?=
x-dg-refthree: =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRa0ZCUVVGQlFVRkJRVUZK?=
 =?utf-8?B?UVVGQlFVRkJTalJCUVVGQ2RFRkhSVUZqWjBJeVFVZFZRV0pCUW5OQlJqaEJX?=
 =?utf-8?B?bmRDZGtGSE9FRmFkMEp6UVVkVlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVWQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlowRkJRVUZCUVc1blFVRkJSekJCV1ZGQ2VVRklXVUZhVVVK?=
 =?utf-8?B?elFVZDNRVmgzUW5kQlNFbEJZbmRDY1VGSFZVRlpkMEl3UVVZNFFWbDNRblpC?=
 =?utf-8?B?UjFGQldsRkNla0ZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRlJRVUZCUVVGQlFVRkJRMEZCUVVGQlFVTmxRVUZCUVdKUlFtaEJT?=
 =?utf-8?B?RWxCWkdkQ2JFRkhkMEZpUVVKbVFVaEJRV05uUW5aQlIyOUJXbEZDYWtGSVVV?=
 =?utf-8?B?RllkMEpxUVVjNFFWcEJRbXhCU0UxQldIZENhMEZIYTBGWmQwSXdRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZDUVVGQlFVRkJRVUZCUVVsQlFVRkJRVUZLTkVG?=
 =?utf-8?B?QlFVSjBRVWRGUVdOblFqSkJSMVZCWWtGQ2MwRkdPRUZqUVVKNVFVYzRRV0Zu?=
 =?utf-8?B?UW14QlIwMUJaRUZDWmtGSE5FRlpVVUowUVVkVlFXTjNRbVpCUjAxQlluZENk?=
 =?utf-8?B?VUZIV1VGaFVVSnJRVWRWUVdKblFqQkJSMnRCV1ZGQ2MwRkdPRUZpVVVKb1FV?=
 =?utf-8?B?aEpRV1JuUW14QlIzZEJZa0ZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlJVRkJRVUZCUVVGQlFVRm5R?=
 =?utf-8?B?VUZCUVVGQmJtZEJRVUZITUVGWlVVSjVRVWhaUVZwUlFuTkJSM2RCV0hkQ2Qw?=
 =?utf-8?B?RklTVUZpZDBKeFFVZFZRVmwzUWpCQlJqaEJZbWRDYUVGSE1FRmFVVUo2UVVZ?=
 =?utf-8?B?NFFWbDNRblpCUnpSQldtZENjRUZIVVVGYVVVSjFRVWhSUVdGUlFtaEJSM2RC?=
 =?utf-8?B?V0hkQ2RFRkhSVUZqWjBJeVFVZFZRV0pCUW5OQlJqaEJZbmRDZVVGR09FRlpV?=
 =?utf-8?B?VUo1UVVjd1FVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?Q?FBQUFB?=
x-dg-reffour: =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVkZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZEUVVGQlFVRkJRMlZCUVVGQllsRkNhRUZJU1VGa1owSnNRVWQzUVdKQlFt?=
 =?utf-8?B?WkJTRUZCWTJkQ2RrRkhiMEZhVVVKcVFVaFJRVmgzUW5WQlIwVkJZbEZDYkVG?=
 =?utf-8?B?SVRVRllkMEpxUVVjNFFXSm5RbTFCUjJ0QldrRkNiRUZITkVGa1FVSndRVWRG?=
 =?utf-8?B?UVdKQlFtWkJSekJCV1ZGQ2VVRklXVUZhVVVKelFVZDNRVmgzUW5aQlNFbEJX?=
 =?utf-8?B?SGRDYmtGSE9FRmlkMEp1UVVkM1FWcFJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVK?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlNVRkJRVUZCUVVvMFFVRkJRblJCUjBWQlkyZENNa0ZI?=
 =?utf-8?B?VlVGaVFVSnpRVVk0UVdOQlFubEJSemhCWVdkQ2JFRkhUVUZrUVVKbVFVYzBR?=
 =?utf-8?B?VmxSUW5SQlIxVkJZM2RDWmtGSVNVRmFVVUo2UVVoUlFXTm5RbkJCUjAxQlpF?=
 =?utf-8?B?RkNiRUZIVVVGWWQwSjBRVWRGUVdOblFqSkJSMVZCWWtGQ2MwRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkZRVUZCUVVGQlFVRkJRV2RCUVVGQlFVRnVaMEZCUVVjd1FW?=
 =?utf-8?B?bFJRbmxCU0ZsQldsRkNjMEZIZDBGWWQwSjNRVWhKUVdKM1FuRkJSMVZCV1hk?=
 =?utf-8?B?Q01FRkdPRUZpWjBKb1FVY3dRVnBSUW5wQlJqaEJZMmRDYkVGSVRVRmtRVUo1?=
 =?utf-8?B?UVVkclFWbDNRakJCUjFWQldrRkNaa0ZITUVGWlVVSjVRVWhaUVZwUlFuTkJS?=
 =?utf-8?B?M2RCV0hkQ2RrRklTVUZZZDBKb1FVaEpRV0pSUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCVVVGQlFVRkJRVUZCUVVOQlFVRkJRVUZE?=
 =?utf-8?B?WlVGQlFVRmlVVUpvUVVoSlFXUm5RbXhCUjNkQllrRkNaa0ZJVVVGYVVVSjVR?=
 =?utf-8?B?VWN3UVdGUlFuVkJTRlZCWTNkQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFrRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkpRVUZCUVVGQlNqUkJRVUZDZEVGSFJVRmpaMEl5UVVkVlFXSkJRbk5CUmpo?=
 =?utf-8?B?QlpIZENka0ZJU1VGYVFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUlVGQlFVRkJRVUZCUVVGQlFVRkJRVVZC?=
 =?utf-8?Q?QUFBQUFBQUFBZ0FBQUFBQSIvPjwvbWV0YT4=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4500:EE_|SA3PR18MB5580:EE_
x-ms-office365-filtering-correlation-id: 02a71f88-64e0-4713-474b-08db9994168f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hu8t6jHINjP1YMLIfYfyt7UjRJlOVYMYoszQgjUzlo2bzq5Cc7gg3j6Gx827P1tps+Z0oFUffBRifS+hXqaAivPVniULE5/cz5TunmzpMRUyfcAie370Eytfx1W2nGAYy+2bhop06W5vgZ+HPrqgKmG5iPZJsVx8MzQxRjUtroN2Ym2EzfZcasAEwIg9HULv6nb1Yb11kFcPMVw5QQ1YWJ9J03f+qsiFSuuOtcBVnvV3ItfYg0LIGaNZBFcNj91DLRkoIk8f84BXtOEa9gUwp5hDWKy+e6OydQy3QIPli0W3sSRAyr53Lk/o63M/HF8avmA6BBvqeOlul+xZfJZAhUhfOJqxSIviZcg6TqxvdvfeTAnq3luKY64ToPCSRqC5jSOwClhDylW2IpdYDhL6Ua2UUS/ur/DY/XueDROVUpXeHTmZ2sQb+Rj6VgZh4DSUMfw6Ik27Hh/DFxkTtpQBe1KP4j2QmqnUcIPxr/mVVON/A/97mOoA0g1efkTCul3Qo5Lq6EXL5CInKDW0bpAuI51+5K2ZjhiKGs/4O9/EYp1DndaaUCbqfZ/xJjFgrhqb6cn4NlQsXQ79TbeHc9kGAwfkJB5fBMg7pwMk5TGQVOUoSyIwrXDqtZ44DQDhMKCp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4500.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(451199021)(1800799006)(186006)(83380400001)(55016003)(54906003)(38100700002)(110136005)(478600001)(122000001)(86362001)(2906002)(9686003)(33656002)(71200400001)(7696005)(52536014)(4326008)(38070700005)(41300700001)(8936002)(5660300002)(8676002)(66946007)(66446008)(66556008)(66476007)(76116006)(64756008)(316002)(26005)(107886003)(6506007)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K09zUWoxaEo0VW5pcUNXUVNaMG1iL2pGOXl0Vk1wZ21GT0dKa0hiK1N4ZzlL?=
 =?utf-8?B?VTBFbGYyWkJaS1djZVVucFFSQ0ZNYWlHWjRGUDlpSE1VZmQ1OVJPUlBibUp0?=
 =?utf-8?B?WW0vK3ZlakpWd3owUG50enRsYnM4SHdxRmY0YTBjb3ZSeEVIU2FxTm1laWVy?=
 =?utf-8?B?WSt0UUhRMVFVVEM0RDFIM29OTm1pZjFIVlpyRmdxTlJEQWZ4WG5odUM5Qk5y?=
 =?utf-8?B?akRoaXlwNTdSZUZCR09ISFR0SDZPTkJ2cDJyOGpWOXZEOFFac3hwSUxjanh2?=
 =?utf-8?B?aTkzUmQzZSs4MEcvbzZDcU5ELzJONFl6UUl4eXpTUmpHV3gzMzJDNWFKTE96?=
 =?utf-8?B?STBsR2JIbU5icFZqL1JmMWN6ZkNvRzltY254UGpRc1h5eWl4TWFoSnAzVWM4?=
 =?utf-8?B?YXRNL0NvOVBOS2U5RFBjKys2NWxHOEJZM3VmNXhRV3IrOW1SVGVVS0FhRzQ0?=
 =?utf-8?B?N1ArRFJCbG9WRVFJdTdmMVMwTVZ6NW84RVI1VUVjQkJrY0pIZC9wdjd1VitW?=
 =?utf-8?B?MmlFOG9DTjM1emVkQ2lFUTVqZG94Nm5hMk5IKzV0MkJGRUpaMWhCRm1BSFY3?=
 =?utf-8?B?MHd0UXhodThEMTlBKzdOUlZxOGUxMzB6TWQvc1ZwdUhpZi9TdDlHeC9McjNK?=
 =?utf-8?B?QldFS0Y3SkNqVFZuV3dzdnFYRkdNbnBUb1ZXMVpnSk41aWVuK3hJR1B5ZEpM?=
 =?utf-8?B?TWVaaTBwbWg2ZGJJemNvUjhNNGI5ZlRBV1I3TVVTYXV6dzNwc0dFSW9QOWRp?=
 =?utf-8?B?NVl3ZndrckczL2UzNnAzZm10V0t2VlZHM1pUM3JTSjdJKytzRTlQMnBhTzhl?=
 =?utf-8?B?MDlscU44a0ttcEh2akRhQktqaW9qK2FuWkpZQVA0R1JsMm5Rem1jc3pkN2ow?=
 =?utf-8?B?dWoxY3ExNko3Z0JMem4ray9ZcWgxTTQ0NHZ2ZU1SQ09DWjVpemlCOE91dWhH?=
 =?utf-8?B?bEcrbjFlcXNNRUMzVW4vOEVFV1hHNHRlTlBPU1dtdUdqRXdUa0FhTmVONE92?=
 =?utf-8?B?djVuUEhsNG1abW8rV0dnbXAxME1PZVNLS2tVN3FXU000R28yQVlCK3puY3RH?=
 =?utf-8?B?VUZacHgzaStmUmZsMG9Jd1FlVmJkTjROOFpOMEhnMzBRSzNEUnduQTFQM3ZD?=
 =?utf-8?B?emgvV2RBZXljNjAyYnk2MmpkbDJtSHlCaEFrUUV2eHdTOGpwZkRzWFdXRTVQ?=
 =?utf-8?B?VEdmdklRNmhZeWJROGVQbkZicTlYNVA0L2h6S3c3U3V3MGo3K25mdFFyTHpr?=
 =?utf-8?B?UnhpVms1UWpKUUtSK1JzMXlFaXVvVmlrektIa2N1VjB3QWprekpRMmNRNmZY?=
 =?utf-8?B?VUxMUDlxUDgyc3pINVJhTmtMdXlhR051Wk9JditYM0UwQW0zZ2w5dUZNNVk5?=
 =?utf-8?B?bitIYUJ5SGhsMGYwbkgwWTVITCs5MkdsK0p3SVBpakZQMnBjbjZmQ0llaGE4?=
 =?utf-8?B?cFBaS0pnT0c2eld2NmN0djR6V2psNzVEUGZQRFhTcksyQTBvL2tFNE9VVGJL?=
 =?utf-8?B?MjFTbHZGOWVuQnF4NExQR294bVB0a3M2Z2JaMkhOTW9jUTcwb3E0QndRWmdF?=
 =?utf-8?B?aEZVbXNPQk05aFF3Z0lpVi9rZGZBUkZUcEV6NXBlUHJYNnkvcS9EWFNpbUlz?=
 =?utf-8?B?UjloU3JraEU0SC9ycXA5L3U2YUVWSVlId0I4T1FNbXkwcWtQeWJCMWh1L0tu?=
 =?utf-8?B?QmJ4WlNlbUdsYlJSZ083aml3SE9adGYvdGc3cXkrTUlZdWI5cHlRYUNyZ2Jr?=
 =?utf-8?B?OHU0S2c1cE9sblNpamErR0EyUm9xZWxLNWY3clBsMGFySEt6bzBYYmJkM1Ez?=
 =?utf-8?B?WmxkTFd3dVZXUjdYLzlWMXlSbUZ1dTJCSVo3bnZIaVlGd1ZCUE1hNnVVUlcx?=
 =?utf-8?B?QmVOUlVvQUVQL0xweDFyQ3JTdEVySGpidWNDaFgxVVlDMWliS2MwZkpTRmd2?=
 =?utf-8?B?MnhpM0hFbjNraG53eE5YLytFZ1h3VituVW1sMkVVMXA0VkNiN0xZaW9rK3RQ?=
 =?utf-8?B?SU05QTVEdlFaRnVMakxpZngrSjZWU3hzK1BUS29tcUtYMGtuY0Y3ZXd4NWx0?=
 =?utf-8?B?N0pETmY5VWcwWVRRNkR2ZVcrVkZJU3lqZ3hwUUFRVmNOYnVMRzk0V2RRMFJk?=
 =?utf-8?Q?nTj4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4500.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a71f88-64e0-4713-474b-08db9994168f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 11:22:31.5518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4IqHRE8to3aFqvtHrhejdSXfUnmDnF+KS4V58ur3ZksnUKfXpZTWPh7KGlyeUaTV50yrBp4HHl3ybXOxhsHtCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR18MB5580
X-Proofpoint-GUID: VF_lQf08g0lS0AENN-gUMwE4-AEC1NYh
X-Proofpoint-ORIG-GUID: _zPqB6e6DO4NmFnwReSCmN3r-DG7as3q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_10,2023-08-10_01,2023-05-22_02
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9obiBHYXJyeSA8am9o
bi5nLmdhcnJ5QG9yYWNsZS5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDksIDIwMjMg
OTowMiBQTQ0KPiBUbzogTmlsZXNoIEphdmFsaSA8bmphdmFsaUBtYXJ2ZWxsLmNvbT47IG1hcnRp
bi5wZXRlcnNlbkBvcmFjbGUuY29tDQo+IENjOiBsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZzsg
R1ItUUxvZ2ljLVN0b3JhZ2UtVXBzdHJlYW0gPEdSLVFMb2dpYy0NCj4gU3RvcmFnZS1VcHN0cmVh
bUBtYXJ2ZWxsLmNvbT47IEFuaWwgR3VydW11cnRoeQ0KPiA8YWd1cnVtdXJ0aHlAbWFydmVsbC5j
b20+OyBTaHJleWFzIERlb2RoYXIgPHNkZW9kaGFyQG1hcnZlbGwuY29tPg0KPiBTdWJqZWN0OiBS
ZTogW0VYVF0gUmU6IFtQQVRDSCB2MiAwNy8xMF0gcWxhMnh4eDogT2JzZXJ2ZWQgY2FsbCB0cmFj
ZSBpbg0KPiBzbXBfcHJvY2Vzc29yX2lkKCkNCj4gDQo+IE9uIDA5LzA4LzIwMjMgMDc6MDMsIE5p
bGVzaCBKYXZhbGkgd3JvdGU6DQo+ID4+IEZ1cnRoZXJtb3JlLCBmb3IgdGhlIGluc3RhbmNlIHdo
ZXJlIHRoZSBjYWxsdHJhY2UgaXMgcmVwb3J0ZWQsIGFib3ZlLA0KPiA+PiB0aGVyZSBpcyBubyBt
ZW50aW9uIG9mIHdoeSBpdCBpcyBpbmRlZWQgc2FmZSB0byB1c2UNCj4gPj4gcmF3X3NtcF9wcm9j
ZXNzb3JfaWQoKSBhbmQgd2h5IHRoZSB3YXJuaW5nIGZyb20gc21wX3Byb2Nlc3Nvcl9pZCgpIGNh
bg0KPiA+PiBiZSBpZ25vcmVkLg0KPiA+Pg0KPiA+IFRoYW5rcyBmb3IgdGhlIHJldmlldy4NCj4g
Pg0KPiA+IFRoaXMgcGF0Y2ggYWltcyB0byBzaWxlbnQgdGhlIHdhcm5pbmcgbWVzc2FnZSBpbiBj
YXNlDQo+IENPTkZJR19ERUJVR19QUkVFTVBUIGlzIHR1cm5lZCBvbiBieQ0KPiA+IGFueSB1c2Vy
IHJlcG9ydGluZyBhbiBpc3N1ZS4NCj4gPiBGb3IgcWxhMnh4eCBkcml2ZXIgaXQgaXMgbm90IGNy
aXRpY2FsIHRvIGhhdmUgYWNjdXJhdGUgQ1BVIElEIHdoaWNoIHdvdWxkDQo+IG1vbWVudGFyaWx5
IGNhdXNlDQo+ID4gcGVyZm9ybWFuY2UgaGl0IGZvciB0aGUgdGhyZWFkIHRoYXQgcHJlLWVtcHRl
ZC4NCj4gDQo+IEkgZG91YnQgdGhhdCB0aGUgZHJpdmVyIG5lZWRzIHRvIGNoZWNrIHRoZSBjdXJy
ZW50IENQVSBzbyBvZnRlbiwgaWYgYXQNCj4gYWxsLiBCdXQgSSBkb24ndCBrbm93IHRoZSBkcml2
ZXIgd2VsbCwgc28gY2FuJ3Qgc2F5IG1vcmUuDQo+IA0KPiBBcGFydCBmcm9tIHRoYXQsIGFjY29y
ZGluZyB0byBkZXNjcmlwdGlvbiBvZiBxdWV1ZV93b3JrKCk6DQo+ICJXZSBxdWV1ZSB0aGUgd29y
ayB0byB0aGUgQ1BVIG9uIHdoaWNoIGl0IHdhcyBzdWJtaXR0ZWQsIGJ1dCBpZiB0aGUgQ1BVDQo+
IGRpZXMgaXQgY2FuIGJlIHByb2Nlc3NlZCBieSBhbm90aGVyIENQVS4iDQo+IA0KPiBTbyBpc24n
dCBzb21ldGhpbmcgbGlrZQ0KPiBxdWV1ZV93b3JrX29uKHJhd19zbXBfcHJvY2Vzc29yX2lkKCks
IGhhLT53cSwgJnFwYWlyLT5xX3dvcmspIHNhbWUgYXMNCj4gcXVldWVfd29yayhoYS0+d3EsICZx
cGFpci0+cV93b3JrKT8NCj4gDQo+IEkgc2VlIHRoYXQgcXVldWVfd29yaygpIGFscmVhZHkgaGFz
IHRoZSByYXdfc21wX3Byb2Nlc3Nvcl9pZCgpIGNhbGwuDQoNCkluIGZhY3QgcXVldWVfd29yayB1
c2VzIHF1ZXVlX3dvcmtfb24gdGhhdCBoYXMgcmF3X3NtcF9wcm9jZXNzb3JfaWQuDQpTbywgcWxh
MnggdXNpbmcgcXVldWVfd29ya19vbiB3aXRoIHJhd19zbXBfcHJvY2Vzc29yX2lkIHNob3VsZCBi
ZSBva2F5LA0KdW5sZXNzIHlvdSB0aGluayBvdGhlcndpc2UuDQoNClRoYW5rcywNCk5pbGVzaA0K
DQoNCg==

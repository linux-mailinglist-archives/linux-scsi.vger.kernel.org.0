Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABC91A908E
	for <lists+linux-scsi@lfdr.de>; Wed, 15 Apr 2020 03:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392684AbgDOBki (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 14 Apr 2020 21:40:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33650 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392682AbgDOBkg (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 14 Apr 2020 21:40:36 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03F1dPqW080821;
        Wed, 15 Apr 2020 01:40:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=luU8DQH9MRurbNJOiYy1N0TB0RTHIB9F2tcZxbAgitk=;
 b=fMKnAtSiBVc9KuGcXvQa4rBh5rPr8JrnmZbpBtRtre4C05BGyxyjGuuso7FeNI2Q/glC
 B+tM9SL+jxqWRIsbx4XHrbwmaDcnFatUhErpS54eRqlrjwp6yvX1CLWq8m6hgV8nCZq/
 U6zhbIGmXp8QaszJ3tvX3IXAFUCKfMJqMUl9nt0Qpae8ycGl5H91+37epOtO0NpAExOe
 ZulETDg+jGhE3nVJU9lEidGey3iZJuwk5p3fPCFerGdHQvDPL89KVyVxcJ4M2obXmrC+
 O/o6vPoMcmwJ8NnM/2m31tV6vF7WcjbU7YaWr1a8N0r3lj3cCvry0T/9Krcat1lMrSXI hQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 30dn9t8kp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Apr 2020 01:40:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03F1bGFi045947;
        Wed, 15 Apr 2020 01:40:25 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 30dn8v2jvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Apr 2020 01:40:25 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03F1eNsR019219;
        Wed, 15 Apr 2020 01:40:23 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Apr 2020 18:40:23 -0700
To:     Jason Yan <yanaijie@huawei.com>
Cc:     <kashyap.desai@broadcom.com>, <sumit.saxena@broadcom.com>,
        <shivasharan.srikanteshwara@broadcom.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <megaraidlinux.pdl@broadcom.com>,
        <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 0/4] scsi: megaraid: make a bunch of symbols static
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200407092827.18074-1-yanaijie@huawei.com>
Date:   Tue, 14 Apr 2020 21:40:21 -0400
In-Reply-To: <20200407092827.18074-1-yanaijie@huawei.com> (Jason Yan's message
        of "Tue, 7 Apr 2020 17:28:23 +0800")
Message-ID: <yq18sixr0fu.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9591 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004150008
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9591 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004150008
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Jason,

> Make a bunch of symbols static to fix some sparse warnings.
>
> Jason Yan (4):
>   scsi: megaraid: make two symbols static in megaraid_mbox.c
>   scsi: megaraid: make some symbols static in megaraid_sas_fp.c
>   scsi: megaraid: make some symbols static in megaraid_sas_fusion.c
>   scsi: megaraid: make two symbols static in megaraid_sas_base.c

Applied to 5.8/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

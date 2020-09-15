Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA7D26AFFE
	for <lists+linux-scsi@lfdr.de>; Tue, 15 Sep 2020 23:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgIOVxO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 15 Sep 2020 17:53:14 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57508 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbgIOVxH (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 15 Sep 2020 17:53:07 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FLo20x027647;
        Tue, 15 Sep 2020 21:52:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=x2bSJU1P2SEkjA4EGZDCmzJqd0N8KxBZWYGjGGnclXo=;
 b=WuhiK5si/BDa41rk5TFMD3YW639mKaEbx8mrs8wdIXgLgYYyzaCngz6ta39fzmNj2fvK
 1Zu7aUQlFu5NrxIrN+Vm32puilqwhBW0PLTfW7YRR1UhUbxLJPZEBKTFoBzvKmmJK28M
 3UiiBF3maifdb/lk17OmGPqLUieaLr+Fyvt/nSAk6oZhfyI86/2RkOrbpnD8aHnESuH+
 oh0hOYQOg9D175hSMykVrX3/hj9DVorUvU6bth0/9gqV7ZjO3qQrw1P/Oz5scEhn9pVt
 D0jBNHWLZNw5EM0BhcUT4fSFu8SGvr1+NWzmq7e+jscBxx4X5hU4uhzHS5/K2n7iBvje iA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 33gnrqyt9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Sep 2020 21:52:56 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FLoEhW016486;
        Tue, 15 Sep 2020 21:52:55 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 33h7wpswvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Sep 2020 21:52:55 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08FLqrwD019606;
        Tue, 15 Sep 2020 21:52:53 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Sep 2020 21:52:53 +0000
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <hare@suse.de>, <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] scsi: libfc: Fix passing zero to 'PTR_ERR' warning
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1v9ge4sid.fsf@ca-mkp.ca.oracle.com>
References: <20200818114235.51052-1-yuehaibing@huawei.com>
        <20200909135432.36772-1-yuehaibing@huawei.com>
Date:   Tue, 15 Sep 2020 17:52:51 -0400
In-Reply-To: <20200909135432.36772-1-yuehaibing@huawei.com>
        (yuehaibing@huawei.com's message of "Wed, 9 Sep 2020 21:54:32 +0800")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 adultscore=0 bulkscore=0 phishscore=0 mlxlogscore=872 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150169
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 bulkscore=0 suspectscore=1
 clxscore=1015 mlxlogscore=904 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150169
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


YueHaibing,

> drivers/scsi/libfc/fc_disc.c:304
>  fc_disc_error() warn: passing zero to 'PTR_ERR'
>
> fp maybe NULL in fc_disc_error(), use PTR_ERR_OR_ZERO to handle this.

Applied to 5.10/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

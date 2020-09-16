Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20EA26B968
	for <lists+linux-scsi@lfdr.de>; Wed, 16 Sep 2020 03:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgIPBch (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 15 Sep 2020 21:32:37 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37364 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbgIPBcd (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 15 Sep 2020 21:32:33 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08G1TmFi018782;
        Wed, 16 Sep 2020 01:32:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=8ck4XG1MJV++vA6w9vkliE2IdDNZb46ogwiHEX3W9pU=;
 b=X33on2T5XkX/zPvE4oWIkzur4N/1ggXgSqCr5iha72H68Fl5QjNlgtO51qmVs7ZkjXWX
 TvBKeXwvUvFGkDus1UPSBpKdOLqhwy/pJhibGZxTTnX9pb2Tul4Iov2OCZ6JCIK96FGS
 85Fe6Z1AaD2Q+H5dSuRzJL2GjL+vg7Q36apnYz8LM6chRwioXighQ38TYykigPceZuFH
 gdELihdkt7FOyJOHReaZUGJLQ9yLXu7dx+T3tQR+hDLE8HzfykiRLW/obndewM+q0px6
 E9B4I+QLQO9Hjwq5Iqzv1Jmo6yZYQZMfVaFmFXjuuuM9TVCKmekQ+qq4vPNDYN/hMzQn uw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 33gnrr0ava-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Sep 2020 01:32:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08G1VV10107851;
        Wed, 16 Sep 2020 01:32:13 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 33h886m6d9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Sep 2020 01:32:13 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08G1WCDA024491;
        Wed, 16 Sep 2020 01:32:12 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Sep 2020 01:32:11 +0000
To:     Jason Yan <yanaijie@huawei.com>
Cc:     <hare@kernel.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <gustavoars@kernel.org>,
        <linux-scsi@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] scsi: myrb: make some symblos static
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1d02mzeul.fsf@ca-mkp.ca.oracle.com>
References: <20200915084018.2826922-1-yanaijie@huawei.com>
Date:   Tue, 15 Sep 2020 21:32:09 -0400
In-Reply-To: <20200915084018.2826922-1-yanaijie@huawei.com> (Jason Yan's
        message of "Tue, 15 Sep 2020 16:40:18 +0800")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=1 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=917
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009160007
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 bulkscore=0 suspectscore=1
 clxscore=1015 mlxlogscore=944 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009160006
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Jason,

> This addresses the following sparse warning:
>
> drivers/scsi/myrb.c:2229:27: warning: symbol 'myrb_template' was not
> declared. Should it be static?
> drivers/scsi/myrb.c:2318:31: warning: symbol 'myrb_raid_functions' was
> not declared. Should it be static?
> drivers/scsi/myrb.c:2492:6: warning: symbol 'myrb_err_status' was not
> declared. Should it be static?

Applied to 5.10/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

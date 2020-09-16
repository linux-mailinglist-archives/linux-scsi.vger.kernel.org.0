Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD5226B95F
	for <lists+linux-scsi@lfdr.de>; Wed, 16 Sep 2020 03:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgIPB3O (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 15 Sep 2020 21:29:14 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47552 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgIPB3M (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 15 Sep 2020 21:29:12 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08G1T3SC116964;
        Wed, 16 Sep 2020 01:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=hMHjZtQ8Ac5g1/UhPZcXvOfSH450IVcVq2ad5OH4kMk=;
 b=lA/UvolChAxpD1dlbyLfPwaKn/FVsiOjuJZxr4e3vZ/ZR1rQ3DM3m1F8e7QweKTHlHky
 1E1DjAXQAtJN2FfOayuBttCBj813fb0kKJi5gzh0rqw5fdAfjqu6Iab1QsfsQFecusw+
 IMRB2++hu9NRaLgPVbuhn5dso3B6PqZRoGf5qaqddq++DRbOHZivVD9ZBBzxiFqUk4fE
 blvzFfoHR7inGJZ6ww5vhzPDwLdNzx1f3ay/3SQujwk4+/9dSERrtKYBLXVN5tpcpvss
 6Kr26oT/5oLyA9VaP+xvhtl5nrQQTEcM7ywPGX0oqcPhOg4ANda3D6VyckHVpwm/AzNR bw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 33gp9m89bj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Sep 2020 01:29:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08G1QI45056761;
        Wed, 16 Sep 2020 01:28:53 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 33h7wq1c6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Sep 2020 01:28:53 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08G1SpdU021276;
        Wed, 16 Sep 2020 01:28:51 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Sep 2020 01:28:51 +0000
To:     Jason Yan <yanaijie@huawei.com>
Cc:     <intel-linux-scu@intel.com>, <artur.paszkiewicz@intel.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <arnd@arndb.de>, <linux-scsi@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] scsi: isci: make isci_host_attrs static
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1zh5qzf05.fsf@ca-mkp.ca.oracle.com>
References: <20200912033741.142415-1-yanaijie@huawei.com>
Date:   Tue, 15 Sep 2020 21:28:48 -0400
In-Reply-To: <20200912033741.142415-1-yanaijie@huawei.com> (Jason Yan's
        message of "Sat, 12 Sep 2020 11:37:41 +0800")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 adultscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009160006
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 clxscore=1011 lowpriorityscore=0 phishscore=0
 spamscore=0 priorityscore=1501 suspectscore=1 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009160006
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Jason,

> This eliminates the following sparse warning:
>
> drivers/scsi/isci/init.c:145:25: warning: symbol 'isci_host_attrs' was
> not declared. Should it be static?

Applied to 5.10/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

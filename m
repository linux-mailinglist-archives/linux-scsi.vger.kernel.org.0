Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31AAA26B961
	for <lists+linux-scsi@lfdr.de>; Wed, 16 Sep 2020 03:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbgIPBbL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 15 Sep 2020 21:31:11 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48936 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgIPBbJ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 15 Sep 2020 21:31:09 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08G1Tiie117532;
        Wed, 16 Sep 2020 01:31:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=pr0FsC78kJ0RJA9G9ZJsSLcvoU1ENil8S1oGNIo5Hrg=;
 b=Nz71TBr4SHKTqApEnAuNMdUISyRpUqOBLdDoVsltVzW9AOGBkXvISO0krMf6CgFDNaDE
 VqJzYCONZRNzFCfnzoOACZG/1JqwIYUF6jci/u2iubfnxXyS+zli8y9497e7L5xi0KsH
 I/x5KPXx43Xz6LINhrcWs53OLm5aPnqwAVsA+uUXF/WVloEWq8KQwE4kIoMFdQgDeHu8
 FnCfq1tS0yIulp1t7M6vFj0Zu6pw72DQS9LfOTdIg1gzzijQNfbwWm96zleiuRDuqDp4
 HD8VGtbyzw3mKShvAk/NWJ5rjJpcslLnfgwYrTf6RCi/Dtoy9031e1OIu41aZI9pKiGS IA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 33gp9m89fu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Sep 2020 01:31:01 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08G1Tpvk057102;
        Wed, 16 Sep 2020 01:31:00 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 33hm31mgej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Sep 2020 01:31:00 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08G1Uxlf011515;
        Wed, 16 Sep 2020 01:30:59 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Sep 2020 01:30:58 +0000
To:     Jason Yan <yanaijie@huawei.com>
Cc:     <intel-linux-scu@intel.com>, <artur.paszkiewicz@intel.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] scsi: isci: make scu_link_layer_set_txcomsas_timeout()
 static
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1o8m6zewk.fsf@ca-mkp.ca.oracle.com>
References: <20200915084000.2826741-1-yanaijie@huawei.com>
Date:   Tue, 15 Sep 2020 21:30:56 -0400
In-Reply-To: <20200915084000.2826741-1-yanaijie@huawei.com> (Jason Yan's
        message of "Tue, 15 Sep 2020 16:40:00 +0800")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 adultscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009160007
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 spamscore=0 priorityscore=1501 suspectscore=1 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009160006
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Jason,

> This addresses the following sparse warning:
>
> drivers/scsi/isci/phy.c:672:6: warning: symbol
> 'scu_link_layer_set_txcomsas_timeout' was not declared. Should it be
> static?

Applied to 5.10/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

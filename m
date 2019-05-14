Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37A901CDAE
	for <lists+linux-scsi@lfdr.de>; Tue, 14 May 2019 19:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfENRNs (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 14 May 2019 13:13:48 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44596 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfENRNs (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 14 May 2019 13:13:48 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4EGwlU6140052;
        Tue, 14 May 2019 17:13:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=7SmZk+lQoHGx19ZNjJ3VJvOQ+b0dB00M3vEj2OUG2yg=;
 b=5UwSc9FzT7g0C/QfiUCEf3SW2d8uiwx0So/a15r4eQ8c5WRiITD30xXoMe8hnThNi5Bm
 U/4Wi15vKSTCrnXQRGTeUr+l/gz7sFZLWMZXu/w9fgp1S0W/TsHbP70U/1CUaUiRRcJd
 QbvxHT5roEarwskgwtHDRe1hy7kc3eeZHvScmiwmThuhHLBhf2kBgyKAa5S3Pno2jpQP
 oJ4KC7gkyzaUB8eNnwKChKHIJPHUrmRkZbYqTQczcpPnhCnagx9+QTPANjbLp0pwV5QX
 NIGq9EBM8go2zypM/3bI0S87OG09JgZ9HvUnDNHCUc+dV6JgW2UI1uyJdlbGw8H9Ch2e tQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2sdq1qfj3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 May 2019 17:13:32 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4EHCggS136882;
        Tue, 14 May 2019 17:13:32 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2sdnqjpbkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 May 2019 17:13:32 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4EHDQBg023659;
        Tue, 14 May 2019 17:13:28 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 May 2019 10:13:26 -0700
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 0/2] sd: Rely on the driver core for asynchronous probing
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190430213919.97437-1-bvanassche@acm.org>
Date:   Tue, 14 May 2019 13:13:22 -0400
In-Reply-To: <20190430213919.97437-1-bvanassche@acm.org> (Bart Van Assche's
        message of "Tue, 30 Apr 2019 14:39:17 -0700")
Message-ID: <yq14l5xdknh.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9257 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=829
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905140119
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9257 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=880 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905140118
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Bart,

> This patch series makes the sd driver rely on the driver core for
> asynchronous probing. Although it's probably too late to submit this
> patch series to Linus during the v5.2 merge window, I want to make
> these patches available for review now.

Applied to 5.3/scsi-queue (by hand). Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D62FA38018
	for <lists+linux-scsi@lfdr.de>; Thu,  6 Jun 2019 23:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfFFV6B (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 6 Jun 2019 17:58:01 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59024 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfFFV6B (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 6 Jun 2019 17:58:01 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x56LrscY075526;
        Thu, 6 Jun 2019 21:57:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=Q3sJ1+YjKP7hDhS3DraMPydB/bNpy0POTT1rbLVfxfo=;
 b=BrXrVNaCRzi40b7Y/+FDGpJ4V/d9yvMjnA7BIo8Kzpv18vA9FKOtrrsymq5WDKExRmZI
 PUjDVaOpKxDZpkAiRkaUfLm5oDoy1L7Sfc6+Y5uv1U0cI8GcOvmuUbX6wyWz8EcUizkx
 yJK4Df4JTMI1BmVA/NU79np6lMt1UkxvO1wU/SQq0FiT4sWEexdmVsfm4uX79ERpkX/q
 nHEWT9Ds1vrExt6M829bIXpqUmHxV6USyvIfbzxgcITbx5K6tNTzZ9Ao5ajZb6SfMJgz
 htHIe1ovAiMq0rrwTeztuXzb09AKFOjmqyhw4MU+kW7V0T8rUGSrysgf+EZdH7jUS9wf bA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2sugstu4mr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jun 2019 21:57:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x56LugPt110820;
        Thu, 6 Jun 2019 21:57:45 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2swnhcxjeu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jun 2019 21:57:45 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x56Lvibw021176;
        Thu, 6 Jun 2019 21:57:44 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Jun 2019 14:57:44 -0700
To:     Himanshu Madhani <hmadhani@marvell.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "linux-scsi\@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [EXT] [PATCH 00/20] qla2xxx Patches
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190529202826.204499-1-bvanassche@acm.org>
        <794547A0-2D81-42DD-8777-27B9BE607E21@marvell.com>
        <yq1y32fo4d9.fsf@oracle.com>
        <838DE773-DCD5-40CA-933C-1FF88399AF6C@marvell.com>
Date:   Thu, 06 Jun 2019 17:57:41 -0400
In-Reply-To: <838DE773-DCD5-40CA-933C-1FF88399AF6C@marvell.com> (Himanshu
        Madhani's message of "Thu, 6 Jun 2019 15:54:30 +0000")
Message-ID: <yq1o93aml62.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9280 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=791
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906060148
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9280 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=840 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906060148
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Himanshu,

> Sorry for delay. I need bit more time. I will let my automation work
> thru weekend and will respond in early next week

OK, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

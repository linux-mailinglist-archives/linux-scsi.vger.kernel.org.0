Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B703579E9
	for <lists+linux-scsi@lfdr.de>; Thu, 27 Jun 2019 05:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfF0DUN (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 26 Jun 2019 23:20:13 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58606 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfF0DUN (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 26 Jun 2019 23:20:13 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5R38tuM073642;
        Thu, 27 Jun 2019 03:20:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=sKzxDyHtkLeYNTXupxGAFrBe/IPMLP49ZQRkMwBtWuU=;
 b=AYss2PomyuiSFZkDPU/bP9QEYKz+werBz2344U5NI85Rk6yRJzrDRLX/ifDogcewN0Be
 rnPXShIgfH45q9ALMHCxvI4brTTI88gKQLF8sB1FmYQOp0zelsiDRBw5fm882lSDDVCP
 aazDQ3+8RxhqrLJzrkTGoymlKtGsvGtwD6K7J6hvfTBzrsOZK2RBn66aeZHalowoauCD
 el89XS2hF3u00+zJ8pIN1YYljcdaUgDx+3p/+k9J7v8EugW4+iHv+87dpw+EW4uls8rh
 tRMFJZaCTNTiAPnr3bMDoAm3/GWmsxr5X7wfhRLk+/G0H6hpSJOX+gG+nqzq1wEKYTnk 7w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2t9brtdptw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 03:20:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5R3JuGi134221;
        Thu, 27 Jun 2019 03:20:10 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2t99f4sg93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 03:20:10 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5R3K97O012392;
        Thu, 27 Jun 2019 03:20:09 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Jun 2019 20:20:09 -0700
To:     Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Cc:     linux-scsi@vger.kernel.org, kashyap.desai@broadcom.com,
        sumit.saxena@broadcom.com, kiran-kumar.kasturi@broadcom.com,
        sankar.patra@broadcom.com, sasikumar.pc@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, anand.lodnoor@broadcom.com
Subject: Re: [PATCH v3 00/18] megaraid_sas: driver updates to 07.710.06.00-rc1
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190625110436.4703-1-chandrakanth.patil@broadcom.com>
Date:   Wed, 26 Jun 2019 23:20:06 -0400
In-Reply-To: <20190625110436.4703-1-chandrakanth.patil@broadcom.com>
        (Chandrakanth Patil's message of "Tue, 25 Jun 2019 16:34:18 +0530")
Message-ID: <yq1tvcbk93t.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=512
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906270035
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=584 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906270035
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Chandrakanth,

> This patchset contains performance improvements in megaraid_sas driver
> for latest MegaRAID Aero family of adapters along with few driver
> fixes.

Applied to 5.3/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36AFBE218
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Apr 2019 14:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbfD2MSs (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 29 Apr 2019 08:18:48 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:41418 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbfD2MSs (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 29 Apr 2019 08:18:48 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3TBxLvI183989;
        Mon, 29 Apr 2019 12:18:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=f8amNhenwnWeFALAqBWAWShb+bP2plL0JVT8Sqf4PnU=;
 b=RxdMjjH9i/5tlUhPtQEprWbHo6gqgotB3xV2KTcyzamJhZYn4zWqitID8nRewVCp+zeE
 pUnaSRobosQbVeYuzs2o+NYj5sfB+Tklxdff5lculKUUZ/VTOQ9FyfF5kxw3lW/UeQTo
 P5xGZpa8BIgae6cof6h3cSaws/jnej2aDJZY4DX/ass5Y3EoXw1tY5wmNKw9DYU7aNit
 LBWMCJKQPZsFV5rFFOPipflpPHifig5l7bd4UV6pF64I7ndBiGu3XycPw5mv74JgCcMX
 VsfAM7IdmSe2HgEQhQxcu+wrhmaO0N70POEhLxyWIwUaA9VFaB0zzF9ZLwj0WHkIS/ZS oA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2s4ckd65wm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Apr 2019 12:18:32 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3TCGvNv115465;
        Mon, 29 Apr 2019 12:18:32 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2s5u50cex2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Apr 2019 12:18:31 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3TCIUtI024902;
        Mon, 29 Apr 2019 12:18:31 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Apr 2019 05:18:30 -0700
To:     Varun Prakash <varun@chelsio.com>
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        dt@chelsio.com, indranil@chelsio.com, ganji.aravind@chelsio.com
Subject: Re: [PATCH] scsi: csiostor: create per port irq affinity mask set
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1555853443-6027-1-git-send-email-varun@chelsio.com>
Date:   Mon, 29 Apr 2019 08:18:28 -0400
In-Reply-To: <1555853443-6027-1-git-send-email-varun@chelsio.com> (Varun
        Prakash's message of "Sun, 21 Apr 2019 19:00:43 +0530")
Message-ID: <yq15zqx0zu3.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9241 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904290088
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9241 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904290088
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Varun,

> csiostor driver allocates per port num_online_cpus() irq vectors, so
> create per port irq affinity mask set to spread irq vectors evenly.

Applied to 5.2/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

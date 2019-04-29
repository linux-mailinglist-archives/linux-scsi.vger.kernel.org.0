Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 768B0E996
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Apr 2019 19:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbfD2R7W (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 29 Apr 2019 13:59:22 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:49440 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbfD2R7W (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 29 Apr 2019 13:59:22 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3THwhZX114862;
        Mon, 29 Apr 2019 17:59:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=PIjFVMADhjDCKo9/pSr9e/vXUxLxAyaIGzsn3QRp5Sk=;
 b=uXKdY/njdjFyv/lzt8Z2f+rJz2Niz64UnFssMfFDVYMb3UMEQGs92dfgVYhOGNms4mnQ
 bA6GUA8s1RchjWt+qOKSLV/L4MqWxclLhBMvIJhDoG/pl8XINIBbuQNMgVC/cFxpZsJ+
 AKyd/tL/xWUggF1mkYMsCpZV4PwTtCIa/MS0i1md1yN6qG5hu62NlIlIoLpOEhajkMGl
 RibfGqY68J/gXxWNjTia18pG00QdtnnacrzKbkM/2L2bptTCl5de+DFIWGwgJ3y4LmWz
 mEJRCeamNHY5h4Xous9pj9v5KJczx/PIOc/ist6A66DbUP5ZhACrGY+irrwGybbP29N9 8w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2s4ckd87th-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Apr 2019 17:59:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3THwdwD032518;
        Mon, 29 Apr 2019 17:59:13 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2s4d4a2veh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Apr 2019 17:59:12 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3THxCma028952;
        Mon, 29 Apr 2019 17:59:12 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Apr 2019 10:59:11 -0700
To:     Himanshu Madhani <hmadhani@marvell.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "linux-scsi\@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Christoph Hellwig" <hch@lst.de>
Subject: Re: [PATCH 00/35] qla2xxx source code cleanup and bug fixes
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190417214443.243152-1-bvanassche@acm.org>
        <1556229869.161891.147.camel@acm.org>
        <61A50A60-DF18-4EF3-83C4-124BA6AEFE9D@marvell.com>
Date:   Mon, 29 Apr 2019 13:59:08 -0400
In-Reply-To: <61A50A60-DF18-4EF3-83C4-124BA6AEFE9D@marvell.com> (Himanshu
        Madhani's message of "Thu, 25 Apr 2019 23:05:39 +0000")
Message-ID: <yq15zqwzo9f.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9242 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=940
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904290123
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9242 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=976 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904290123
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Himanshu,

> Still reviewing it. About half way done. Will ACK if no issues found
> during testing.

Gentle poke. There are just a couple of days left before the merge
window and we'll need some -next/0-day coverage.

-- 
Martin K. Petersen	Oracle Linux Engineering

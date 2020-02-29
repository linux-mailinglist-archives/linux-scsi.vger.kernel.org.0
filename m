Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4492174464
	for <lists+linux-scsi@lfdr.de>; Sat, 29 Feb 2020 02:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgB2B5g (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 28 Feb 2020 20:57:36 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50532 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgB2B5f (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 28 Feb 2020 20:57:35 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01T1sVJO065321;
        Sat, 29 Feb 2020 01:57:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=pqJjpcqPn3SkAkXRjKrWlI5eprIc2PZDrGmaRmyQEgA=;
 b=de9papGKHZiX2xmILz2wMjGzEJB1m1twTdYVwtdod0AJwbB6h7R0b0VEXFj3dM1aH//D
 qMVROEPc/xnQqn2KDuF90NneL5pEoyxsCTFG4bMYZLSDbwu82TCcmXtXMg9LWlXgNOGj
 eGMvZyQv0nmwotcGkBL82XRDdlji5te2tcurbScknxSTCwFnnqqO4bGiLpPh/WgHdbuE
 xvKBOKsIzKSUuYF5QcqIjYp/atdLMnmA98L8JZf/880NPbww+vBBRjgbkjKGiU0TIBns
 6jgrrnbgIo5hl/maHv2MUKwuda9g0pOpOxjafuUWMqxyxN8Emsv5Sk8ATBqCKLuTNDlA Iw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2ydcsnx7d7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Feb 2020 01:57:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01T1qG1p164923;
        Sat, 29 Feb 2020 01:57:25 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2ydj4scqc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Feb 2020 01:57:25 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01T1vOdM023535;
        Sat, 29 Feb 2020 01:57:24 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Feb 2020 17:57:23 -0800
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCHv8 00/13] scsi: remove legacy cmd_list implementation
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200228075318.91255-1-hare@suse.de>
Date:   Fri, 28 Feb 2020 20:57:21 -0500
In-Reply-To: <20200228075318.91255-1-hare@suse.de> (Hannes Reinecke's message
        of "Fri, 28 Feb 2020 08:53:05 +0100")
Message-ID: <yq1zhd25f5q.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9545 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=803 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002290009
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9545 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=882 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002290009
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Hannes,

> with the switch to blk-mq we have an efficient way of looking up
> outstanding commands via blk_mq_rq_busy_iter().  In this patchset the
> dpt_i2o and aacraid drivers are switched over to using that function,
> and the now obsolete cmd_list implemantation in the SCSI midlayer is
> removed.

Applied to 5.7/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

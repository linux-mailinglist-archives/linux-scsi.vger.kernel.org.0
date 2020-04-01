Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5780C19A380
	for <lists+linux-scsi@lfdr.de>; Wed,  1 Apr 2020 04:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731573AbgDACTn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 31 Mar 2020 22:19:43 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53614 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731531AbgDACTn (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 31 Mar 2020 22:19:43 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0312IvIo123559;
        Wed, 1 Apr 2020 02:19:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=FR49b5NrbL3JhNS22ohhCf0XcURhVtOPk+rA1ljUpA4=;
 b=Jy2K6J1W1A2k/eP6EQtoq5VvPekObCLHAMm0+KZuObjwcf36YjfvwjzvdycLvJBXqyTS
 TRI4ANlaBtmTciDTu2+YlMNVqnutZKa7q4BB1N99SHNMsfDmn/L9N0t/+jb9A+QBPn1H
 3wgcJQibtFn1fZy/Pfw8nhVkjrJ3NubSQK+nxCQJ6KmfuKcsQxhtHAXNaOtuNpapCd48
 XbINmDg665htT2Lhrpw7Cv4l27OB0qiruYZeB4E6M0ip5OWqcK380y/USCX6P00MLeSz
 sA5J4nR+3OIkRRc1mHd/eK0aCPgwkzgJWwI8JnGQOt+EpAiJd5LWwlVfPrnpY4/Dl2WQ NQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 303yun5cxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Apr 2020 02:19:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0312IDru043448;
        Wed, 1 Apr 2020 02:19:40 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 302g4sp0qj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Apr 2020 02:19:40 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0312JeLi028403;
        Wed, 1 Apr 2020 02:19:40 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 31 Mar 2020 19:19:39 -0700
To:     Nilesh Javali <njavali@marvell.com>
Cc:     <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: Re: [PATCH v3 0/3] qla2xxx: Updates for the driver
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200331104015.24868-1-njavali@marvell.com>
Date:   Tue, 31 Mar 2020 22:19:32 -0400
In-Reply-To: <20200331104015.24868-1-njavali@marvell.com> (Nilesh Javali's
        message of "Tue, 31 Mar 2020 03:40:12 -0700")
Message-ID: <yq1v9mk54nf.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9577 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=862 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004010019
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9577 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 mlxlogscore=920 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004010019
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Nilesh,

> Please apply the qla2xxx driver bug fixes to the scsi tree at your
> earliest convenience.

Applied to 5.7/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

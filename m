Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E7A2856AC
	for <lists+linux-scsi@lfdr.de>; Wed,  7 Oct 2020 04:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgJGCgv (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 6 Oct 2020 22:36:51 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53376 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgJGCgv (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 6 Oct 2020 22:36:51 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0972Xtdu056669;
        Wed, 7 Oct 2020 02:36:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=Vw9XeN8U7dshffzjpTZYMBIn2glzxgOUF6U0stpDM9Q=;
 b=XwfkYDeIxUWFHGEJ9N1eWdyjvop6laSotGfKhNl7QzBS1XgWPSFKF9s9fZv+luwRRpzZ
 k7j3odj+8zhy6x6fn49oEL8UOWPqlLnmWfbxxKUS+yP3FVRNAAlgW+Ge47j2pNuZvnU4
 TEb2SIok+IAV1j1W/YXWkGvmbNivH2QkzFWL3aCE0X9DRfvC8exH38yKKSZz0WTL98a7
 tGPAm/79e54x4ObZdF8uNCtrRfMsyQ5ebkwPZkswYOigZWC/y/T7Ab8IxiQPyeOA4lIe
 6DtJN1dEGoWdKhnreopSY8ZsuAOSpNV7md30WP55cw8mxhS+iCe6jlQDWk9jtqhxsFVP 4A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 33xhxmy8ut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 07 Oct 2020 02:36:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0972Upf6053092;
        Wed, 7 Oct 2020 02:36:44 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 3410jy0ye5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Oct 2020 02:36:43 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0972adkW026821;
        Wed, 7 Oct 2020 02:36:41 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 06 Oct 2020 19:36:39 -0700
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 04/10] scsi: simplify varlen CDB length checking
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1362q7p2t.fsf@ca-mkp.ca.oracle.com>
References: <20201005084130.143273-1-hch@lst.de>
        <20201005084130.143273-5-hch@lst.de>
        <7f975da0-e793-ff23-064e-a4cf91396b09@acm.org>
Date:   Tue, 06 Oct 2020 22:36:37 -0400
In-Reply-To: <7f975da0-e793-ff23-064e-a4cf91396b09@acm.org> (Bart Van Assche's
        message of "Mon, 5 Oct 2020 09:06:48 -0700")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9766 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=974 spamscore=0
 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=1 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010070015
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9766 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=1 phishscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010070015
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Bart,

> I'm OK with removing struct scsi_varlen_cdb_hdr but not with the
> removal of the scsi_varlen_cdb_length() function. I'd like to keep
> that function because I think it makes code that handles variable
> length CDBs easier to read.

I agree. Please drop the header and simplify the wrapper function.

-- 
Martin K. Petersen	Oracle Linux Engineering

Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3A4F2EA05
	for <lists+linux-scsi@lfdr.de>; Thu, 30 May 2019 03:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfE3BEy (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 21:04:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34372 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbfE3BEy (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 29 May 2019 21:04:54 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U0xNZu144962;
        Thu, 30 May 2019 01:04:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=q9y3OJ7f5W1IqKJkvZlHc7EPJAT1QTPpfyKKp+FUUyw=;
 b=LgwsQqC02Jfyokvj5LFQTtjSgMVtUZWzp1zdBhHoK5WocAziKLV16Bq7u4mj5lILCExx
 cMO+aN5fmSCYiMTnmCOBEZazCprh5kTadRxf++jav2NGWsCb3sfKjo5HjyovrR/RcKLc
 Eqrl9YyW1LocFsFhAYWRcGqVis3a+tir2/DfqDXNBEwy3WstsDD+nz5Ggn6cK7HXobAk
 +xUDzQq+79pbc4JlGQB8xPfatxZt2xfYo6r/oFE4KLS9kM1TB4qm1+2kROJ0O6aTBJr2
 dGULb/hLnZWdhW33ZWDEXQGy+naoLFPmCJwIO8MQPSO3uyQS5nfv4UD2K1OgVK5VAvO4 1w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2spxbqd2er-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 01:04:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U13NA5012757;
        Thu, 30 May 2019 01:04:51 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2ss1fnsddd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 01:04:51 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4U14oxU030998;
        Thu, 30 May 2019 01:04:50 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 May 2019 18:04:50 -0700
To:     Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
Cc:     linux-scsi@vger.kernel.org, Sathya.Prakash@broadcom.com,
        sreekanth.reddy@broadcom.com
Subject: Re: [PATCH v2 06/10] mpt3sas:save msix index and use same while posting RD
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190520102604.3466-1-suganath-prabu.subramani@broadcom.com>
        <20190520102604.3466-7-suganath-prabu.subramani@broadcom.com>
Date:   Wed, 29 May 2019 21:04:48 -0400
In-Reply-To: <20190520102604.3466-7-suganath-prabu.subramani@broadcom.com>
        (Suganath Prabu S.'s message of "Mon, 20 May 2019 06:26:00 -0400")
Message-ID: <yq1k1e821n3.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=716
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905300006
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=758 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905300006
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Suganath,

> +static u8
> +_base_set_and_get_msix_index(struct MPT3SAS_ADAPTER *ioc, u16 smid)
> +{
> +	struct scsiio_tracker *st;
> +
> +	st = (smid < ioc->hi_priority_smid) ?
> +		(_get_st_from_smid(ioc, smid)) : (NULL);

Please make this an if statement for clarity.

> +
> +	if (st == NULL)
> +		return  _base_get_msix_index(ioc, NULL);
> +
> +	st->msix_io = ioc->get_msix_index_for_smlio(ioc, st->scmd);
> +	return st->msix_io;
> +}

-- 
Martin K. Petersen	Oracle Linux Engineering

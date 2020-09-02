Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B2525A297
	for <lists+linux-scsi@lfdr.de>; Wed,  2 Sep 2020 03:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgIBBV6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 1 Sep 2020 21:21:58 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49732 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbgIBBV6 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 1 Sep 2020 21:21:58 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0821KNPU182923;
        Wed, 2 Sep 2020 01:21:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=PjrY0eS9HukXy0OzFwPAzApjOa0hd3dQBC1T+ToDQQs=;
 b=Jjl7vs5r4xTrkxv0656lTc3NqpUyP3oKSO7MhsB/3r6x4ZFY+zCrguFhgETC5ormmj+M
 vWwNUP8xDTGplHxtHXgzxkXU+D8LnppcxahESI0dhdt9dypNcbOTyPPpvvdvFoaeB3Zy
 s2taxpdBT0oUOZ6KEcLP72cNtWA61toPDyVsyH/ZSERnR6mPOKst4P/ZjLMZFgbtdrxP
 K4kfDnF9D/9RiI0dIL3N2w5j48At/pSi2Gd2q0MLT92zWFog6yVwtA/f2rvhRzCO3r3M
 bmq+IIdOLrFSmwCDP/aQBOE1Hn7b5xphE1+WRARTyEMT1gkO+pimLWqSa8a6GBMV7GK+ BA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 339dmmx2u6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 02 Sep 2020 01:21:52 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0821FGP2123785;
        Wed, 2 Sep 2020 01:19:52 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 3380ssw86b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Sep 2020 01:19:52 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0821Jofa004560;
        Wed, 2 Sep 2020 01:19:50 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Sep 2020 18:19:50 -0700
To:     Viswas G <Viswas.G@microchip.com.com>
Cc:     <linux-scsi@vger.kernel.org>,
        <Vasanthalakshmi.Tharmarajan@microchip.com>,
        <Viswas.G@microchip.com>, <deepak.ukey@microchip.com>,
        <martin.petersen@oracle.com>, <yuuzheng@google.com>,
        <auradkar@google.com>, <vishakhavc@google.com>,
        <bjashnani@google.com>, <radha@google.com>, <akshatzen@google.com>
Subject: Re: [PATCH v8 1/2] pm80xx : Support for get phy profile functionality.
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1pn75f09i.fsf@ca-mkp.ca.oracle.com>
References: <20200820185123.27354-1-Viswas.G@microchip.com.com>
        <20200820185123.27354-2-Viswas.G@microchip.com.com>
Date:   Tue, 01 Sep 2020 21:19:47 -0400
In-Reply-To: <20200820185123.27354-2-Viswas.G@microchip.com.com> (Viswas G.'s
        message of "Fri, 21 Aug 2020 00:21:22 +0530")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9731 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009020008
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9731 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=1
 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009020009
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Viswas,

> Added the support to get the phy profile which gives information about
> the phy states, port and errors on phy.

Where are these parameters made visible?

Also, why not make the phy_errcnt members __le32 instead of using
__force?

+		} else if (page_code == SAS_PHY_ERR_COUNTERS_PAGE) {
+			phy_err = (struct phy_errcnt *)ccb->resp_buf;
+			phy_err_cnt =
+			(struct phy_errcnt *)pPayload->ppc_specific_rsp;
+			phy_err->InvalidDword =
+			le32_to_cpu((__force __le32)phy_err_cnt->InvalidDword);
+			phy_err->runningDisparityError = le32_to_cpu
+			((__force __le32)phy_err_cnt->runningDisparityError);
+			phy_err->LossOfSyncDW = le32_to_cpu
+			((__force __le32)phy_err_cnt->LossOfSyncDW);
+			phy_err->phyResetProblem = le32_to_cpu
+			((__force __le32)phy_err_cnt->phyResetProblem);
+		}

-- 
Martin K. Petersen	Oracle Linux Engineering

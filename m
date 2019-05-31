Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5EEE316DE
	for <lists+linux-scsi@lfdr.de>; Sat,  1 Jun 2019 00:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfEaWAU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 31 May 2019 18:00:20 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:48323 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfEaWAU (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 31 May 2019 18:00:20 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Dave.Carroll@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Dave.Carroll@microchip.com";
  x-sender="Dave.Carroll@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Dave.Carroll@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Dave.Carroll@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.60,536,1549954800"; 
   d="scan'208";a="35735205"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 May 2019 15:00:19 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex01.mchp-main.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 31 May 2019 14:59:56 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 31 May 2019 14:59:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1MxD+xM2ViDvjI2x5GZoalknKISlaqYp2wwU12P55k=;
 b=la5ma7kc10XN7JGz6u27SmYar0Z/L3JjqqmJfnNSqjJLPF72vp/8JISzGKJIvYKbRo5G/FnkbgV1VZdOSWL9jAKcZlCMLPSEKcJCYUrt+lfx2br+Z8OS1RdP6gn1sjkQaPUxaUXUnHne3w92at0HTGtgp7dl64DnaHc1womTgrY=
Received: from BYAPR11MB3447.namprd11.prod.outlook.com (20.177.186.216) by
 BYAPR11MB2773.namprd11.prod.outlook.com (52.135.228.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.18; Fri, 31 May 2019 21:57:54 +0000
Received: from BYAPR11MB3447.namprd11.prod.outlook.com
 ([fe80::241c:990:9ff6:f0cf]) by BYAPR11MB3447.namprd11.prod.outlook.com
 ([fe80::241c:990:9ff6:f0cf%7]) with mapi id 15.20.1922.024; Fri, 31 May 2019
 21:57:54 +0000
From:   <Dave.Carroll@microchip.com>
To:     <hare@suse.de>, <martin.petersen@oracle.com>
CC:     <hch@lst.de>, <james.bottomley@hansenpartnership.com>,
        <linux-scsi@vger.kernel.org>, <hare@suse.com>
Subject: RE: [PATCH 19/24] aacraid: move scsi_add_host()
Thread-Topic: [PATCH 19/24] aacraid: move scsi_add_host()
Thread-Index: AQHVFo4eWW8VmoeXuEaXYamLhaE6dqaFyJZQ
Date:   Fri, 31 May 2019 21:57:54 +0000
Message-ID: <BYAPR11MB3447A5C257959C53C8A017A188190@BYAPR11MB3447.namprd11.prod.outlook.com>
References: <20190529132901.27645-1-hare@suse.de>
 <20190529132901.27645-20-hare@suse.de>
In-Reply-To: <20190529132901.27645-20-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [207.109.165.140]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d030170d-d825-4160-60f1-08d6e61308ea
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR11MB2773;
x-ms-traffictypediagnostic: BYAPR11MB2773:
x-microsoft-antispam-prvs: <BYAPR11MB277341BA7615726B9510D93C88190@BYAPR11MB2773.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(136003)(366004)(396003)(189003)(199004)(13464003)(4326008)(53936002)(99286004)(33656002)(54906003)(25786009)(26005)(256004)(186003)(7696005)(76176011)(53546011)(6506007)(55016002)(305945005)(71200400001)(7736002)(71190400001)(9686003)(73956011)(66446008)(64756008)(66556008)(102836004)(76116006)(66946007)(68736007)(66476007)(6246003)(8936002)(229853002)(2906002)(52536014)(66066001)(81166006)(81156014)(8676002)(5660300002)(86362001)(476003)(478600001)(446003)(486006)(11346002)(74316002)(6436002)(14454004)(316002)(72206003)(3846002)(6116002)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB2773;H:BYAPR11MB3447.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: icgVqDVGQ2UAj8Pb2ZzUvG7iJR/QOGUeVOr5PHp/auXnDnqwi2Rm3f1BT8d4nO4NxPDv7hrr5+uZjefr+1qupOdc/Zq0BXW/QM1NT/9XiIb6YmmHwYLwXRUAWkMdlRnve8SXCW48mHTlc3cIQuqVIVrsoLYtU761SLO6B0ggBIQOmp05cz8cMf6WV8Ej1g6DLTD/17LwrOGvHP098zcBcoqrcYpDxtNFifE67ftOc4pkvO6nMsgnrDK3hXI8x07ARLNnxJpED54eUiaQUYxM0FwIcYMUmfq1zHLZgHl0QR4uzJmYqot5mnMoRXsPoKNUa+7Ur0GB1IWO16g9eEyfZcJTI8spUjbHjy2KbddOqpEyMdcv2NZ/wMgT5ohudoLpWhCFOWuk0VleqNk2qBmqV/ng8sSFmwU5iCvG6bFnkDY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d030170d-d825-4160-60f1-08d6e61308ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 21:57:54.6399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dave.Carroll@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2773
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

> -----Original Message-----
> From: linux-scsi-owner@vger.kernel.org [mailto:linux-scsi-
> owner@vger.kernel.org] On Behalf Of Hannes Reinecke
> Sent: Wednesday, May 29, 2019 7:29 AM
> To: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Christoph Hellwig <hch@lst.de>; James Bottomley
> <james.bottomley@hansenpartnership.com>; linux-scsi@vger.kernel.org;
> Hannes Reinecke <hare@suse.de>; Hannes Reinecke <hare@suse.com>
> Subject: [PATCH 19/24] aacraid: move scsi_add_host()
>=20
> Move the call to scsi_add_host() so that the Scsi_Host structure is initi=
alized
> before any I/O is sent.
>=20
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/scsi/aacraid/linit.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/scsi/aacraid/linit.c b/drivers/scsi/aacraid/linit.c =
index
> 8e28a505f7e8..71d97881fc26 100644
> --- a/drivers/scsi/aacraid/linit.c
> +++ b/drivers/scsi/aacraid/linit.c
> @@ -1669,6 +1669,9 @@ static int aac_probe_one(struct pci_dev *pdev,
> const struct pci_device_id *id)
>  	shost->unique_id =3D unique_id;
>  	shost->max_cmd_len =3D 16;
>  	shost->use_cmd_list =3D 1;
> +	shost->max_id =3D MAXIMUM_NUM_CONTAINERS;
> +	shost->max_lun =3D AAC_MAX_LUN;
> +	shost->sg_tablesize =3D HBA_MAX_SG_SEPARATE;
>=20
>  	if (aac_cfg_major =3D=3D AAC_CHARDEV_NEEDS_REINIT)
>  		aac_init_char();
> @@ -1731,6 +1734,10 @@ static int aac_probe_one(struct pci_dev *pdev,
> const struct pci_device_id *id)
>  		goto out_deinit;
>  	}
>=20
> +	error =3D scsi_add_host(shost, &pdev->dev);
> +	if (error)
> +		goto out_deinit;
> +
>  	aac->maximum_num_channels =3D aac_drivers[index].channels;
>  	error =3D aac_get_adapter_info(aac);

Hi Hannes,

I think this will be problematic, as the get_adapter_info() call gets a num=
ber of parameters from the controller, namely

	- can_queue
	- sg_tablesize

From the sync command GET_PREFERRED_SETTINGS.

In looking at scsi_add_host(), it sets up the tags with input from those va=
lues. I'm still reviewing the others, but that was why the scsi_add_host wa=
s delayed.

Thanks, -Dave
=20

